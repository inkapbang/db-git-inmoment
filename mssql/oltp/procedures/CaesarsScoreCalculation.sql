SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[CaesarsScoreCalculation]
	-- Add the parameters for the stored procedure here
	@StartDt smalldatetime = null
	, @EndDt smalldatetime = null	
	, @OfferObjectId bigint = 7999 -- *LIVE* Caesars
AS
BEGIN
	-- Created: 20161024
	-- Author: TAR
	-- Purpose: DBA-3334 - this process generates the score values for Caesars Entertainment
	-- Modified: TAR - 20161202 - altered process for Yes/No data field calculations
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


if @startdt is null 
begin
	-- code to get most recent Sunday
	select @EndDt = dateadd(wk, datediff(wk, 6, getDate()), 7)-1 -- prior Sunday
	select @StartDt = @EndDt -6
	
end

-- override @StartDt and @EndDt values
--select @StartDt = '20160919', @EndDt = '20160925'
--select @StartDt = '20161003', @EndDt = '20161009'
--select @StartDt = '20160627', @EndDt = '20160925'

-- override @OfferObjectId values
--select @OfferObjectId = 7999 -- *LIVE* Caesars

-- convert date range to fiscal weeks
select pr.objectid, pr.BeginDate, pr.EndDate, lsv.value as FiscalWeek
into #FiscalWeeks
from Period (nolock) p 
inner join periodtype (nolock) pt on pt.objectid = p.periodtypeobjectid and pt.name = 'Caesars Fiscal Weeks'
inner join periodRange (nolock) pr on pr.periodtypeobjectid = pt.objectid
left outer join localizedstringvalue (nolock) lsv on lsv.localizedstringobjectid = pr.labelobjectid and lsv.localekey = 'en_us'
where p.organizationobjectid = 1700
and p.offsetValue = 0
and pr.begindate between @startDt and @EndDt
order by pr.begindate

-- testing
--select * from #FiscalWeeks return

-- get responses and guest tier
select fw.FiscalWeek, fw.EndDate
, sr.objectid, sr.locationobjectid, l.locationNumber
-- correct guest tier info
, case isnull(dfo.name, 'GLD')
	when 'GLD' then 'GLD'
	when 'DIA' then 'DIA/SEV'
	when 'SEV' then 'DIA/SEV'
	else dfo.name
	end as GuestTier
into #ResponseTiers
from surveyresponse (nolock) sr
inner join #FiscalWeeks fw on sr.begindate between fw.begindate and fw.enddate
inner join location (nolock) l on l.objectid = sr.locationobjectid
left outer join surveyresponseanswer (nolock) sra on sra.surveyresponseobjectid = sr.objectid and sra.datafieldobjectid = 210126 -- GuestTier
left outer join datafieldoption (nolock) dfo on dfo.datafieldobjectid = sra.datafieldobjectid and dfo.objectid = sra.datafieldoptionobjectid
where l.organizationobjectid = 1700 -- caesars entertainment
and l.enabled = 1
and sr.complete = 1 and sr.exclusionReason = 0
and sr.offerobjectid = @OfferObjectID


-- testing
--select count(*) from #ResponseTiers return

-- get full response count by location
-- NOTE: this is not grouped by GuestTier, so that the count is the same even if certain tiers do not respond for some questions
select r.FiscalWeek, r.EndDate, r.locationNumber, count(*) as TotalCnt
into #ResponseCountByLocation
from #ResponseTiers r
group by r.FiscalWeek, r.EndDate, r.locationNumber

-- testing
--select * from #ResponseCountByLocation order by FiscalWeek, EndDate, LocationNumber return

create table #QuestionAnswerByLocation(FiscalWeek varchar(50), EndDate datetime, locationNumber varchar(50)
	, GuestTier varchar(10), datafieldObjectId bigint
	, name varchar(50), cnt int)

-- get question set, group by LocationNumber, guestTier, question and answer
insert into #QuestionAnswerByLocation(FiscalWeek, EndDate, locationNumber, GuestTier, datafieldObjectId
	, name, cnt)
select r.FiscalWeek, r.EndDate, r.locationNumber, r.GuestTier, sra.datafieldobjectid
-- TAR - 20161202 - alteration to allow "YES" and "NO" values to pass through and be scored
--, case when isnumeric(dfo.name) = 1 then dfo.name else -1 end as name
, case when isnumeric(dfo.name) = 1 then dfo.name 
	when dfo.name = 'YES' then 10
	when dfo.name = 'NO' then 0
	else -1 end as name
, count(*) as cnt
--into #QuestionAnswerByLocation
from #ResponseTiers r
inner join surveyresponseanswer (nolock) sra on sra.surveyresponseobjectid = r.objectid
inner join datafield (nolock) df on df.objectid = sra.datafieldobjectid and df.organizationobjectid = 1700 -- Caesars Entertainment
	and df.fieldtype = 4 -- rating
inner join _Caesars_DataFieldIds d on d.dataFieldObjectId = df.objectid
left outer join datafieldoption (nolock) dfo on dfo.objectid = sra.datafieldoptionobjectid and dfo.datafieldobjectid = sra.datafieldobjectid
group by r.FiscalWeek, r.EndDate, r.locationNumber, r.GuestTier, sra.datafieldobjectid
	, case when isnumeric(dfo.name) = 1 then dfo.name when dfo.name = 'YES' then 10 when dfo.name = 'NO' then 0 else -1 end
 	--, case when isnumeric(dfo.name) = 1 then dfo.name else -1 end

-- testing
--select * from #QuestionAnswerByLocation order by LocationNumber, FiscalWeek, GuestTier, datafieldobjectid, name return
--select * from #QuestionAnswerByLocation where isnumeric(name) = 0 order by LocationNumber, FiscalWeek, GuestTier, datafieldobjectid, name return

create table #AnswerBlocks (FiscalWeek varchar(50), EndDate datetime, LocationNumber varchar(50)
	, GuestTier varchar(10), datafieldobjectid bigint, CountSurveysForQuestion int
	, CountAll int, CountA int, CountModA int, CountF int)
	
-- tally into Total, All, A (10 to 9) and F (6 to 0) blocks by location
insert into #AnswerBlocks (FiscalWeek, EndDate, LocationNumber
	, GuestTier, datafieldobjectid, CountSurveysForQuestion
	, CountAll, CountA, CountModA, CountF)
select q.FiscalWeek, q.EndDate, q.LocationNumber, q.GuestTier, q.datafieldobjectid
, sum(q.cnt) as CountSurveysForQuestion
, sum(case when q.name between 0 and 10 then q.cnt else 0 end) as CountAll
, sum(case when q.name between 9 and 10 then q.cnt else 0 end) as CountA
, sum(case when q.name between 7 and 10 then q.cnt else 0 end) as CountModA
, sum(case when q.name between 0 and 6 then q.cnt else 0 end) as CountF
from #QuestionAnswerByLocation q
group by q.FiscalWeek, q.EndDate, q.LocationNumber, q.GuestTier, q.datafieldobjectid

-- add index
create index idx1 on #AnswerBlocks(locationnumber, GuestTier, FiscalWeek, EndDate)

-- testing
--select * from #AnswerBlocks order by LocationNumber, GuestTier, datafieldobjectid return

-- add index
create table #LocationWeights (FiscalWeek varchar(50), EndDate datetime, LocationNumber varchar(50)
	, GuestTier varchar(10), MaxWeight decimal(20,8))

-- get weights per location per GuestTier
insert into #LocationWeights (FiscalWeek, EndDate, LocationNumber, GuestTier, MaxWeight)
select fw.FiscalWeek, fw.EndDate
, l.locationnumber
-- correct guest tier info
, case isnull(dfo1.name, 'GLD')
	when 'GLD' then 'GLD'
	when 'DIA' then 'DIA/SEV'
	when 'SEV' then 'DIA/SEV'
	else dfo1.name
	end as GuestTier
, max(cast(sra.textValue as decimal(20,8))) as MaxWeight
from surveyresponse (nolock) sr
inner join #FiscalWeeks fw on sr.begindate between fw.begindate and fw.enddate
inner join location (nolock) l on l.objectid = sr.locationobjectid and l.organizationobjectid = 1700 -- caesars entertainment
left outer join surveyresponseanswer (nolock) sra on sra.surveyresponseobjectid = sr.objectid
left outer join surveyresponseanswer (nolock) sra1 on sra1.surveyresponseobjectid = sr.objectid 
left outer join datafieldoption (nolock) dfo1 on dfo1.datafieldobjectid = sra1.datafieldobjectid and dfo1.objectid = sra1.datafieldoptionobjectid
where sr.complete = 1 and sr.exclusionreason = 0
and sra.datafieldobjectid = 237924 -- weight
and sra1.datafieldobjectid = 210126 -- guest tier
group by fw.FiscalWeek, fw.EndDate, l.locationnumber
-- correct guest tier info
, case isnull(dfo1.name, 'GLD')
	when 'GLD' then 'GLD'
	when 'DIA' then 'DIA/SEV'
	when 'SEV' then 'DIA/SEV'
	else dfo1.name
	end 

-- add index
create index idx2 on #LocationWeights(locationnumber, GuestTier, FiscalWeek, EndDate)

--testing
--select * from #LocationWeights order by FiscalWeek, EndDate, LocationNumber return

-- combine counts and weights
select a.FiscalWeek, a.EndDate
, a.locationNumber, a.GuestTier
, a.DataFieldObjectId
, w.MaxWeight
, w.MaxWeight * a.CountA as [WeightedA (10-9)]
, w.MaxWeight * a.CountModA as [WeightedModifiedA (10-7)]
, w.MaxWeight * a.CountF as [WeightedF (6-0)]
, w.MaxWeight * a.CountAll as [WeightedAll]
, a.CountA as [UnweightedA (10-9)]
, a.CountModA as [UnweightedModifiedA (10-7)]
, a.CountF as [UnweightedF (6-0)]
, a.CountAll as [UnweightedAll]
into #OutputValues
from #LocationWeights w
inner join #AnswerBlocks a on a.locationnumber = w.locationnumber and a.GuestTier = w.GuestTier and a.FiscalWeek = w.FiscalWeek and a.EndDate = w.EndDate


-- testing
--select * from #OutputValues order by FiscalWeek, EndDate, LocationNumber, GuestTier, DataFieldObjectId return


-- save results to table for delivery processing
-- drop table if it exists
IF OBJECT_ID('dbo._Caesars_CalculationOutput', 'U') IS NOT NULL DROP TABLE dbo._Caesars_CalculationOutput; 

-- build table
create table dbo._Caesars_CalculationOutput (FiscalWeek varchar(50), PeriodWeek varchar(10)
	, LocationId int, LocationNumber varchar(50)
	, DataFieldObjectId int, DataFieldName varchar(50)
	, [WeightedA (10-9)] decimal(20,8), [WeightedModifiedA (10-7)] decimal(20,8)
	, [WeightedF (6-0)] decimal(20,8), [WeightedAll] decimal(20,8)
	, [UnweightedA (10-9)] int, [UnweightedModifiedA (10-7)] int
	, [UnweightedF (6-0)] int, [UnweightedAll] int
	, SurveyCount int)

-- push output into table
insert into dbo._Caesars_CalculationOutput(FiscalWeek, PeriodWeek, LocationId, LocationNumber
	, DataFieldObjectId, DataFieldName
	, [WeightedA (10-9)], [WeightedModifiedA (10-7)]
	, [WeightedF (6-0)], [WeightedAll]
	, [UnweightedA (10-9)], [UnweightedModifiedA (10-7)]
	, [UnweightedF (6-0)], [UnweightedAll]
	, SurveyCount)
-- get final output (summate by unit across tiers)
select t.FiscalWeek
, convert(varchar(10), t.EndDate, 112) as PeriodWeek
, l.objectId as LocationId, t.LocationNumber
, t.DataFieldObjectId, df.Name as DataFieldName
, t.[WeightedA (10-9)]
, t.[WeightedModifiedA (10-7)]
, t.[WeightedF (6-0)]
, t.[WeightedAll]
, t.[UnweightedA (10-9)]
, t.[UnweightedModifiedA (10-7)]
, t.[UnweightedF (6-0)]
, t.[UnweightedAll]
, c.TotalCnt as SurveyCount
from (
select o.FiscalWeek, o.EndDate
, o.LocationNumber
, o.DataFieldObjectId
, sum(o.[WeightedA (10-9)]) as [WeightedA (10-9)]
, sum(o.[WeightedModifiedA (10-7)]) as [WeightedModifiedA (10-7)]
, sum(o.[WeightedF (6-0)]) as [WeightedF (6-0)]
, sum(o.[WeightedAll]) as [WeightedAll]
, sum(o.[UnweightedA (10-9)]) as [UnweightedA (10-9)]
, sum(o.[UnweightedModifiedA (10-7)]) as [UnweightedModifiedA (10-7)]
, sum(o.[UnweightedF (6-0)]) as [UnweightedF (6-0)]
, sum(o.[UnweightedAll]) as [UnweightedAll]
from #OutputValues o
group by o.FiscalWeek, o.EndDate, o.LocationNumber, o.DataFieldObjectId
) as t
inner join location (nolock) l on l.locationNumber = t.locationNumber and l.organizationobjectid = 1700
inner join dataField (nolock) df on df.objectid = t.datafieldobjectid
inner join #ResponseCountByLocation c on c.locationnumber = t.locationnumber and c.FiscalWeek = t.FiscalWeek and c.EndDate = t.EndDate
order by t.FiscalWeek, t.EndDate, t.LocationNumber, df.Name

-- build index on output table
create index idxA on _Caesars_CalculationOutput(FiscalWeek, LocationNumber, datafieldObjectId)

-- testing
--select * from dbo._Caesars_CalculationOutput
print 'Results copied to dbo._Caesars_CalculationOutput'

-- cleanup
drop table #FiscalWeeks
drop table #ResponseTiers
drop table #ResponseCountByLocation
drop table #QuestionAnswerByLocation
drop table #AnswerBlocks
drop table #LocationWeights
drop table #OutputValues


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
