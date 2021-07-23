SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[UserByLocation] @OrgId int 

as

/*

Usage: exec UserByLocation 1448

*/

set nocount on;

select l.name 'LocationNumber'
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
from UserAccount u (nolock)
join UserAccountRole (nolock) r on r.userAccountObjectId = u.objectId
join userAccountLocation (nolock) ul on u.Objectid = ul.userAccountObjectId
join Location (nolock) l on l.objectid = ul.locationObjectId
left join PageLogEntryUserAccount pleua with (nolock) on (u.objectId=pleua.userAccountObjectId)
left join PageLogEntry ple with (nolock) on (pleua.pageLogEntryObjectId=ple.objectId)
where l.organizationObjectId = @OrgId
and ple.pageScheduleObjectId is null
group by  l.name 
, u.firstName
, u.lastName
, u.email
, case when u.enabled = 0 then 'disable' else '' end 
, u.externalId
, u.localeKey
, u.passwordPolicyOrganizationObjectId
, case when r.role = 3 then 'Og Manager'  when r.role = 8 then 'User'  when r.role = 13 then 'Report Subscriber' else '' end


SELECT 
LocationNumber
, firstname
, lastname
, email
, [Disable]
, externalId
, localeKey
, passwordPolicyOrganizationObjectId
, LastLogin 
, Roles=stuff((select ', ' + Role 
from #tmp 
where LocationNumber=a.locationnumber 
and firstname = a.firstname
and lastName = a.lastname 
and email = a.email 
for xml path(''), type).value('.[1]', 'nvarchar(max)'),1,2,'')
from #tmp a
group by locationNumber
, firstname
, lastName
, email
, [Disable]
, externalId
, localeKey
, passwordPolicyOrganizationObjectId
, LastLogin 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
