SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_GetAccessibleBrands](@userObjectId int)
RETURNS @ReturnVal TABLE (brandObjectId int) 
AS BEGIN
	WITH BrandsWithDescendents (brandObjectId) AS (
		SELECT DISTINCT c.brandObjectId
		FROM ufn_app_UserAccessibleLocations(@userObjectId) al
		INNER JOIN LocationCategoryLocation lcl ON al.objectId = lcl.locationObjectId
		INNER JOIN LocationCategory         c   ON c.objectId  = lcl.locationCategoryObjectId AND c.snapshotFromLocationCategoryObjectId IS NULL
		INNER JOIN LocationCategoryType     t   ON t.objectId  = c.locationCategoryTypeObjectId AND t.snapshotFromLocationCategoryTypeObjectId IS NULL
		INNER JOIN Hierarchy                h   ON h.objectId  = t.hierarchyObjectId
		WHERE h.branded = 1

		UNION

		SELECT DISTINCT lc.brandObjectId
		FROM ufn_app_UserAccessibleLocationCategories(@userObjectId) alc
		INNER JOIN LocationCategory     lc ON lc.objectId = alc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
		INNER JOIN LocationCategoryType t  ON t.objectId  = lc.locationCategoryTypeObjectId AND t.snapshotFromLocationCategoryTypeObjectId IS NULL
		INNER JOIN Hierarchy            h  ON h.objectId  = t.hierarchyObjectId
		WHERE h.branded = 1

		UNION ALL

		SELECT objectId as brandObjectId
		FROM Brand b
		INNER JOIN BrandsWithDescendents parent
		ON b.parentObjectId = parent.brandObjectId
	)
	INSERT INTO @ReturnVal (brandObjectId)
	SELECT DISTINCT brandObjectId
	FROM BrandsWithDescendents OPTION (MAXRECURSION 50)
	
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
