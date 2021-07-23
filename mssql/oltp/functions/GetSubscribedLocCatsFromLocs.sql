SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  FUNCTION GetSubscribedLocCatsFromLocs(@locationCriteriaList VARCHAR(200), @subscribedLocCatTypesList VARCHAR(200))
RETURNS TABLE
AS
RETURN (select subscribed.objectId from
	(select distinct locationcategory.objectid, lineage from locationcategory
		inner join LocationCategoryLocation on
			locationcategory.objectId = LocationCategoryLocation.locationCategoryObjectId
	 where
		locationcategorylocation.locationobjectid in (select token from Split(@locationCriteriaList, ','))) as RunForLocCats,
	(select objectid, lineage, name from locationcategory
	 where locationcategorytypeobjectid in (select token from Split(@subscribedLocCatTypesList, ','))) as Subscribed
	where
	 RunForLocCats.objectId = Subscribed.objectId OR
	 RunForLocCats.lineage like '%/' + cast(Subscribed.objectid as VARCHAR(10)) + '/%')
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
