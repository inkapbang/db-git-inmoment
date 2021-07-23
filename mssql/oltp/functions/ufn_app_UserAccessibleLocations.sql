SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_UserAccessibleLocations](@userObjectId INT)
RETURNS TABLE
AS
RETURN
WITH LC AS (
    SELECT c.objectId
    FROM UserAccountLocationCategory userLocCats
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
)
SELECT DISTINCT (lcl.[locationObjectId]) AS objectId
FROM
  [dbo].[LocationCategoryLocation] lcl
  JOIN LC
    ON lcl.[locationCategoryObjectId] = LC.[objectId]

UNION

SELECT locationObjectId AS objectId
FROM UserAccountLocation
WHERE UserAccountLocation.userAccountObjectId = @userObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
