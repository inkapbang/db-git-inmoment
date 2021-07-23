SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select *
--from organization where name like 'hertz%'--706
--
--select sr.*
--into _herc
--from location l with (nolock)
--join offercode oc with (nolock)
--on l.objectid=oc.locationobjectid
--join surveyresponse sr with (nolock)
--on oc.objectid=sr.offercodeobjectid
--where l.organizationobjectid=706
--
--select * from _herc
--where (ipaddress='12.41.204.3' or ipaddress='12.10.127.58')and complete=1  order by begindate 
--
--select *
--from location l
--join offercode oc
--on l.objectid=oc.locationobjectid
--where l.organizationobjectid=706
--and offercode like 'z99%'--349535
--and name like 'z%'
-------------------------
CREATE procedure [dbo].[usp_cust_HercIPQuarantine]
as

/*
This procedure scrubs Hertz equipment rental co surveys, moves them to offercode 349535
It preserves the original offercodes in externalid

--Bob Luther 7/30/2010

exec dbo.usp_cust_HercIPQuarantine
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_HercIPscrub]') AND type in (N'U'))
DROP TABLE [dbo].[_HercIPscrub];

with mycte as (
select sr.*
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid=706
and sr.begindate >= dateadd(dd,-3,getdate())
)

select *
into _HercIPscrub 
from mycte
where (ipaddress='12.41.204.3' or ipaddress='12.10.127.58')
and complete=1
and not (offerObjectId=1279 and locationObjectId=150988)--offercodeobjectid != 349535

select * from _HercIPscrub
update surveyresponse with (rowlock)
set externalid=cast(offerobjectid as varchar(25)),offerObjectId=1279,locationObjectId=150988--offercodeobjectid=349535
where objectid in (
select objectid from _HercIPscrub
)

select * from surveyresponse where objectid in(
select objectid from _HercIPscrub
)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_HercIPscrub]') AND type in (N'U'))
DROP TABLE [dbo].[_HercIPscrub]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
