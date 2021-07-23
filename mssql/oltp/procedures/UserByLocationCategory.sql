SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[UserByLocationCategory] @OrgId int 

as

/*

Usage: 

exec UserByLocationCategory 1448

*/

set nocount on;


select  lc.name 'LocationCategory'
, lct.name 'LocationCategoryType'
, u.firstName
, u.lastName
, u.email
, case when u.enabled = 0 then 'disable' else '' end [Disable]
, u.externalId
, u.localeKey
, u.passwordPolicyOrganizationObjectId
, case when r.role = 3 then 'Og Manager'  when r.role = 8 then 'User'  when r.role = 13 then 'Report Subscriber' else '' end [Role]
, max(ple.creationDateTime) as [lastLogin]
into #tmp
from UserAccount (nolock) u
join UserAccountRole r (nolock) on r.userAccountObjectId = u.objectId
join UserAccountLocationCategory ulc (nolock) on ulc.userAccountObjectId =u.objectId
join LocationCategory lc (nolock) on ulc.locationCategoryObjectId = lc.objectId
join LocationCategoryType lct(nolock) on lc.LocationCategoryTypeObjectId = lct.objectId
left join PageLogEntryUserAccount pleua with (nolock) on (u.objectId=pleua.userAccountObjectId)
left join PageLogEntry ple with (nolock) on (pleua.pageLogEntryObjectId=ple.objectId)
where 1=1 
and lc.organizationObjectId = @OrgId
and ple.pageScheduleObjectId is null
group by lc.name 
, lct.name 
, u.firstName
, u.lastName
, u.email
, case when u.enabled = 0 then 'disable' else '' end 
, u.externalId
, u.localeKey
, u.passwordPolicyOrganizationObjectId
, case when r.role = 3 then 'Og Manager'  when r.role = 8 then 'User'  when r.role = 13 then 'Report Subscriber' else '' end



SELECT 
LocationCategory
, LocationCategoryType
, firstname
, lastname
, email
, [Disable]
, externalId
, localeKey
, passwordPolicyOrganizationObjectId
, lastLogin
, Roles=stuff((select ', ' + Role from #tmp 
where LocationCategory=a.LocationCategory
and firstname = a.firstname
and lastName = a.lastname 
and email = a.email 
for xml path(''), type).value('.[1]', 'nvarchar(max)'),1,2,'')
from #tmp a
group by 
 LocationCategory
, LocationCategoryType
, firstname
, lastName
, email
, [Disable]
, externalId
, localeKey
, passwordPolicyOrganizationObjectId
, lastLogin


drop table #tmp
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
