SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_mcd_rpt_DriverComparison]
	@locationId int,
	@locationCategoryId int,
	@periodId int,
	@contextDate datetime,
	@feedbackChannelId int,
	@localeKey nvarchar(20) = 'en_US'
as
begin
	set nocount on;
	
	DECLARE @currentPeriodBegin DATETIME, @currentPeriodEnd DATETIME, @previousPeriodBegin DATETIME, @previousPeriodEnd DATETIME

    SELECT
		@currentPeriodBegin = MIN(beginDate),
		@currentPeriodEnd = MAX(endDate)
		FROM dbo.PeriodIntervalRanges(@periodId, @contextDate, 'en_US')
		
--		PRINT @currentPeriodEnd
/*
    SELECT
		@previousPeriodBegin = MIN(beginDate),
		@previousPeriodEnd = MAX(endDate)
		FROM dbo.PeriodIntervalRanges(@periodId, DATEADD(DAY, -1, @currentPeriodBegin), '')
*/
--    PRINT 'Current Begin Date: ' + CONVERT(VARCHAR, @currentPeriodBegin, 101) + '  End Date:' + CONVERT(VARCHAR, @currentPeriodEnd, 101)
--    PRINT 'Previous Begin Date: ' + CONVERT(VARCHAR, @previousPeriodBegin, 101) + '  End Date:' + CONVERT(VARCHAR, @previousPeriodEnd, 101)
    
	select @contextDate = dateadd(s,-1,dateadd(mm, datediff(m,0,@currentPeriodEnd)+1,0)) --set to last day of month of currentPeriodEnd 11:59:59 pm

--	PRINT @contextDate
	
	declare @startTwoMoAgo datetime
	declare @startOneMoAgo datetime
	declare @startCurrentMo datetime
	declare @startNextMo datetime

	select @startTwoMoAgo = (dateadd(mm, datediff(mm,0,@contextDate)-2,0))
	select @startOneMoAgo = (dateadd(mm, datediff(mm,0,@contextDate)-1,0))
	select @startCurrentMo = (dateadd(mm, datediff(mm,0,@contextDate),0));
	select @startNextMo = (dateadd(mm, 1, @startCurrentMo));

	declare @peerLocations table (locationObjectId int not null primary key)
	insert into @peerLocations (locationObjectId)
		select locationObjectId from dbo.GetCategoryLocations(@locationCategoryId);

	with McField as (
		  select
				df.objectId fieldId,
				CASE
					--added _a, _b, _c to correctly sort QSC report
					when df.objectId in (25799,25800,25801) then 'mcd_c_Cleanliness'
					when df.objectId in (25796,25797,25798) then 'mcd_a_Quality'
					when df.objectId in (25793,25794,25795,25802,25803) then 'mcd_b_Service'
				end 
				driverGroupName,
				(select value from dbo.ufn_app_LocalizedStringTable(df.labelObjectId, @localeKey)) label
		  from
				DataField df
		  where
				df.objectId in (25796,25798,25797,25795,25802,25803,25793,25794,25799,25800,25801)     
	),
	McOption as (
		  select
				f.*,
				dfo.objectId optionId,
				ordinalLevel,
				case
					when count(*) over (partition by f.fieldId) = 2 then
						case when ordinalLevel = 1 then 1 else 0 end
					else
						case when ordinalLevel in (1,2) then 1 else 0 end
				end bottomBox
		  from
				McField f
				join DataFieldOption dfo
					on dfo.dataFieldObjectId = f.fieldId
					and dfo.objectId <> 69736 -- does not apply
	),
	McData as (
		  select
				sr.objectId,
				sr.beginDate,
				case when sr.beginDate >= @startCurrentMo and sr.beginDate < @startNextMo then 1 else 0 end  currentMo,
				case when sr.beginDate >= @startOneMoAgo and sr.beginDate < @startCurrentMo then 1 else 0 end oneMoAgo,
				case when sr.beginDate >= @startTwoMoAgo and sr.beginDate < @startOneMoAgo then 1 else 0 end twoMoAgo,
	            
				sr.locationObjectId,
				case when sr.locationObjectId = @locationId then 1 else 0 end isLocation,

				sra.objectId answerId,
				
				opt.driverGroupName,
				opt.label,
				opt.fieldId,
				opt.optionId,
				opt.ordinalLevel,
				opt.bottomBox
		  from
				SurveyResponse sr
				JOIN Offer o
					ON o.objectId = sr.offerObjectId
					AND channelObjectId = @feedbackChannelId
				join @peerLocations peer
					on peer.locationObjectId = sr.locationObjectId
				join SurveyResponseAnswer sra
					on sra.surveyResponseObjectId = sr.objectId
				join McOption opt
					--on opt.fieldId = sra.dataFieldObjectId
					on opt.optionId = sra.dataFieldOptionObjectId
		  where
				-- Filter by date and by complete
				sr.beginDate >= @startTwoMoAgo 
				and sr.beginDate < @startNextMo
				and sr.complete = 1
				and sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results

				-- Filter by Location/Unt
				--and oc.locationObjectId = @locationId
	)



	--select * from McData
	,
	McTotals as (
		select
			fieldId,
			driverGroupName,
			label,
			count(*) responseCount,
			sum(bottomBox) allMonthsCountBb, --this is only the count of bottom box

			sum(isLocation) locResponseCount,
			sum(case when isLocation = 1 and bottomBox = 1 then 1 else 0 end) locAllMonthsCountBb, --this is only the count of bottom box

			sum(case when isLocation = 1 and currentMo = 1 then 1 else 0 end) locCurrentCount,
			sum(case when isLocation = 1 and bottomBox = 1 and currentMo = 1 then 1 else 0 end) locCurrentMoBbCount,

			sum(case when isLocation = 1 and oneMoAgo = 1 then 1 else 0 end) locOneMoAgoCount,
			sum(case when isLocation = 1 and bottomBox = 1 and oneMoAgo = 1 then 1 else 0 end) locOneMoAgoBbCount,

			sum(case when isLocation = 1 and twoMoAgo = 1 then 1 else 0 end) locTwoMoAgoCount,
			sum(case when isLocation = 1 and bottomBox = 1 and twoMoAgo = 1 then 1 else 0 end) locTwoMoAgoBbCount
				
		from McData
		group by fieldId, driverGroupName, label
	),
	McCalcs as (
		select
			fieldId,
			driverGroupName,
			label,
			responseCount,
			allMonthsCountBb,
			isnull(allMonthsCountBb * 1.0 / nullif(responseCount, 0), -1) allMonthsBbPct,

			locCurrentCount,
			locCurrentMoBbCount,
			isnull(locCurrentMoBbCount * 1.0 / nullif(locCurrentCount, 0), -1) locCurrentMoBbPct,

			locOneMoAgoCount,
			locOneMoAgoBbCount,
			isnull(locOneMoAgoBbCount * 1.0 / nullif(locOneMoAgoCount, 0), -1) locOneMoAgoBbPct,

			locTwoMoAgoCount,
			locTwoMoAgoBbCount,
			isnull(locTwoMoAgoBbCount * 1.0 / nullif(locTwoMoAgoCount, 0), -1) locTwoMoAgoBbPct,

			isnull((locCurrentMoBbCount + locOneMoAgoBbCount + locTwoMoAgoBbCount) * 1.0 / nullif((locCurrentCount + locOneMoAgoCount + locTwoMoAgoCount), 0), -1) locAvgThreeMoTrail

		from
			  McTotals
	)
	--select * from McCalcs
	select 
		driverGroupName,
		label driverName,
		locTwoMoAgoBbPct twoMonthsAgoScore,
		locOneMoAgoBbPct oneMonthAgoScore,
		locCurrentMoBbPct lastMonthScore, 
		locAvgThreeMoTrail avgScore,
		CASE
			WHEN allMonthsBbPct = -1 --no surveys for region
				or locAvgThreeMoTrail = -1 THEN -1 --no surveys for the location, -1 signals to display to show NA or something like that
			ELSE abs(allMonthsBbPct - locAvgThreeMoTrail)
        end vsRegion,
        case 
			WHEN allMonthsBbPct = -1 --no surveys for region
				or locAvgThreeMoTrail = -1 --no surveys for location
				OR ABS(allMonthsBbPct - locAvgThreeMoTrail) < .0005 THEN -1 --if the difference between the two will round to 0.0, neither better or worse, -1 signals don't display icon
			WHEN locAvgThreeMoTrail < allMonthsBbPct then 1 
			else 0
        end better 
		
	from 
		McCalcs

	order by 
		driverGroupName, label
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
