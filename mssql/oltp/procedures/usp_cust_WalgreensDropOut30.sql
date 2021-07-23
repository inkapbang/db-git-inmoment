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
    CREATE procedure [dbo].[usp_cust_WalgreensDropOut30]
    as
    --exec dbo.usp_cust_WalgreensDropOut30
    --IF OBJECT_ID('_res3') IS NOT NULL	DROP TABLE _res3
        --IF OBJECT_ID('_sr') IS NOT NULL	DROP TABLE _sr
    
    declare @begindt date 
    declare @enddt date
  
    declare @OrgId int
    
     --get dates  
    --set @begindt=(select DATEADD(wk, -1, DATEADD(wk, DATEDIFF(wk, 0,getdate()), -1)))   
    --set @enddt=(DATEADD(wk, DATEDIFF(wk, 0, getdate()), -2))
    set @begindt='09/29/2013'
    set @enddt='10/05/2013'
    set @orgId=1030
    select @begindt,@enddt,@orgId
    
	IF OBJECT_ID('_sr') IS NOT NULL	DROP TABLE _sr
	SELECT 
			DISTINCT sr.objectId
			, l.name 										AS location
			, s.objectId 									AS surveyObjectId
			, s.name
			, sr.surveyGatewayObjectId			
			, complete
			, sr.exclusionreason
			, sr.modeType
			, sr.beginDate
			, substring(cast(sr.begintime as varchar),12,9) AS beginTime
			, sr.minutes
			, sr.ani
			, sr.ipaddress
			,sr.loyaltyNumber
			, offercode
			, o.name AS offerName
			--, la.*
			--,fbct.name feedbackchannelName										

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
					
		--left JOIN 
		--	feedbackchannel fbc 							WITH (NOLOCK)
		--			ON o.channelobjectid = fbc.objectid
		--					left JOIN 
		--	feedbackchannelType fbct 							WITH (NOLOCK)
		--			ON fbc.feedbackChannelTypeObjectId = fbct.objectid
	WHERE 
			l.organizationobjectid = @orgId
		AND 
			sr.beginDate BETWEEN 	@beginDt
							AND 	@endDt 
		AND 
			complete = 0
		AND 
			exclusionReason = 0
		and la.objectid in (692,695,696,697)
		and sr.offercode != '00000'
		--and	--surveyobjectid in (6812,6918)
		--	surveyobjectid in (
		--	6957,
		--	6921,
		--	6918,
		--	6996)
		--select * from survey where organizationobjectid = 1030 order by name--select * from organization where name like 'wal%'
   
    --select * from _sr
    
    --get drop out info
    	IF OBJECT_ID('_res2') IS NOT NULL	DROP TABLE _res2

		select  sra.surveyresponseobjectid,sra.objectid,sra.datafieldobjectid sradatafieldobjectid,
		sra.datafieldoptionobjectid sradatafieldoptionobjectid,df.name dfname,df.objectid dfobjectid,
		sra.sequence, sra.textvalue,c.commenttext,rank() over(partition by sra.surveyResponseObjectId order by sra.sequence desc) as rowNumber
		into _res2 
		from surveyresponseanswer sra join datafield df
		on df.objectid=sra.datafieldobjectid
		left join comment c
		on c.surveyresponseanswerobjectid=sra.objectid
		where sra.surveyresponseobjectid in (select objectid from _sr  )
		
		IF OBJECT_ID('_res3') IS NOT NULL	DROP TABLE _res3
		--select 
		
		select * from _sr--286719947
		select * from _res2
		--select * from _res3

--Join em 
select objectid srobjectid,ipaddress,surveyname,begindate,begintime,location,offername,
--isnull(loyaltyNumber,'No Loyalty Number') AudienceID,Offercode as SurveyGroupID,
coalesce(dfname,'No Answers') as promptname,isnull(questionnumber,0) as questionnumber 
--select *  
from (
select _sr.objectid,ipaddress,_sr.name as surveyname,begindate,begintime,location,offername--,loyaltyNumber,offerCode
from _sr
)as a
left outer join
(
select surveyresponseobjectid
,dfname 
,sequence+1 as questionNumber
from _res2 where rownumber=1
)as b
on a.objectid=b.surveyresponseobjectid
order by surveyname,srobjectid

	--IF OBJECT_ID('_sr') IS NOT NULL	DROP TABLE _sr

--select  surveyresponseobjectid,textvalue,commenttext  from _res2 where textvalue is not null or commenttext is not null
--select * from _res2 where dfobjectid=59101

    
    
    ------------------
	--set @TotalSurveys= select COUNT(*) from _sr
	--set 
----select  'Outbound Email Survey',(select COUNT(*) from _sr ) as TotalSurveys, (select COUNT(*) from _sr where complete=1) as complete,(select COUNT(*) from _sr where complete=0) as incompletes
---------------------
--declare @count int,@sobjectId	int,@sname varchar(50)
    
--    declare @TotalSurveys int
--    declare @CompletedSurveys int
--    declare @IncompleteSurveys int

--set @count=0

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_srResults]') AND type in (N'U'))
--DROP TABLE [dbo].[_srResults];

--create table _srResults(Surveyname Varchar(50),TotalReviews int,CompletedReviews int,IncompleteReviews int,PercentCompleted float,begindate datetime,enddate datetime)

--declare mycursor cursor for
--select distinct surveyobjectid,name from _Sr where surveyobjectid in (6812,6918)
--open mycursor
--fetch next from mycursor into @sobjectId,@sname

--while @@Fetch_Status=0
--begin
--print cast(@count as varchar)+', '+cast(@sObjectId as varchar)+', '+@sname
----delete from surveyresponse with (rowlock) where objectid =@srobjectid

--set @TotalSurveys=(select COUNT(*) from _sr where surveyObjectId=@sobjectId)
--set @CompletedSurveys=(select COUNT(*) from _sr where complete=1 and exclusionreason=0 and surveyObjectId=@sobjectId)
--set @IncompleteSurveys=(select @TotalSurveys-@CompletedSurveys)-- and surveyid=@sobjectId

--insert into _srResults
--select @sname 'SurveyName', @TotalSurveys 'Total Reviews', @CompletedSurveys 'Completed Reviews',@IncompleteSurveys 'Incomplete Reviews', (cast(@CompletedSurveys as float)/cast(@TotalSurveys as float)*100.) as PercentCompleted,@Begindt,@enddt;

--set @count=@count+1
--fetch next from mycursor into @sobjectId,@sname

--end--while
--close mycursor
--deallocate mycursor
--Print Cast(@count as varchar) +' Records Processed'

--select * from _srResults
--select distinct offercode from _sr
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
