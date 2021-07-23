SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
select * from _AAA_UserAlert_Exemption
--*/

CREATE proc [dbo].[usp_cust_AAA_UserAlert]
as
begin
	-- Created: 20150828
	-- Author: TAR
	-- Purpose: DBA-837 - this procedure generates a list of users associated with the AAA organization who are 
	--		not authorized to be associated with the client.
	-- Modified: TAR - 20150902 - changed process to ignore inactive users

	-- this is the set of excluded users and domains which are permitted on the AAA account.
	--select * from _AAA_UserAlert_Exemption
	
	-- get list of all users attached to org
	-- attached to locations
	select ua.objectid as UserAccountObjectId, ua.Email, ua.LastName, ua.FirstName
	, right(ua.email, len(ua.email) - patindex('%@%', ua.email)+1) as domain
	, 'Access by Location' as AccessSource
	into #users
	from useraccount (nolock) ua
	inner join useraccountlocation (nolock) ual on ual.useraccountobjectid = ua.objectid
	inner join location (nolock) l on l.objectid = ual.locationobjectid
	where l.organizationobjectid = 1481
	and ua.enabled = 1
	union
	-- attached to location categories
	select ua.objectid as UserAccountObjectId, ua.Email, ua.LastName, ua.FirstName
	, right(ua.email, len(ua.email) - patindex('%@%', ua.email)+1) as domain
	, 'Access by LocationCategory' as AccessSource
	from useraccount (nolock) ua
	inner join useraccountlocationcategory (nolock) ual on ual.useraccountobjectid = ua.objectid
	inner join locationcategory (nolock) l on l.objectid = ual.locationcategoryobjectid
	where l.organizationobjectid = 1481
	and ua.enabled = 1
	union
	-- attached to the organization
	select ua.objectid as UserAccountObjectId, ua.Email, ua.LastName, ua.FirstName
	, right(ua.email, len(ua.email) - patindex('%@%', ua.email)+1) as domain
	, 'Access by Organization' as AccessSource
	from useraccount (nolock) ua
	inner join organizationuseraccount (nolock) oua on oua.useraccountobjectid = ua.objectid
	where oua.organizationobjectid = 1481
	and ua.enabled = 1

	-- testing
	--select * from #users

	-- remove exempted SpecificUsers
	delete from #users
	where email in (select SpecificEmail from _AAA_UserAlert_Exemption)

	-- testing
	--select * from #users

	-- delete users with domains that are exempt
	delete from #users 
	where email in (
	select u.email
	from #users u
	inner join _AAA_UserAlert_Exemption e on e.PartialDomain = left(u.domain, len(e.PartialDomain))
	)

	-- final user set
	select * from #users
	order by AccessSource desc, email

	-- cleanup
	drop table #users

end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
