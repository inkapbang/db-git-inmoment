SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[usp_cust_JiffyHeartlandUserActivity]
@fromDt datetime = null
, @toDt datetime = null
as
begin
	-- Created: 20150727
	-- Author: TAR
	-- Purpose: DBA-648 - this process generates data for a given period (bi-weekly if params are not 
	--		supplied).  This process is run from a job on one of the warehouse processes, and the results
	--		stored in a table and then delivered to the client.
	-- NOTE: Output is formatted to support delivery by msdb.dbo.sp_send_dbmail

	-- determine dates to use
	if @fromDt is null or @toDt is null
	begin
		set @toDt = cast(floor(cast(getDate() as float)) as smalldatetime) -- start of day
		set @fromDt = DateAdd(day, -14, @toDt) -- 2 weeks prior
	end

	;with cte (LocationCategoryName, LocationCategoryObjectId, CategoryType, Lineage, Level, leftextent)
	as
	(
		-- anchor
		select cast(lc.name as varchar) as LocationCategoryName, lc.objectid as LocationCategoryObjectId
		, lct.name as CategoryType
		, lc.Lineage
		, 1 as Level, lc.leftextent
		from locationcategory (nolock) lc
		inner join locationcategorytype (nolock) lct on lct.objectid = lc.locationcategorytypeobjectid
		where lc.organizationobjectid = 921 -- Jiffy
		and lc.locationcategorytypeobjectid = 29910 -- Franchise
		and lc.name = 'Heartland, Inc.'

		union all
		
		select cast(replicate('    ', cte.level) + lc.name as varchar) as LocationCategoryName, lc.objectid as LocationCategoryObjectId
		, lct.name as CategoryType
		, lc.lineage
		, cte.Level + 1 as Level, lc.leftextent
		from locationCategory (nolock) lc
		inner join locationcategorytype (nolock) lct on lct.objectid = lc.locationcategorytypeobjectid
		inner join cte on cte.LocationCategoryObjectId = lc.parentobjectId
		where lc.snapshotFromLocationCategoryObjectId IS NULL
	)

	select N'"' + LocationCategoryName+ N'"' as LocationCategoryName
	, '"' + CategoryType + '"' as CategoryType
	, '"' + Email + '"' as Email
	, LoginCount
	from (

	select cte.LocationCategoryName, cte.CategoryType 
	, isnull(ua.email, '') as Email
	, isnull(case when ael.email is not null then count(ael.email) end, 0) as LoginCount
	, cte.leftextent
	from cte
	left outer join UserAccountLocationCategory (nolock) ualc on ualc.locationcategoryobjectid = cte.LocationCategoryObjectId
	left outer join UserAccount (nolock) ua on ua.objectid = ualc.useraccountobjectid 
		and (ua.email not like '%@inmoment.com' and ua.email not like '%@mshare.net' and ua.email not like '%@shell.com')
	left outer join AccessEventLog (nolock) ael on ael.userAccountObjectId = ua.objectid and ael.eventType = 0 -- authenticated
		and ael.timestamp between @fromDt and @toDt

	-- get highest items in the hierarchy only
	inner join (
		select ua.email
		, min(cte.leftextent) as MinLeftExtent
		from cte
		left outer join UserAccountLocationCategory (nolock) ualc on ualc.locationcategoryobjectid = cte.LocationCategoryObjectId
		left outer join UserAccount (nolock) ua on ua.objectid = ualc.useraccountobjectid
		left outer join AccessEventLog (nolock) ael on ael.userAccountObjectId = ua.objectid and ael.eventType = 0 -- authenticated
			and ael.timestamp between @fromDt and @toDt
		group by ua.email
	) as m on m.email = ua.email and m.MinLeftExtent = cte.leftExtent
	group by cte.LocationCategoryName, cte.CategoryType, cte.leftextent, ua.email, ael.email

	union

	-- append LocationCategory items where there are not UserAccounts associated
	select cte.LocationCategoryName, cte.CategoryType
	, isnull(ua.email, '') as Email
	, isnull(case when ael.email is not null then count(ael.email) end, 0) as LoginCount
	, cte.leftextent
	from cte
	left outer join UserAccountLocationCategory (nolock) ualc on ualc.locationcategoryobjectid = cte.LocationCategoryObjectId
	left outer join UserAccount (nolock) ua on ua.objectid = ualc.useraccountobjectid
	left outer join AccessEventLog (nolock) ael on ael.userAccountObjectId = ua.objectid and ael.eventType = 0 -- authenticated
		and ael.timestamp between @fromDt and @toDt
	where ua.email is null
	group by cte.LocationCategoryName, cte.CategoryType, cte.leftextent, ua.email, ael.email

	) t
	order by t.leftextent
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
