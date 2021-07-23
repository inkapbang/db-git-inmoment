SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetAccessibleLocationsForHierarchy](@userObjectId INT, @hierarchyObjectId INT)
RETURNS TABLE
AS
RETURN
            WITH LineageCTE(locationCategoryObjectId) AS
            (
                        SELECT userLocCats.locationCategoryObjectId
                        FROM UserAccountLocationCategory userLocCats
                        INNER JOIN LocationCategory lc ON userLocCats.locationCategoryObjectId = lc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
                        INNER JOIN LocationCategoryType lct ON lc.LocationCategoryTypeObjectId = lct.objectId AND lct.snapshotFromLocationCategoryTypeObjectId IS NULL
                        WHERE userLocCats.userAccountObjectId = @userObjectId
                        AND lct.hierarchyObjectId = @hierarchyObjectId

                        UNION ALL

                        SELECT lc.objectId as locationCategoryObjectId
                        FROM LocationCategory lc
                        INNER JOIN LineageCTE lcte on lcte.locationCategoryObjectId = lc.parentObjectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
            )

            SELECT lac.locationObjectId as objectId FROM UserAccountLocation lac
            INNER JOIN Location l ON lac.locationObjectId = l.objectId
			INNER JOIN LocationCategoryLocation lcl ON l.objectId = lcl.locationObjectId
			INNER JOIN LocationCategory lc ON lcl.locationCategoryObjectId = lc.objectId
			INNER JOIN LocationCategoryType lct ON lct.objectId = lc.LocationCategoryTypeObjectId
            WHERE lac.userAccountObjectId = @userObjectId
            AND lct.hierarchyObjectId = @hierarchyObjectId

            UNION
 
            SELECT DISTINCT lcl.locationObjectId as objectId
            FROM LocationCategoryLocation lcl
            INNER JOIN LineageCTE on LineageCTE.locationCategoryObjectId = lcl.locationCategoryObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
