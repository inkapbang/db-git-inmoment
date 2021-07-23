SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_cust_ArbysIPspike4]
--exec [dbo].[usp_cust_ArbysIPspike4]
as
declare @begindt datetime,@enddt datetime,@minutestolookback int
set @minutestolookback=30

--set @begindt ='2/23/2010'
--set @enddt='2/24/2010'
set @enddt=dateadd(mi,-10,getutcdate())
set @begindt=dateadd(hh,-1,@enddt)
--select @begindt,@enddt
--print @begindt

--get 
IF Object_id(N'tempdb..#res1',N'U') IS NOT NULL
  DROP TABLE #res1;

create table #res1(srobjectid bigint,locationnumber varchar(15),ipaddress varchar(15),begindateUTC datetime)

IF Object_id(N'tempdb..#res3',N'U') IS NOT NULL
  DROP TABLE #res3;

create table #res3(srobjectid bigint)

--get surveys for that period
insert into #res1
select sr.objectid,l.locationnumber,sr.ipaddress,sr.begindateUTC
        FROM   location l WITH (nolock)
               JOIN surveyresponse sr with (nolock)
					ON l.objectid=sr.locationobjectid
        WHERE  l.organizationobjectid = 537
			   And modetype=2
--               AND l.objectid IN (SELECT locationobjectid
--                                  FROM   dbo.Ufn_app_locationsincategoryoftype(640)
--								)

			   AND NOT(offerObjectId=1637 and locationObjectId=309009)--AND sr.offercodeobjectid != 910140
				AND NOT(offerObjectId=1637 and locationObjectId=309010)--AND sr.offercodeobjectid != 910139
--               AND sr.offercodeobjectid != 800574
--               AND sr.offercodeobjectid != 800573
			   AND begindateUTC between @begindt and @enddt
               AND l.enabled = 1
               AND l.hidden = 0
               AND sr.complete = 1;

--select * from #res1 order by srobjectid
----top of loop
declare @count int,@locationnumber varchar(15),@ipaddress varchar(15) 
set @count=0

declare mycursor cursor for
select locationnumber,IPaddress
from #res1
group by locationnumber,IPaddress
having count(*) > 3

open mycursor
fetch next from mycursor into @locationnumber,@ipaddress

while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+@locationnumber+', '+@ipaddress

--Inner loop
IF Object_id(N'tempdb..#res2',N'U') IS NOT NULL
  DROP TABLE #res2;

create table #res2(isrobjectid bigint,ilocationnumber varchar(15),iipaddress varchar(15),ibegindateutc datetime,irownumber int)

declare  @isrobjectid bigint,@ilocationnumber varchar(15),@iipaddress varchar(15),@ibegindateutc datetime ,@irownumber int

declare innercursor cursor for 
select srobjectid,locationnumber,ipaddress,begindateutc,row_number() over (order by begindateutc desc) as rowumber
from #res1
where locationnumber=@locationnumber
and ipaddress=@ipaddress

open innercursor
fetch next from innercursor into @isrobjectid,@ilocationnumber,@iipaddress,@ibegindateutc,@irownumber

while @@fetch_status=0
begin
--print cast(@isrobjectid as varchar)+', '+@locationnumber+', '+@iipaddress+', '+convert(varchar(25),@ibegindateutc,101)+', '+cast(@irownumber as varchar)+', '+cast(@minutestolookback as varchar)

--- populate #res2 for 
insert into #res2
select @isrobjectid,@ilocationnumber,@iipaddress,@ibegindateutc,@irownumber

fetch next from innercursor into @isrobjectid,@ilocationnumber,@iipaddress,@ibegindateutc,@irownumber
end--while
close innercursor
deallocate innercursor

--
--process
declare @maxrow int,@i int,@newestsrobjectid bigint,@newesttime datetime,@nextsrobjectid bigint, @nexttime datetime
set @newesttime=(select ibegindateutc from #res2 where irownumber=1)
set @newestsrobjectid=(select isrobjectid from #res2 where irownumber=1)
set @i=1
set @maxrow =(select max(irownumber) from #res2)

while @i <= @maxrow ---1--set this for how many rows to keep i.e. keep one rows.
begin
	--set these values for how many survyes to keep for i.e. more than two surveys in a time period
	set @nexttime=(select ibegindateutc from #res2 where irownumber = @i+1)
	set @nextsrobjectid=(select isrobjectid from #res2 where irownumber = @i+1)

	if datediff(mi,@nexttime,@newesttime) <=@minutestolookback
		insert into #res3 select @newestsrobjectid

set @newesttime=(select ibegindateutc from #res2 where irownumber=@i+1)--set these for how many to keep
set @newestsrobjectid=(select isrobjectid from #res2 where irownumber=@i+1)

--	set @newesttime=@nexttime
--	set @newestsrobjectid=@nextsrobjectid

set @i=@i+1
end --while


select * from #res2
set @count=@count+1
fetch next from mycursor into @locationnumber,@ipaddress

end--while
close mycursor
deallocate mycursor

select * from #res3
Print Cast(@count as varchar) +' Records Processed'

--------
----update surveyrsponse
update surveyresponse with (rowlock)
set externalid=cast(offerobjectid as varchar)
where objectid in (
select srobjectid from #res3)
--
update surveyresponse with (rowlock)
set offerobjectid=1637, locationObjectId=309010
where objectid in (
select srobjectid from #res3)
-----------
----update surveyresponseanswer
-------------------
declare @counter int,@sraobjectid int,@srobjectid int,@locationnumber2 varchar(1000),@locationname varchar(1000),@newsequence int
set @counter=0

declare mycursor2 cursor for
--select srobjectid,locationnumber,locationname from #res3

select sr.objectid,l.locationnumber,l.name
        FROM   location l WITH (nolock)
               JOIN surveyresponse sr with (nolock)
					ON l.objectid=sr.locationobjectid
			   join #res3 r
				 on r.srobjectid=sr.objectid

open mycursor2
fetch next from mycursor2 into @srobjectid,@locationnumber2,@locationname
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
select @srobjectid,@newsequence,@locationnumber2,18276 

----insert orig locationname into sratextvalue
--fix


--insert into surveyresponseanswer(
--surveyResponseObjectId,
--sequence,
--textvalue,
--dataFieldObjectId
--)
--select @srobjectid,@newsequence+1,@locationname,18276 

set @counter=@counter+1
print cast(@counter as varchar)+' ,'+cast(@srobjectid as varchar)+' ,'+@locationnumber2+' ,'+@locationname
fetch next from mycursor2 into @srobjectid,@locationnumber2,@locationname
end--while
close mycursor2
deallocate mycursor2
print cast(@count as varchar) +' Records Processed'
-------------
declare @res1 table(textval varchar(10),sraobjectid bigint)
insert into @res1
select 
cast(locationnumber as varchar) textval,sraobjectid from (
select externalid,sr.objectid srobjectid,sra.objectid sraobjectid--,*--sra.objectid
from location l
JOIN surveyresponse sr with (nolock)
ON l.objectid=sr.locationobjectid
join surveyresponseanswer sra with (nolock)
on sr.objectid=sra.surveyresponseobjectid
join datafield df with (nolock)
on df.objectid=sra.datafieldobjectid
where offerObjectId=1637 and locationObjectId=309010
and df.objectid=18276
and textvalue='IP') as a
join (
select locationnumber,oc.objectid--*
from location l
join offercode oc 
on l.objectid=oc.locationobjectid 
) as b
on cast(a.externalid as int)=b.objectid

--select * from @res1 order by sraobjectid
----
update surveyresponseanswer with (rowlock)
set textvalue=
--select
textval 
from @res1 r
join surveyresponseanswer sra
on r.sraobjectid=sra.objectid
------
--declare @count5 int,@sraobjectId5 int,@txtval5	varchar(10)
--
--set @count5=0
--
--declare mycursor5 cursor for
--select textval,sraobjectid from @res1 --where textval not like '%IP%'
--
--open mycursor5
--fetch next from mycursor5 into @sraobjectId5,@txtval5
--
--while @@Fetch_Status=0
--begin
--
----set 
--select top 1 locationnumber 
--from location l
--join offercode oc
--on l.objectid=oc.locationobjectid
--where oc.objectid=
----update surveyresponseanswer with (rowlock) set textvalue=cast(@txtval5 as varchar) where objectid=@sraobjectid5
--
--print cast(@count5 as varchar)+', '+@txtval5+', '+cast(@sraObjectId5 as varchar)
--
--set @count5=@count5+1
--fetch next from mycursor5 into @sraobjectId5,@txtval5
--
--end--while
--close mycursor5
--deallocate mycursor5
--Print Cast(@count5 as varchar) +' Records Processed'


--
--------------------------
----exec [dbo].[usp_cust_McDIPspike4] 
--
------chk
--select sr.objectid,l.locationnumber,l.name,sr.ipaddress,sr.begindate,sr.begintime,sr.begindateutc,sr.offerCodeObjectId,sr.externalid
--from location l join offercode oc
--on l.objectid=oc.locationobjectid
--join surveyresponse sr
--on oc.objectid = sr.offerCodeObjectId
--where l.organizationobjectid=537
--and sr.begindate >'02/25/2010'
--and sr.complete=1
--and l.enabled= 1
--and sr.offerCodeObjectId=910139
--order by locationnumber,ipaddress,begindateUTC desc
--
--select * from surveyresponse sr
--join surveyresponseanswer sra
--on sr.objectid=sra.surveyresponseobjectid where surveyresponseobjectid =58104689
----
----chk
--declare @begindt datetime,@enddt datetime
--set @begindt='8/1/2009'
--set @enddt=getutcdate()
--select sr.objectid,l.locationnumber,sr.ipaddress,sr.begindate,sr.begintime,sr.begindateUTC
--        FROM   location l WITH (nolock)
--               JOIN offercode oc WITH (nolock)
--                 ON l.objectid = oc.locationobjectid
--               JOIN surveyresponse sr WITH (nolock)
--                 ON oc.objectid = sr.offercodeobjectid
--        WHERE  l.organizationobjectid = 569
--			   And modetype=2
--               AND l.objectid IN (SELECT locationobjectid
--                                  FROM   dbo.Ufn_app_locationsincategoryoftype(1003)
--                                  WHERE  locationcategoryobjectid = 14999)--Canada
--
--               AND sr.offercodeobjectid != 800575
--			   AND begindateUTC between @begindt and @enddt
--               AND l.enabled = 1
--               AND l.hidden = 0
--               AND sr.complete = 1
--order by locationnumber,ipaddress,begindateutc desc;

-----------
--select * 
--from surveyresponse sr join surveyresponseanswer sra
--on sr.objectid=sra.surveyresponseobjectid
--where sr.offercodeobjectid=800575
--and sra.datafieldobjectid=28288
----
----28289
--select * 
--from surveyresponse sr join surveyresponseanswer sra
--on sr.objectid=sra.surveyresponseobjectid
--where sra.datafieldobjectid=28289
----
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
