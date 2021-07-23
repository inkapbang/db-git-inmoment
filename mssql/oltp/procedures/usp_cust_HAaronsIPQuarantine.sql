SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select * from organization where name like 'aaron%'--814
--
--select sr.*
--into _herc
--from location l with (nolock)
--join offercode oc with (nolock)
--on l.objectid=oc.locationobjectid
--join surveyresponse sr with (nolock)
--on oc.objectid=sr.offercodeobjectid
--where l.organizationobjectid=814
--
--select * from _herc
--where (ipaddress='12.41.204.3' or ipaddress='12.10.127.58')and complete=1  order by begindate 
--
--select *
--from location l
--join offercode oc
--on l.objectid=oc.locationobjectid
--where l.organizationobjectid=814
--and offercode like '99%'--349535
--and name like 'z%'
-------------------------
CREATE procedure [dbo].[usp_cust_HAaronsIPQuarantine]
as

/*
This procedure scrubs Hertz equipment rental co surveys, moves them to offercode 349535
It preserves the original offercodes in externalid

--Bob Luther 7/30/2010

exec dbo.usp_cust_HercIPQuarantine
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_AaronsIPscrub]') AND type in (N'U'))
DROP TABLE [dbo].[_AaronsIPscrub];

with mycte as (
select sr.*
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid=814
and sr.begindate >= dateadd(dd,-3,getdate())
)

select *
into _AaronsIPscrub 
from mycte
where ( ipaddress='208.100.40.44'
or ipaddress='72.52.96.4'
or ipaddress='216.52.207.72/29'
or ipaddress='216.52.207.65'
or ipaddress='216.52.207.66'
or ipaddress='208.100.40.34'
or ipaddress='208.100.40.35'
or ipaddress='208.100.40.37'
or ipaddress='208.100.40.40/29'
or ipaddress='72.52.96.16'
or ipaddress='72.52.96.9'
or ipaddress='72.52.96.11'
or ipaddress='72.52.96.14'
or ipaddress='72.52.96.16'
or ipaddress='72.52.96.18'
or ipaddress='209.51.184.2'
or ipaddress='209.51.184.3'
or ipaddress='209.51.184.8/29'
or ipaddress='66.151.103.1'
or ipaddress='66.151.103.2'
or ipaddress='66.151.103.8/29'
or ipaddress='12.177.80.3'

)
and complete=1
and not (offerObjectId=2218 and locationObjectId=370544)--offercodeobjectid != 1073994

select * from _AaronsIPscrub
update surveyresponse with (rowlock)
set externalid=cast(offerobjectid as varchar(25)),offerObjectId=2218,locationObjectId=370544--offercodeobjectid=1073994
where objectid in (
select objectid from _AaronsIPscrub
)

select * from surveyresponse where objectid in(
select objectid from _AaronsIPscrub
)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_AaronsIPscrub]') AND type in (N'U'))
DROP TABLE [dbo].[_AaronsIPscrub]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
