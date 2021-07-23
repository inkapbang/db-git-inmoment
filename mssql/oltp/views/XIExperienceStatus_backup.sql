SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[XIExperienceStatus_backup] AS
--XIExperienceStatus
select o.objectid 'orgid', o.name 'org'
, case ofs.xistatus when 3 then 'pilot' when 2 then 'Enabled' else 'legacy' end as 'XIState'
, count (ua.objectid) 'EnabledUsers', count(uar.useraccountobjectid) 'EnabledUsersPilotRole'
, isnull(SUM(CAST(ua.xiStatus AS INT)),0)'EnabledUsersXIExperienceToggleOn', convert(date,getdate()) as 'Date'
from organization o
left join OrganizationFocusSettings ofs on o.objectid = ofs.organizationobjectid
join organizationuseraccount oua on o.objectid = oua.organizationobjectid
join useraccount ua on oua.useraccountobjectid = ua.objectid
left join UserAccountRole uar on (ua.objectid = uar.useraccountobjectid and uar.role = 49)
where 1=1
and ua.email not like '%inmoment.com%'
and ua.email not like '%demo%'
and ua.email not like '%test%'
and ua.firstName not like '%test%'
and ua.lastName not like '%test%'
and ua.firstName not like '%demo%'
and ua.lastName not like '%demo%'
and ua.global = 0
and ua.mindshareEmployee = 0
group by o.objectid,o.name,ofs.xistatus
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
