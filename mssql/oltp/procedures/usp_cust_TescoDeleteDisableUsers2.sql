SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_TescoDeleteDisableUsers2]
as 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_TescoDeleteDisableUsers]') AND type in (N'U'))
DROP TABLE [dbo].[_TescoDeleteDisableUsers];


select uac.objectId into _TescoDeleteDisableUsers from useraccount uac 
join OrganizationUserAccount ouac
on uac.objectId=ouac.userAccountObjectId
where ouac.organizationObjectId in(1508,1996,2096,1903,1746,2106,2115,2171,2062,1214)
and uac.enabled=0;

--select * from _TescoDeleteDisableUsers
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_TescoDeleteDisableUsers3]') AND type in (N'U'))
DROP TABLE [dbo].[_TescoDeleteDisableUsers3];

select pleuac.userAccountObjectId,max(creationDateTime) as p 
into _TescoDeleteDisableUsers3
from PageLogEntry ple
join PageLogEntryUserAccount pleuac  
on ple.objectid=pleuac.pageLogEntryObjectId
where userAccountObjectId in(
select objectId from _TescoDeleteDisableUsers
)
group by pleuac.userAccountObjectId
order by pleuac.userAccountObjectId;
--select * from _TescoDeleteDisableUsers3

alter table _TescoDeleteDisableUsers add PLElastlogin datetime;

update _TescoDeleteDisableUsers
set PLElastLogin=
--select 
td3.P
from _TescoDeleteDisableUsers3 td3
join _TescoDeleteDisableUsers td
on td.objectId=td3.userAccountObjectId;

--select * from _TescoDeleteDisableUsers order by PLELastlogin

--select * from surveyResponseNote where useraccountobjectid in (
--select objectid from _TescoDeleteDisableUsers
--);

--exec usp_cust_TescoDeleteDisableUsers

declare @count int,@uacid	int

set @count=0

declare mycursor cursor for
select * from _TescoDeleteDisableUsers where PLElastlogin is null or PLELastlogin < DATEADD(DD,-120,GETDATE());

open mycursor
fetch next from mycursor into @uacid
while @@Fetch_Status=0
begin
print cast(@count as varchar)+', '+cast(@uacid as varchar)
delete from PageScheduleOptOut where userAccountObjectId =@uacid
delete from UserAccountLocationCategory where userAccountObjectId  =@uacid
delete from UserAccountLocation where userAccountObjectId  =@uacid
delete from PasswordHistory where userAccountObjectId  =@uacid
delete from UserAccountRole where userAccountObjectId  =@uacid
delete from OrganizationUserAccount where userAccountObjectId  =@uacid
delete from SurveyResponseNote where userAccountObjectId  =@uacid
set @count=@count+1
fetch next from mycursor into @uacid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
