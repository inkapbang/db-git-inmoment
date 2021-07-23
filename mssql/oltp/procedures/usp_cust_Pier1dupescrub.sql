SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure  [dbo].[usp_cust_Pier1dupescrub]
@begindt datetime
as
select @begindt
 --declare @begindt datetime
 --declare @enddt datetime
 --set @begindt='7/13/2012'
 --set @enddt='7/13/2012'
 
 /*
 exec dbo.usp_cust_Pier1dupescrub '7/14/2012'


 Peir1 dupe scrub --Bob Luther 7/14/2012
 drop table [dbo].[_Pier1dupes]
 CREATE TABLE [dbo].[_Pier1dupes](
	[srobjectid] [int] NOT NULL,
	[dateofservice] [datetime] NULL,
	[locationnumber] [varchar](50) NULL,
	[df19734textvalue] [nvarchar](4000) NULL,
	[df19735textvalue] [nvarchar](4000) NULL
) ON [PRIMARY]


 */
 
 --get data
truncate table _Pier1dupes
-- truncate table _Pier1dupes2
 
 insert into _Pier1dupes(
srobjectid
,dateofservice
,locationnumber
,df19734textvalue
)
-------------------
select 
sr.objectid srid
--,sra.objectid sraid
,sr.dateOfService
,sr.locationObjectId
,sra.textValue as df19734textvalue
from SurveyResponse sr with (nolock)
join SurveyResponseAnswer sra with (nolock)
on sr.objectId =sra.surveyResponseObjectId
--where sr.beginDate between @begindt and @enddt
where sr.beginDate = @begindt 

and sr.locationObjectId in (
select objectId from Location where organizationObjectId=715 and name not like 'z%'
)
and sra.dataFieldObjectId=19734
and sr.complete=1
and sr.exclusionReason=0

--select * from _pier1dupes

update _Pier1dupes
set df19735textvalue=
--select
textvalue
from SurveyResponseAnswer sra
join _Pier1dupes p
on p.srobjectid=sra.surveyResponseObjectId
where sra.dataFieldObjectId=19735

--select * from _pier1dupes order by locationnumber,dateofservice,df19734textvalue,df19735textvalue
--exec dbo.usp_cust_Pier1dupescrub

;with Mycte as(
select srobjectid,locationnumber,dateofservice,df19734textvalue,df19735textvalue,ROW_NUMBER() 
OVER(PARTITION BY locationnumber,dateofservice,df19734textvalue,df19735textvalue order by locationnumber,dateofservice,df19734textvalue,df19735textvalue) AS DuplicateCount
from _pier1dupes 
)
--select srobjectid from Mycte where DuplicateCount>1
----select * from mycte
update SurveyResponse with(rowlock)
set exclusionReason=2 where objectId in (
select srobjectid from Mycte where DuplicateCount>1
)

--exec dbo.usp_cust_Pier1dupescrub '7/15/2012'
--select exclusionreason,* from surveyresponse where objectid=181722725

--select dateadd(dd,-1,(CAST( FLOOR( CAST( getDate() AS FLOAT ) ) AS DATETIME))) --as startdate 
--declare @dt datetime
--set @dt =(select (CAST( FLOOR( CAST( getDate() AS FLOAT ) ) AS DATETIME)))
--exec dbo.usp_cust_Pier1dupescrub @dt
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
