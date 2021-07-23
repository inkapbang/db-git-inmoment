SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create function [dbo].[ufn_test_component_GetSiblingLocations] (/*@locationId int,*/ @locationCategoryId int)
	returns table
	/*
		Returns a list of *sibling* locations. The specified locationId is excluded.
	*/
as return (

	with LineageCTE(locationCategoryObjectId, locationCategoryName, parentObjectId, locationCategoryTypeObjectId, hierarchyLevel)
	as
	(
		select distinct
			lc.objectId [locationCategoryObjectId],
			lc.[name] [locationCategoryName],
			lc.parentObjectId,
			lc.locationCategoryTypeObjectId,
			0 [hierarchyLevel]
		from
			LocationCategory lc
		where
			lc.objectId = @locationCategoryId
		
		union all
		
		select
			lc.objectId [locationCategoryObjectId],
			lc.[name] [locationCategoryName],
			lc.parentObjectId,
			lc.LocationCategoryTypeObjectId,
			(lcte.hierarchyLevel + 1) [hierarchyLevel]
		from
			dbo.LocationCategory lc
			inner join LineageCTE lcte on lc.parentObjectId = lcte.locationCategoryObjectId
	)

	select distinct
		lcl.locationObjectId [locationId],
		l.name [locationName],
		cte.[locationCategoryObjectId],
		cte.[locationCategoryName]
	from
		LineageCTE cte
		join LocationCategoryLocation lcl on lcl.locationCategoryObjectId = cte.locationCategoryObjectId
		join Location l on lcl.locationObjectId=l.objectId
	where
		l.enabled=1
		and l.hidden=0
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
