SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Proc [dbo].[usp_admin_User_audit1]
as

select 'Global',u.firstname,u.lastname,u.email,u.objectid,0 as role
from useraccount u with (nolock)
where Global=1
and enabled=1

union all

select Rolename=
case role
when 1 then 'SYS_ADMIN'
when 2 then 'ORG_SETUP'
when 3 then 'ORG_MANAGER'
when 4 then 'SSO_BYPASS'
when 5 then 'SURVEY_EDITOR'
when 6 then 'REPORT_EDITOR'
when 7 then 'USER_MANAGER'
when 8 then 'USER' 
when 9 Then 'TRANSLATOR'
when 10 then 'TRANSCRIBER'
when 11 then 'EMPLOYEE_MANAGER'
when 12 then 'CUSTOMER_SERVICE_REP'
when 13 then 'REPORT_SUBSCRIBER'
when 14 then 'PERSONAL_DATA_VIEWER'
when 15 then 'ORG_ADMIN'
--when 16 then 'SM_VIEWER'
when 17 then 'LARGE_REPORT_ROWCOUNT'
when 18 then 'TAGGER'
when 19 then 'PILOT'
when 101 then 'WEB_SERVICE_SURVEY_DATA_EXPORT'
when 102 then 'WEB_SERVICE_SURVEY_DATA_IMPORT'
when 103 then 'WEB_SERVICE_STRUCTURE_EXPORT'
when 104 then 'WEB_SERVICE_STRUCTURE_IMPORT'
when 105 then 'WEB_SERVICE_MINDSHARE_DESKTOP'
when 106 then 'WEB_SERVICE_INBOUND_PHONE_SURVEY_INIT'
when 107 then 'WEB_SERVICE_INBOUND_WEB_SURVEY_INIT'
when 108 then 'WEB_SERVICE_OUTBOUND_PHONE_SURVEY_INIT'
when 109 then 'WEB_SERVICE_OUTBOUND_WEB_SURVEY_INIT'
else 'Unknown' 
end,
u.firstname,u.lastname,u.email,u.objectid,uar.role
from useraccount u with (nolock)join useraccountrole uar with (nolock)
on u.objectid=uar.useraccountobjectid
where role in (select distinct role from useraccountrole)
and role not in (8,13)
and u.enabled=1
order by role,lastname

--exec dbo.usp_admin_User_audit1

--exec publishproc 'mindshare','usp_admin_User_audit'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
