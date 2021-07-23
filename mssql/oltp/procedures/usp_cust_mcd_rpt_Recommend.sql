SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_mcd_rpt_Recommend]
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
		
--	PRINT @currentPeriodEnd
/*
    SELECT
		@previousPeriodBegin = MIN(beginDate),
		@previousPeriodEnd = MAX(endDate)
		FROM dbo.PeriodIntervalRanges(@periodId, DATEADD(DAY, -1, @currentPeriodBegin), '')
*/
--    PRINT 'Current Begin Date: ' + CONVERT(VARCHAR, @currentPeriodBegin, 101) + '  End Date:' + CONVERT(VARCHAR, @currentPeriodEnd, 101)
--    PRINT 'Previous Begin Date: ' + CONVERT(VARCHAR, @previousPeriodBegin, 101) + '  End Date:' + CONVERT(VARCHAR, @previousPeriodEnd, 101)


	--CODE REVIEW: HOW TO HANDLE THIS FOR RELEASE 
	create table #peerLocations (locationObjectId int not null primary key)
	insert into #peerLocations (locationObjectId)
		select locationObjectId from dbo.GetCategoryLocations(@locationCategoryId)
	
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

	declare @dayPart1 datetime
	declare @dayPart2 datetime
	declare @dayPart3 datetime
	declare @dayPart4 datetime
	declare @dayPart5 datetime
	declare @endOfDay datetime
	declare @startOfDay datetime

	select @dayPart1 = '1900-01-01 05:00:00.000'
	select @dayPart2 = '1900-01-01 11:00:00.000' 
	select @dayPart3 = '1900-01-01 14:00:00.000'
	select @dayPart4 = '1900-01-01 17:00:00.000'
	select @dayPart5 = '1900-01-01 20:00:00.000'
	select @endOfDay = '1900-01-01 23:59:59.999'
	select @startOfDay = '1900-01-01 00:00:00.000';



	with McOption as (
		select
			dfo.dataFieldObjectId fieldId,
			dfo.objectId optionId,
			ordinalLevel,
			case
				when count(*) over (partition by dfo.dataFieldObjectId) = 2 then
					case when ordinalLevel = 1 then 1 else 0 end
				else
					case when ordinalLevel in (1,2) then 1 else 0 end
			end bottomBox
		from
			DataFieldOption dfo
		where
			dfo.dataFieldObjectId in (25796,25798,25797,25795,25802,25803,25793,25794,25799,25800,25801) 
			and dfo.objectId <> 69736 -- does not apply
	),
	McData as (
		select
			sr.locationObjectId locationId,
			sr.objectId responseId,
			timeAns.dataFieldObjectId timeFieldId,
			timeAns.dateValue,
			case
				when timeAns.dateValue >= @dayPart1 and timeAns.dateValue < @dayPart2 then 1
				when timeAns.dateValue >= @dayPart2 and timeAns.dateValue < @dayPart3 then 2
				when timeAns.dateValue >= @dayPart3 and timeAns.dateValue < @dayPart4 then 3
				when timeAns.dateValue >= @dayPart4 and timeAns.dateValue < @dayPart5 then 4
				else 5
			end timeOfDay,
			driverAns.dataFieldObjectId driverFieldId,
			driverAns.dataFieldOptionObjectId driverOptionId,
			McOption.bottomBox
		from
			SurveyResponse sr
			JOIN Offer o
				ON o.objectId = sr.offerObjectId
				AND channelObjectId = @feedbackChannelId
			join #peerLocations peer
				on peer.locationObjectId = sr.locationObjectId
				and sr.beginDate >= @startTwoMoAgo and beginDate < @startNextMo
				and sr.complete = 1
				and sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
			join (
				SurveyResponseAnswer driverAns
				join McOption
					on McOption.optionId = driverAns.dataFieldOptionObjectId
				) on driverAns.surveyResponseObjectId = sr.objectId
			join SurveyResponseAnswer timeAns
				on timeAns.surveyResponseObjectId = sr.objectId
				and timeAns.dataFieldObjectId = 25756
	),
	McPct as (
		select
			driverFieldId,
			timeOfDay,
			
			count(*) driverCount,
			count(case when bottomBox = 1 then 1 end) bottomBoxCount,
			isnull(count(case when bottomBox = 1 then 1 end) * 1.0 / nullif(count(*), 0), 0) bottomBoxPct,
			
			count(case when locationId = @locationId then 1 end) locDriverCount,
			count(case when locationId = @locationId and bottomBox = 1 then 1 end) locBottomBoxCount,
			isnull(count(case when locationId = @locationId and bottomBox = 1 then 1 end) * 1.0 / nullif(count(case when locationId = @locationId then 1 end), 0), 0) locBottomBoxPct,
			row_number() over (partition by timeOfDay order by isnull(count(case when locationId = @locationId and bottomBox = 1 then 1 end) * 1.0 / nullif(count(case when locationId = @locationId then 1 end), 0), 0) desc) rowNum
		from
			McData
		group by
			driverFieldId,
			timeOfDay
	)
	--select * from McPct
	,
	McNotEnoughData AS (
		SELECT
			*
		FROM
			McPct mp
		WHERE
			mp.locDriverCount > 4
	),
	McFinal as (
		select
			mp.timeOfDay,
			--mp.driverFieldId,
			(select value from dbo.ufn_app_LocalizedStringTable(df.labelObjectId, @localeKey)) driverLabel,
			mp.bottomBoxPct,
			mp.locBottomBoxPct,
			--(mp.locBottomBoxPct - mp.bottomBoxPct) diff,
			rank() over (partition by mp.timeOfDay order by mp.locBottomBoxPct desc, (mp.locBottomBoxPct - mp.bottomBoxPct) desc, mp.driverFieldId ) locRank

		from
			McNotEnoughData mp
			join dbo.DataField df 
				on df.objectId = mp.driverFieldId
		--no rownum where clause because it screws up the tiebreakers
		
	)
	select 
		case
			when timeOfDay = 1 then 'mcd_dayPart1'
			when timeOfDay = 2 then 'mcd_dayPart2'
			when timeOfDay = 3 then 'mcd_dayPart3'
			when timeOfDay = 4 then 'mcd_dayPart4'
			when timeOfDay = 5 then 'mcd_dayPart5'
		end timeOfDay,
		driverLabel,
		bottomBoxPct,
		locBottomBoxPct
	from 
		McFinal
	where
		locRank = 1
	order by
		timeOfDay
	
	drop table #peerLocations

end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
