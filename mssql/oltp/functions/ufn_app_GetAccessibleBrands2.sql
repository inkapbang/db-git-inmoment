SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_GetAccessibleBrands2](@userObjectId INT)
RETURNS @ReturnVal TABLE(brandObjectId INT)
AS BEGIN
  DECLARE @accessibleLocations TABLE(objectId INTEGER)
  DECLARE @accessibleLocationCategories TABLE(objectId INTEGER)

  INSERT INTO @accessibleLocations (objectId)
    SELECT objectId
    FROM ufn_app_UserAccessibleLocations(@userObjectId);

  INSERT INTO @accessibleLocationCategories (objectId)
    SELECT objectId
    FROM ufn_app_UserAccessibleLocationCategories(@userObjectId);

  WITH BrandsWithDescendents (brandObjectId) AS (
    SELECT DISTINCT c.brandObjectId
    FROM @accessibleLocations al
      INNER JOIN LocationCategoryLocation lcl ON al.objectId = lcl.locationObjectId
      INNER JOIN LocationCategory c ON c.objectId = lcl.locationCategoryObjectId AND c.snapshotFromLocationCategoryObjectId IS NULL
      INNER JOIN LocationCategoryType t ON t.objectId = c.locationCategoryTypeObjectId AND t.snapshotFromLocationCategoryTypeObjectId IS NULL
      INNER JOIN Hierarchy h ON h.objectId = t.hierarchyObjectId
    WHERE h.branded = 1

    UNION

    SELECT DISTINCT lc.brandObjectId
    FROM @accessibleLocationCategories alc
      INNER JOIN LocationCategory lc ON lc.objectId = alc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
      INNER JOIN LocationCategoryType t ON t.objectId = lc.locationCategoryTypeObjectId AND t.snapshotFromLocationCategoryTypeObjectId IS NULL
      INNER JOIN Hierarchy h ON h.objectId = t.hierarchyObjectId
    WHERE h.branded = 1

    UNION ALL

    SELECT objectId AS brandObjectId
    FROM Brand b
      INNER JOIN BrandsWithDescendents parent
        ON b.parentObjectId = parent.brandObjectId
  )
  INSERT INTO @ReturnVal (brandObjectId)
    SELECT DISTINCT brandObjectId
    FROM BrandsWithDescendents
  OPTION (MAXRECURSION 50)

  RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
