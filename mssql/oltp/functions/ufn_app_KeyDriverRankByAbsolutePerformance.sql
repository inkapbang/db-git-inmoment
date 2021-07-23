SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[ufn_app_KeyDriverRankByAbsolutePerformance](@modelId int, @locationId int, @locationCategoryId int, @beginDate datetime, @endDate datetime)
returns @results table (
	driverFieldObjectId int,
	responseCount int,
	avgScore float,
	peerRank int,
	peerCount int,
	driverPeerRank int,
	driverScoreRank int
)
/*
        Ranks a specified location within its peer group by absolute performance.  Returns the score for each driver,
        plus the relative rank within the peer group.
*/
as
begin

        declare @aggregationType int, @thresholdType int, @minResponseCount int, @feedbackChannelId int, @scoreFieldId int;

        select
				@aggregationType = strategy.aggregationType,
				@thresholdType = strategy.thresholdType,
                @minResponseCount = strategy.minimumResponseCount,
                @feedbackChannelId = model.channelObjectId,
                @scoreFieldId = model.performanceIndicatorFieldObjectId
        from
                UpliftModel model
                join UpliftModelStrategy strategy
                        on strategy.objectId = model.upliftModelStrategyObjectId
        where
                model.objectId = @modelId;

				
		declare @scoreFieldIdList IntList
		insert into @scoreFieldIdList select @scoreFieldId val
				
		declare @CategoryLocations IntList
		INSERT INTO @CategoryLocations 
		SELECT cl.locationObjectId FROM dbo.GetCategoryLocations(@locationCategoryId) cl

-- restructure: create table var with primary key to assist with join syntax in next step
declare @RecommendationScoresTableByLocation table (locationObjectId int,surveyResponseObjectId int primary key,dataFieldObjectId int,score int,count int)
insert into @RecommendationScoresTableByLocation
select * from ufn_app_getRecommendationScoresTableByLocation(@modelId, @CategoryLocations, @beginDate, @endDate, @scoreFieldIdList)

        declare @peers IntList

        IF @locationCategoryId is not null
			insert into @peers
			SELECT
				cl.val
			FROM
				@CategoryLocations cl
					JOIN Location l -- filter the Hidden Locations
						ON l.objectId = cl.val
						AND l.hidden = 0
					JOIN SurveyResponse sr
						ON sr.locationObjectId = cl.val
					JOIN Offer o
						ON o.objectId = sr.offerObjectId
							AND channelObjectId = @feedbackChannelId
							AND sr.beginDate BETWEEN @beginDate AND @endDate
							AND sr.complete = 1
							AND sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
					-- restructure: remove embedded call to function with table var
					--JOIN ufn_app_getRecommendationScoresTableByLocation(@modelId, @CategoryLocations, @beginDate, @endDate, @scoreFieldIdList) srs
					join @RecommendationScoresTableByLocation srs
						on srs.surveyResponseObjectId = sr.objectId
			GROUP BY
				cl.val
			HAVING
				COUNT(sr.objectId) >= COALESCE(CASE WHEN @aggregationType = 2 AND @thresholdType IN (0, 2) THEN 0 ELSE @minResponseCount END, 0)
        ELSE
			insert into @peers select @locationId val

        declare @peerCount int
        select @peerCount = count(val) from @peers

		
		declare @driverFieldIds IntList
		insert into @driverFieldIds
		select driver.fieldObjectId 
		from UpliftModelPerformanceAttribute driver
		where driver.modelObjectId = @modelId and driver.attributeRole = 0

        insert into @results
        select
                driverFieldId,
                responseCount,
                avgScore,
                peerRank,
                @peerCount,
                rank() over (order by peerRank desc) driverPeerRank,
                rank() over (order by avgScore) driverScoreRank
        from (
                select
                        locationId,
                        driverFieldId,
                        responseCount,
                        avgScore,
                        rank() over (partition by driverFieldId order by avgScore desc) peerRank
                from (
					select
						locationId,
						driverFieldId,
						avg(score) as avgScore,
						count(1) as responseCount
					from(
							select 
								answerDetail.locationId as locationId,
								driver.fieldObjectId as driverFieldId,
								answerDetail.score as score
							from
								UpliftModelPerformanceAttribute driver
								left outer join 
								(
									select
										r.responseId,
										r.locationId,
										r.answerFieldId,
										dfo.scorePoints score
									from @peers peers
										join
												ResponseAnswerView r
												on r.locationId = peers.val
												and r.beginDate between @beginDate and @endDate
												and r.complete = 1
												AND r.channelId = @feedbackChannelId
												and r.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
										join DataFieldOption dfo
												on dfo.objectId = r.answerCategoricalId
										join ufn_app_getRatingCounts(@peers, @feedbackChannelId, @beginDate, @endDate) rc
											on rc.locationObjectId = r.locationId
												and rc.dataFieldObjectId = r.answerFieldId
												and rc.[count] >= COALESCE(CASE WHEN @aggregationType = 2 AND @thresholdType IN (0, 2) THEN @minResponseCount ELSE 0 END, 0)
										join @driverFieldIds dfi on dfi.val = rc.dataFieldObjectId
									union
									select
										sr.objectId responseId,
										sr.locationObjectId locationId,
										srs.dataFieldObjectId fieldObjectId,
										srs.score
									from @peers peers
										join SurveyResponse sr
											on sr.locationObjectId = peers.val
											and sr.beginDate between @beginDate and @endDate
											and sr.complete = 1
											and sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
										join Offer o
											on o.objectId = sr.offerObjectId
											and o.channelObjectId = @feedbackChannelId
										join ufn_app_getRecommendationScoresTableByLocation(@modelId, @peers, @beginDate, @endDate, @driverFieldIds) srs
											on srs.surveyResponseObjectId = sr.objectId
										join @driverFieldIds dfi on dfi.val = srs.dataFieldObjectId
								) answerDetail on answerDetail.answerFieldId = driver.fieldObjectId
									and	driver.modelObjectId = @modelId
									and driver.attributeRole = 0
						) as detail
					group by locationId, driverFieldId
					) Data
                ) ByLocation
        where
                locationId = @locationId
        order by
                driverFieldId, peerRank
        return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
