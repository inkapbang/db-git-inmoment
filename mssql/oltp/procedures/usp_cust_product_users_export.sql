SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure usp_cust_product_users_export
as 
begin
	-- Created: 20151027
	-- Author: TAR
	-- Purpose: DBA-1284 - this process generates the output details of successfully authenticated
	--		users against the app.  By default it runs for the prior three months.

	-- internal vars
	declare @StartDt smalldatetime, @EndDt smalldatetime

	-- set date bounds for prior 3 months (from rundate)
	set @EndDt = cast(floor(cast(getDate() as float)) as smalldatetime)
	set @StartDt = DateAdd(mm, -3, @EndDt)

	-- testing
	--select @StartDt, @EndDt

	-- get output
	select distinct ua.objectId as UserAccountObjectId
	, cast(ua.email as nvarchar(100)) as Email
	, cast(ua.FirstName as nvarchar(50)) as FirstName
	, cast(ua.LastName as nvarchar(50)) as LastName
	, cast(ua.LocaleKey as nvarchar(25)) as Locale
	, cast(ua.TimeZone as nvarchar(50)) as TimeZone
	, case when ua.mindshareemployee = 1 then N'Y' else N'N' end as InMomentEmployee
	, o.objectId as OrgId
	, cast(o.name as nvarchar(100)) as OrganizationName
	from accessEventLog ael (nolock)
	inner join UserAccount ua (nolock) on ua.objectid = ael.userAccountObjectId
	left outer join OrganizationUserAccount oua (nolock) on oua.userAccountObjectId = ua.objectid
	left outer join Organization o (nolock) on o.objectid = oua.organizationObjectId
	where ael.eventtype = 0 -- success
	and ael.timestamp between @StartDt and @EndDt
	order by Email, OrganizationName


end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
