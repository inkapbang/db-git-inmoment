SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select datepart(weekday,getdate())
--
--select datename(dw,getdate())
--
--use warehousei
--go
--
--select * from location l
--join offercode oc
--on l.objectid=oc.locationobjectid
--join surveyresponse sr
--on oc.objectid=sr.offercodeobjectid
--where l.organizationobjectid in (
--select objectid from organization where name like 'express%'
--)
--
----select * from datafield where organizationobjectid =734 order by objectid 
------------
CREATE procedure [dbo].[usp_cust_expressadddayofweek]
as
declare @dt datetime
set @dt = dateadd(yy,-3,getdate())

declare @res table(srobjectid int)

insert into @res
select sr.objectid 
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid = 734
and sr.complete=1
and sr.begindate >=@dt

except

select distinct sr.objectid  
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
join surveyresponseanswer sra with (nolock)
on sr.objectid=sra.surveyresponseobjectid
where l.organizationobjectid = 734
and sra.datafieldobjectid=22061
and sr.complete=1
and sr.begindate >=@dt

select * from @res

--dbo.usp_cust_expressadddayofweek
------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
