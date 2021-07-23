SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetCategoryLocations_LocationCategory](@categoryIdList VARCHAR(max))
RETURNS TABLE
AS RETURN
WITH LineageCTE(locationCategoryObjectId, locationCategoryName, parentObjectId, locationCategoryTypeObjectId, hierarchyLevel)
AS
(
	SELECT DISTINCT
		lc.objectId AS locationCategoryObjectId,
		lc.[name] AS locationCategoryName,
		lc.parentObjectId,
		lc.locationCategoryTypeObjectId,
		0 AS hierarchyLevel
	FROM LocationCategory lc
		INNER JOIN Split(@categoryIdList, ',') ids ON lc.objectId = ids.token
	
	UNION ALL
	
	SELECT
		lc.objectId AS locationCategoryObjectId,
		lc.[name] AS locationCategoryName,
		lc.parentObjectId,
		lc.LocationCategoryTypeObjectId,
		lcte.hierarchyLevel + 1 AS hierarchyLevel
	FROM dbo.LocationCategory AS lc
		INNER JOIN LineageCTE AS lcte ON lc.parentObjectId = lcte.locationCategoryObjectId
)

SELECT DISTINCT
	[cte].[locationCategoryObjectId]
FROM LineageCTE cte
INNER JOIN LocationCategoryLocation lcl on lcl.locationCategoryObjectId = cte.locationCategoryObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
