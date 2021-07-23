SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_UserAccessibleLocationsForOrg](@UserObjectId INT, @orgObjectId INT)
RETURNS TABLE
AS
RETURN
			WITH LC AS
			(
				SELECT c.objectId
				FROM UserAccountLocationCategory userLocCats
				INNER JOIN LocationCategory lc ON userLocCats.locationCategoryObjectId = lc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
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
				AND lc.organizationObjectId = @orgObjectId
			)
SELECT DISTINCT (lcl.[locationObjectId]) AS objectId
FROM [dbo].[LocationCategoryLocation] lcl
JOIN LC ON lcl.[locationCategoryObjectId] = LC.[objectId]

UNION

SELECT locationObjectId as objectId FROM UserAccountLocation lac
INNER JOIN Location l ON lac.locationObjectId = l.objectId
WHERE lac.userAccountObjectId = @userObjectId
AND l.organizationObjectId = @orgObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
