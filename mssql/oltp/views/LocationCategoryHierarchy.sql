SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW LocationCategoryHierarchy AS
WITH HierarchyCTE(objectId, organizationObjectId, [name], parentObjectId, locationCategoryTypeObjectId, hierarchyLevel)
AS
(
	SELECT
		objectId, 
		organizationObjectId, 
		[name],
		parentObjectId, 
		LocationCategoryTypeObjectId,
		1 AS hierarchyLevel
	FROM dbo.LocationCategory
	WHERE parentObjectId IS NULL
	
	UNION ALL
	
	SELECT
		lc.objectId, 
		lc.organizationObjectId, 
		lc.[name], 
		lc.parentObjectId, 
		lc.LocationCategoryTypeObjectId,
		hcte.hierarchyLevel + 1 AS
		hierarchyLevel
	FROM dbo.LocationCategory AS lc
	INNER JOIN HierarchyCTE AS hcte ON lc.parentObjectId = hcte.objectId
)

SELECT
	objectId,
	organizationObjectId,
	[name],
	parentObjectId,
	locationCategoryTypeObjectId,
	hierarchyLevel
FROM HierarchyCTE
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
