SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select top 5 * from surveyresponse

----select * from organization where name like 'wal%'--1030

--select  * from Survey where organizationObjectId=1030
--select * from location where survey

--select * from _sr

--select * from SurveyResponse sr 

--select DUdtu
----join Location l
----on l.objectid=sr.locationObjectId 
--where beginDate >'6/30/2013' and l.objectId=1030

--drop table _sr

--select *
--into _sr 
--from SurveyResponse sr
--where beginDate >'6/30/2013'

--select * from SurveyResponse where beginDate > '7/1/2013' and surveyObjectId=6812
--6918
   -- select * into _sr from SurveyResponse where beginDate between @begindt and @enddt and Organization = 1030
---------------------------------------------
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_sr]') AND type in (N'U'))
--DROP TABLE [dbo].[_sr];

    --exec dbo.usp_cust_WgRawDataBob
    CREATE procedure [dbo].[usp_cust_WalgreensDropOut29]
    as
    --exec dbo.usp_cust_WalgreensDropOut29
    
    declare @begindt date 
    declare @enddt date
  
    declare @OrgId int
    
     --get dates  
    --set @begindt=(select DATEADD(wk, -1, DATEADD(wk, DATEDIFF(wk, 0,getdate()), -1)))   
    --set @enddt=(DATEADD(wk, DATEDIFF(wk, 0, getdate()), -2))
    set @begindt='10/13/2013'
    set @enddt='10/19/2013'
    set @orgId=1030
    select @begindt,@enddt,@orgId
    
	IF OBJECT_ID('_sr') IS NOT NULL	DROP TABLE _sr
	SELECT 
			DISTINCT sr.objectId
			, l.name locationname
			,l.objectid 										AS location
			, s.objectId 									AS surveyObjectId
			, s.name surveyname
			, sr.surveyGatewayObjectId			
			, complete
			,sr.exclusionreason
			, sr.modeType
			, sr.beginDate
			, substring(cast(sr.begintime as varchar),12,9) AS beginTime
			, sr.minutes
			, sr.ani
			, offercode
			, o.name AS offerName
			, la.objectid locationattributeObjectid

	INTO _sr
	FROM 
			location l										WITH (NOLOCK)
		JOIN 
			surveyresponse sr								WITH (NOLOCK)
					ON l.objectid = sr.locationobjectid
		JOIN 
			survey s										WITH (NOLOCK)
					ON s.objectid = sr.surveyobjectid
		JOIN 
			offer o 										WITH (NOLOCK)
					ON o.objectid = sr.offerobjectid
		Join 
			locationattributelocation lal					with (nolock)
					On l.objectid=lal.locationobjectid	
		Join
			locationattribute la								with (nolock)
					On lal.attributeobjectid=la.objectid
	WHERE 
			l.organizationobjectid = @orgId
		AND 
			sr.beginDate BETWEEN 	@beginDt
							AND 	@endDt 
		--AND 
		--	complete = 0
		AND 
			exclusionReason = 0
		and la.objectid in (692,695,696,697,746)
		and l.hidden=0
		--and sr.offercode != '00000'
   
    --select * from _sr 
    --    select * from _sr where locationattributeobjectid =692
    --        select * from _sr where locationattributeobjectid =695
    --            select * from _sr where locationattributeobjectid =696
    --                select * from _sr where locationattributeobjectid =697
    
    ------------------
	--set @TotalSurveys= select COUNT(*) from _sr
	--set 
----select  'Outbound Email Survey',(select COUNT(*) from _sr ) as TotalSurveys, (select COUNT(*) from _sr where complete=1) as complete,(select COUNT(*) from _sr where complete=0) as incompletes
-------------------
declare @count int,@locationattributeObjectid 	int,@locationattributename varchar(50)
    
    declare @TotalSurveys int
    declare @CompletedSurveys int
    declare @IncompleteSurveys int

set @count=0

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_srResults]') AND type in (N'U'))
DROP TABLE [dbo].[_srResults];

create table _srResults(locationattributeobjectid int, TotalReviews int,CompletedReviews int,IncompleteReviews int,PercentCompleted float,begindate datetime,enddate datetime)

declare mycursor cursor for
select distinct locationattributeobjectid
--,name 
from _Sr order by locationattributeobjectid --where surveyobjectid in (7103,7105)--(6957,6921,6918,6996)--(6812,6918)
open mycursor
fetch next from mycursor into @locationattributeobjectId--,@sname

while @@Fetch_Status=0
begin
print cast(@count as varchar)+', '+cast(@locationattributeObjectid as varchar)--+', '+@sname
--delete from surveyresponse with (rowlock) where objectid =@srobjectid

set @TotalSurveys=(select COUNT(*) from _sr where locationattributeobjectId=@locationattributeobjectId)
set @CompletedSurveys=(select COUNT(*) from _sr where locationattributeobjectId=@locationattributeobjectId and complete=1 and exclusionreason=0)-- and surveyObjectId=@sobjectId)
set @IncompleteSurveys=(select @TotalSurveys-@CompletedSurveys)-- and surveyid=@sobjectId

insert into _srResults
select @locationattributeobjectid 'Locationattributeobjectid', @TotalSurveys 'Total Reviews', @CompletedSurveys 'Completed Reviews',@IncompleteSurveys 'Incomplete Reviews', (cast(@CompletedSurveys as float)/cast(@TotalSurveys as float)*100.) as PercentCompleted,@Begindt,@enddt;

set @count=@count+1
fetch next from mycursor into @locationattributeobjectId

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

select 
sr.locationattributeobjectid
,lsv.value
,sr.TotalReviews
,sr.CompletedReviews
,sr.IncompleteReviews
,sr.PercentCompleted
,sr.begindate
,sr.enddate

--sr.* 
from _srResults sr
join locationattribute la
on la.objectid=sr.locationattributeobjectid
join localizedstringvalue lsv
on la.nameobjectid=lsv.localizedstringobjectid
where lsv.localekey='en_us'

--declare @Total int,@TotalCompleted int,@TotalIncomplete int
--set @Total=(select count(*) from _sr )
--set @TotalCompleted=(select count(*) from _sr where complete=1)
--set @TotalIncomplete=(select count(*) from _sr where complete=0)
--select 0 locationattributteobjectid,'Total Surveys for period' as 'value',
--@Total TotalReviewsForPeriod,
--@TotalCompleted TotalCompletedReviewsForPeriod,
--@TotalIncomplete TotalIncompleteReviewsForPeriod,
--(@TotalCompleted/@Total)*100.0 PercentCompleted

--select count(*) 
--from surveyresponse sr with (nolock)
--join location l with (nolock)
--on l.objectid=sr.locationobjectid
--where sr.begindate between @begindt and @enddt
--and l.organizationobjectid=@orgid




--exec dbo.usp_cust_WalgreensDropOut29

declare @GrandTotal int,@GrandTotalCompleted int,@GrandTotalIncomplete int
set @GrandTotal=(select count(*) from surveyresponse sr with (nolock) join location l with (nolock)on l.objectid=sr.locationobjectid 
where l.organizationobjectid=@orgid and begindate between @begindt and @enddt and l.hidden=0 )
set @GrandTotalCompleted=(select count(*) from surveyresponse sr with (nolock) join location l with (nolock)on l.objectid=sr.locationobjectid 
where l.organizationobjectid=@orgid and begindate between @begindt and @enddt and l.hidden=0 and complete=1)
set @GrandTotalIncomplete=(select count(*) from surveyresponse sr with (nolock) join location l with (nolock)on l.objectid=sr.locationobjectid 
where l.organizationobjectid=@orgid and begindate between @begindt and @enddt and l.hidden=0 and complete=0)
select 0 locationattributteobjectid,'Total Surveys for period' as 'value',
@GrandTotal GrandTotalReviewsForPeriod
,@GrandTotalCompleted GrandTotalCompletedReviewsForPeriod
,@GrandTotalIncomplete GradnTotalIncompleteReviewsForPeriod
,(@GrandTotalCompleted/@GrandTotal)*100.0 PercentCompleted
,@begindt
,@enddt

--select 146276+47339=193615
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
