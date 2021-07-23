SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_UserAccessibleLocationsForHierarchy](@UserObjectId INT, @hierarchyObjectId INT)
RETURNS TABLE
AS
RETURN
			WITH LC AS
			(
				SELECT c.objectId
				FROM UserAccountLocationCategory userLocCats
				INNER JOIN LocationCategory lc ON userLocCats.locationCategoryObjectId = lc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
                INNER JOIN LocationCategoryType lct ON lc.LocationCategoryTypeObjectId = lct.objectId AND lct.snapshotFromLocationCategoryTypeObjectId IS NULL
					JOIN LocationCategory p
						ON userLocCats.locationCategoryObjectId = p.objectId AND p.snapshotFromLocationCategoryObjectId IS NULL
					JOIN [dbo].[LocationCategory] c
						ON p.[objectId] = userLocCats.locationCategoryObjectId
							AND c.leftExtent >= p.leftExtent
							AND c.rightExtent <= P.rightExtent
							AND c.rootObjectId = (SELECT rootObjectId
									 FROM LocationCategory
									 WHERE objectId = userLocCats.locationCategoryObjectId)
							AND c.snapshotFromLocationCategoryObjectId IS NULL
				WHERE userLocCats.userAccountObjectId = @userObjectId
				AND lct.hierarchyObjectId = @hierarchyObjectId
			)
SELECT DISTINCT (lcl.[locationObjectId]) AS objectId
FROM [dbo].[LocationCategoryLocation] lcl
JOIN LC ON lcl.[locationCategoryObjectId] = LC.[objectId]

UNION

SELECT lac.locationObjectId as objectId FROM UserAccountLocation lac
INNER JOIN Location l ON lac.locationObjectId = l.objectId
INNER JOIN LocationCategoryLocation lcl ON l.objectId = lcl.locationObjectId
INNER JOIN LocationCategory lc ON lcl.locationCategoryObjectId = lc.objectId
INNER JOIN LocationCategoryType lct ON lct.objectId = lc.LocationCategoryTypeObjectId
WHERE lac.userAccountObjectId = @userObjectId
AND lct.hierarchyObjectId = @hierarchyObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
