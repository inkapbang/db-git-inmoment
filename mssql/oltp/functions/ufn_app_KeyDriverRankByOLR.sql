SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_KeyDriverRankByOLR](@modelId int, @locationId int, @beginDate datetime, @endDate datetime)
returns @results table(
	driverFieldObjectId int primary key,
	driverResponseCount int,
	olrRank int,
	baseAvg float,
	baseStdev float,
	newDriverAvg float,
	newDriverStdev float,
	performanceZscore FLOAT,
	beginDate datetime,
	minResponseCount int
)
/*
	Based on a given Key Driver Uplift Model, this procedure ranks drivers based on an Ordinal Logistic Regression.
	In short, this works by:
	1. Based on a preference between consistency and performance, calculate a target angle to represent the preference
		a. Do this by allocating 10 points between the two and taking the arctan of the points
		b. angle = arctan(consistency points / performance points)
	2. Convert the score field (dependent variables) and driver fields (independent variables) to ordinal values (i.e. 1.0-5.0)
	3. Run an ordinal logistic regression to determine intercepts and coefficients for the score and drivers.
	4. Find the average and stdev of the ordinal dependent variable
	4. For each driver, recalculate the ordinal rank (x) by:
		a. Find the probability P of moving x to x+1
			i. N=exp(intercept[x] + driver[x])
			ii. P=N/(1+N)
		b. New Rank = (x + 1)*P + x*(1-P)
	5. Compute the new mean and standard deviation of this new score
	7. Standardize the changes into a new "Z-Score"
		a. Performance score for each driver = (avg(newDriverRank) - baseAvg) / baseStdev
		b. Consistency score for each driver = sqrt(2 * n) * (baseStdev - stdev(newDriverRank)) / baseStdev
			i. n is the count of the rows in the location data set
	8. Calculate the angle for each driver
		a. Angle(driver) = arctan(consistency score / performance score
	9. Rank the drivers by which is closest to the target angle (abs(dif))
*/
as
begin
	-- Lookup model parameters for OLR
	declare @scoreFieldId int, @feedbackChannelId int, @maxDaysBack int, @maxBackBeginDate datetime, @minResponseCount int, @slidingDateWindowMinResponseCount int
	select
		@scoreFieldId = model.regressionPerformanceIndicatorFieldObjectId,
		@feedbackChannelId = model.channelObjectId,
        @maxDaysBack = CASE WHEN strategy.thresholdType = 2 THEN NULL ELSE strategy.slidingDateWindowMaxDays END,
        @minResponseCount = strategy.minimumResponseCount,
        @slidingDateWindowMinResponseCount = CASE WHEN strategy.thresholdType = 2 THEN NULL ELSE strategy.slidingDateWindowMinResponseCount END
	from
		UpliftModel model
		join UpliftModelStrategy strategy
                        on strategy.objectId = model.upliftModelStrategyObjectId
	where
		model.objectId = @modelId;
		
	--sliding window daterange
	IF @maxDaysBack is not null and @slidingDateWindowMinResponseCount is not null
	BEGIN
                set @maxBackBeginDate = DATEADD(day,-@maxDaysBack,@beginDate);
                set @minResponseCount = @slidingDateWindowMinResponseCount;
                
                select 
                       @beginDate = 
                       CASE WHEN max(beginDate) is null
                               THEN @maxBackBeginDate
                               ELSE
                               CASE WHEN max(beginDate) <= @beginDate 
                                       THEN max(beginDate)
                                       ELSE @beginDate
                               END
                       END
                from (
                        SELECT
                                sr.beginDate beginDate
                                ,count(sr.objectId) responseCount
                               ,(
                                select count(sr1.objectId) 
                                from surveyresponse sr1 
                                join Offer o1
                                        on sr1.offerObjectId = o1.objectId
                                        and o1.channelObjectId = @feedbackChannelId
                                join SurveyResponseScore score1
									on score1.surveyResponseObjectId = sr1.objectId
									and score1.dataFieldObjectId = @scoreFieldId
                                where sr1.beginDate between sr.beginDate and @endDate 
                                and sr1.complete = 1 and sr1.locationObjectId = @locationId and sr1.exclusionReason = 0) runningTotal
                        from
                                SurveyResponse sr
                        	join Offer o
								ON o.objectId = sr.offerObjectId
								AND o.channelObjectId = @feedbackChannelId
                            join SurveyResponseScore score
								on score.surveyResponseObjectId = sr.objectId
								and score.dataFieldObjectId = @scoreFieldId
                        where
                                sr.beginDate between @maxBackBeginDate and @endDate
                                and sr.complete = 1
                                and sr.locationObjectId = @locationId
                                and sr.exclusionReason = 0 
                        group by sr.beginDate) responseCounts
                where responseCounts.runningTotal >= @minResponseCount		
        END
    
	
	--setup scores table
	declare @locationIdList IntList
	insert into @locationIdList select @locationId val
	
	declare @scoreFieldIdList IntList
	insert into @scoreFieldIdList select @scoreFieldId val
	
	declare @Scores TABLE (
		locationObjectId int,
		surveyResponseObjectId int, 
		dataFieldObjectId int,
		score float, 
		[count] int, 
		primary key (surveyResponseObjectId))
	insert into @Scores
	select * from ufn_app_getRecommendationScoresTableByLocation(@modelId, @locationIdList, @beginDate, @endDate, @scoreFieldIdList)    

	-- Find the regression group for this location
	declare @regressionId int
	select @regressionId = dbo.ufn_app_KeyDriverFindRegression(@modelId, @locationId)
	
	declare @ordinalModel int
	select @ordinalModel = ordinalModelObjectId from UpliftModelRegression where objectId = @regressionId
	
	declare @Intercept table (dataFieldObjectId int, ordinalLevel int , intervalMin float, intervalMax float, [value] float, primary key (dataFieldObjectId, ordinalLevel))
	insert into @Intercept
		select
			[param].dataFieldObjectId,
			[param].ordinalLevel,
			interval.minValue intervalMin,
			interval.maxValue intervalMax,
			[param].value
		from
			UpliftModelRegressionParam [param]
			join DataFieldOrdinalInterval interval
				on interval.dataFieldOrdinalModelObjectId = @ordinalModel
				and interval.ordinalLevel = [param].ordinalLevel
		where
			[param].regressionObjectId = @regressionId
			and [param].paramType = 0 -- intercept
			and [param].dataFieldObjectId = @scoreFieldId;

	declare @Coefficient table (id int IDENTITY(1,1) PRIMARY KEY, dataFieldObjectId int, dataFieldOptionObjectId int, ordinalLevel int, [value] float)
	insert into @Coefficient
		select
			[param].dataFieldObjectId,
			dfo.objectId dataFieldOptionObjectId,
			[param].ordinalLevel,
			[param].value
		from
			UpliftModelRegressionParam [param]
			left join DataFieldOption dfo
				on dfo.dataFieldObjectId = [param].dataFieldObjectId
				and dfo.ordinalLevel = [param].ordinalLevel
		where
			[param].regressionObjectId = @regressionId
			and [param].paramType = 1; -- coefficient

	-- for issue #19408
	declare @maxInterceptLevel int
	select @maxInterceptLevel = max(ordinalLevel) from @Intercept

	declare @MaxCoefficient table (dataFieldObjectId int primary key, ordinalLevel int)
	insert into @MaxCoefficient
		select
			dataFieldObjectId,
			max(ordinalLevel) ordinalLevel
		from
			@Coefficient
		group by dataFieldObjectId;

	with Data as (
		(
			SELECT
				sr.objectId,
				intercept.ordinalLevel * 1.0 interceptOrdinalLevel,
				intercept.value interceptValue,
				coefficient.dataFieldObjectId driverFieldObjectId,
				coefficient.ordinalLevel * 1.0 coefficientOrdinalLevel,
				coefficient.value coefficientValue,
				-- set N to zero when intercept or coefficient level is max
				case when intercept.ordinalLevel = @maxInterceptLevel or
						coefficient.ordinalLevel = maxCoefficient.ordinalLevel then 0
				else exp(coefficient.value)
				end N
			from
				(SurveyResponse sr
				JOIN Offer o
					ON o.objectId = sr.offerObjectId
					AND channelObjectId = @feedbackChannelId)
				join @Scores score
					on score.surveyResponseObjectId = sr.objectId
					and score.dataFieldObjectId = @scoreFieldId
				join @Intercept intercept
					on intercept.dataFieldObjectId = score.dataFieldObjectId
					and score.score >= Intercept.intervalMin and score.score < Intercept.intervalMax
				join SurveyResponseAnswer sra
					on sra.surveyResponseObjectId = sr.objectId
				join @Coefficient coefficient
					on coefficient.dataFieldOptionObjectId = sra.dataFieldOptionObjectId
				join @MaxCoefficient maxCoefficient
					on maxCoefficient.dataFieldObjectId = coefficient.dataFieldObjectId
			where
				sr.beginDate between @beginDate and @endDate
				and sr.complete = 1
				and sr.locationObjectId = @locationId
				and sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
		)
		union
		(
			SELECT
				sr.objectId,
				intercept.ordinalLevel * 1.0 interceptOrdinalLevel,
				intercept.value interceptValue,
				coefficient.dataFieldObjectId driverFieldObjectId,
				coefficient.ordinalLevel * 1.0 coefficientOrdinalLevel,
				coefficient.value coefficientValue,
				-- set N to zero when intercept or coefficient level is max
				case when intercept.ordinalLevel = @maxInterceptLevel or
						coefficient.ordinalLevel = maxCoefficient.ordinalLevel then 0
				else exp(coefficient.value)
				end N
			from
				(SurveyResponse sr
				JOIN Offer o
					ON o.objectId = sr.offerObjectId
					AND channelObjectId = @feedbackChannelId)
				join @Scores score
					on score.surveyResponseObjectId = sr.objectId
					and score.dataFieldObjectId = @scoreFieldId
				join @Intercept intercept
					on intercept.dataFieldObjectId = score.dataFieldObjectId
					and score.score >= Intercept.intervalMin and score.score < Intercept.intervalMax
				join @Scores srs
					on srs.surveyResponseObjectId = sr.objectId
				join UpliftModelPerformanceAttribute umpa
					on umpa.fieldObjectId = srs.dataFieldObjectId
					and umpa.modelObjectId = @modelId
				join DataFieldOrdinalInterval dfoi
					on dfoi.dataFieldOrdinalModelObjectId = umpa.ordinalModelObjectId
					and srs.score >= dfoi.minValue 
					and srs.score < dfoi.maxValue
				join @Coefficient coefficient
					on coefficient.dataFieldObjectId = srs.dataFieldObjectId
					and coefficient.dataFieldOptionObjectId is null
					and coefficient.ordinalLevel = dfoi.ordinalLevel					
				join @MaxCoefficient maxCoefficient
					on maxCoefficient.dataFieldObjectId = coefficient.dataFieldObjectId
			where
				sr.beginDate between @beginDate and @endDate
				and sr.complete = 1
				and sr.locationObjectId = @locationId
				and sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
		)
	),
	Prob as (
		select
			*,
			N / (1.0 + N) P
		from
			Data
	),
	NewRank as (
		select 
			*,
			((interceptOrdinalLevel + 1.0) * P) + (interceptOrdinalLevel * (1.0 - P)) newInterceptOrdinalLevel
		from
			Prob
	),
	ZScore as (
		select
			driverFieldObjectId,
			count(*) driverResponseCount,
			AVG(coefficientOrdinalLevel) driverAvgRating,
			avg(interceptOrdinalLevel) baseAvg,
			stdev(interceptOrdinalLevel) baseStdev,
			avg(newInterceptOrdinalLevel) newDriverAvg,
			stdev(newInterceptOrdinalLevel) newDriverStdev,
			(avg(newInterceptOrdinalLevel) - AVG(interceptOrdinalLevel)) / CASE WHEN STDEV(interceptOrdinalLevel) = 0.0 THEN 0.0000001 ELSE STDEV(interceptOrdinalLevel) END performanceZscore
		from
			NewRank
		group by
			NewRank.driverFieldObjectId
	)
	insert into @results
	select
		driverFieldObjectId,
		driverResponseCount,
		rank() over (order by newDriverAvg DESC, driverAvgRating ASC) olrRank,
		baseAvg,
		baseStdev,
		newDriverAvg,
		newDriverStdev,
		performanceZscore,
		@beginDate,
		@minResponseCount
	from
		ZScore
	where
	       driverResponseCount >= @minResponseCount
	order by
		olrRank
	return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
