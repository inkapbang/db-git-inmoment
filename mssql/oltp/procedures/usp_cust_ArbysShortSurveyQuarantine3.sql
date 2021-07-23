SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_ArbysShortSurveyQuarantine3]
as 

/*
Arbys quarantine for too fast surveys
Bob Luther 092909
--exec [dbo].[usp_cust_ArbysShortSurveyQuarantine3]
*/
declare @begindt datetime, @enddt datetime,@voiceminutes float,@webminutes float

--set @begindt='3/1/2010'
set @begindt=dateadd(hh,-1,getdate())
set @enddt=dateadd(mi,-10,getdate())
set @voiceminutes=1.00
set @webminutes=0.5

declare @res table (
srobjectid int,
locationnumber varchar(50),
locationname varchar(100),
minutes float,
begindateutc datetime,
mode varchar(12)
)
--get phone and web surveys that are below minumum time limits
insert into @res

select sr.objectid,l.locationnumber,l.name,sr.minutes,sr.begindateutc,case modetype when 1 then 'Phone' when 2 then 'WebSurvey' else 'Import' end as mode
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid=537
and begindateutc>=@begindt
and begindateutc <@enddt
and sr.modetype=1 --Phone
--and sr.modetype=2 --web
and l.enabled=1
and l.hidden=0
and sr.complete=1
and minutes > 0.0
and minutes < @voiceminutes
and not(offerObjectId=1637 and locationObjectId=309009)--sr.offercodeobjectid != 910140
and not(offerObjectId=1637 and locationObjectId=309010)--sr.offercodeobjectid != 910139
--select * from @res
union
--web
select sr.objectid,l.locationnumber,l.name,sr.minutes,sr.begindateutc,case modetype when 1 then 'Phone' when 2 then 'WebSurvey' else 'Import' end as mode
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid=537
and begindateutc >=@begindt
and begindateutc <@enddt
--and sr.modetype=1 --Phone
and sr.modetype=2 --web
and l.enabled=1
and l.hidden=0
and sr.complete=1
and minutes > 0.0
and minutes < @webminutes
and not(offerObjectId=1637 and locationObjectId=309009)--sr.offercodeobjectid != 910140
and not(offerObjectId=1637 and locationObjectId=309010)--sr.offercodeobjectid != 910139

select * from @res order by mode,srobjectid

--exec dbo.usp_cust_ArbysShortSurveyQuarantine2

-----------------
declare @count int,@sraobjectid int,@srobjectid int,@locationnumber varchar(50),@locationname varchar(100),@newsequence int
set @count=0

declare mycursor cursor for
select srobjectid,locationnumber,locationname from  @res

open mycursor
fetch next from mycursor into @srobjectid,@locationnumber,@locationname
while @@fetch_status=0
begin

set @newsequence=(select max(sequence)+1 from surveyresponseanswer with (nolock) where surveyresponseobjectid=@srobjectid)

----insert orig locationnumber into sratextvalue

insert into surveyresponseanswer(
surveyResponseObjectId,
sequence,
textvalue,
dataFieldObjectId
)
select @srobjectid,@newsequence,@locationnumber,18276 

----insert orig locationname into sratextvalue

update surveyresponse with (rowlock) set externalid=cast(offerobjectid as varchar) where objectid=@srobjectid
update surveyresponse with(rowlock) set offerobjectid= 1637,locationObjectId=309009  where objectid=@srobjectid
--

set @count=@count+1
print cast(@count as varchar)+' ,'+cast(@srobjectid as varchar)+' ,'+@locationnumber+' ,'+@locationname
fetch next from mycursor into @srobjectid,@locationnumber,@locationname
end--while
close mycursor
deallocate mycursor
print cast(@count as varchar) +' Records Processed'
---
--exec dbo.usp_cust_McDShortSurveyQuarantine3

----------chk
--select sr.objectid,sr.offerCodeObjectId,sr.externalid,sr.modetype,sr.ani,sr.ipaddress,sr.minutes,sr.begindate,sr.begintime,sr.begindateutc
----into dbhealth.dbo.bradArbysUpdate012410
--from location l with (nolock) join offercode oc with (nolock)
--on l.objectid=oc.locationobjectid
--join surveyresponse sr with (nolock)
--on oc.objectid = sr.offerCodeObjectId
--where l.organizationobjectid=537
--and sr.begindate >'2/10/2010' 
--and sr.offerCodeObjectId=910140
--order by modetype,minutes,objectid asc
----select objectid from dbhealth.dbo.bradArbysUpdate012410
--select * from dbhealth.dbo.bradArbysUpdate012410
--update surveyresponse with (rowlock) set offercodeobjectid=cast(externalid as int) where objectid in (
--select objectid from dbhealth.dbo.bradArbysUpdate012410
--)
--select 1389-1527
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
