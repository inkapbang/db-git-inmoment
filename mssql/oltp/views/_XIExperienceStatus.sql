SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[_XIExperienceStatus] AS
-- select * from _XIExperienceStatus
select o1.objectid 'orgid', o1.name, 
isnull(o2.XIState, 'legacy') XIState
, isnull(o2.EnabledUsers, 0) EnabledUsers
, isnull(o2.EnabledUsersPilotRole, 0) EnabledUsersPilotRole
, isnull(o2.EnabledUsersXIExperienceToggleOn, 0) EnabledUsersXIExperienceToggleOn
, convert(date,getdate()) as 'Date'
from Organization o1 
left join
(
select o.objectid 'orgid', o.name 'org'
, case ofs.xistatus when 3 then 'pilot' 
		when 2 then 'Enabled' else 'legacy' end as 'XIState'
, count (ua.objectid) 'EnabledUsers'
, count(uar.useraccountobjectid) 'EnabledUsersPilotRole'
, isnull(SUM(CAST(ua.xiStatus AS INT)),0)'EnabledUsersXIExperienceToggleOn'
, convert(date,getdate()) as 'Date'
from organization o
left join OrganizationFocusSettings ofs on o.objectid = ofs.organizationobjectid
left join organizationuseraccount oua on o.objectid = oua.organizationobjectid
left join useraccount ua on oua.useraccountobjectid = ua.objectid
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
group by o.objectid,o.name,ofs.xistatus) o2 on o1.objectId = o2.orgid

where (1=1
and o1.enabled=1
and o1.name NOT LIKE 'z%'
and o1.name not like '%Demo%'
and o1.name not like '%Delete%'
and o1.name not like '%Mindshare%'
)

--or REPLACE(o1.name, '''', '')  LIKE 'Zaxbys'
--or REPLACE(o1.name, '''', '')  LIKE 'Zizzi'
--or REPLACE(o1.name, '''', '')  LIKE 'Z Energy'
--or REPLACE(o1.name, '''', '')  LIKE 'Zippys'
--or REPLACE(o1.name, '''', '')  LIKE 'ZTejas'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
