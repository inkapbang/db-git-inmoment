SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetAccessibleLocationsForOrg](@userObjectId INT, @orgObjectId INT)
RETURNS TABLE
AS
RETURN
            WITH LineageCTE(locationCategoryObjectId) AS
            (
                        SELECT userLocCats.locationCategoryObjectId
                        FROM UserAccountLocationCategory userLocCats
                        INNER JOIN LocationCategory lc ON userLocCats.locationCategoryObjectId = lc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
                        WHERE userLocCats.userAccountObjectId = @userObjectId
                        AND lc.organizationObjectId = @orgObjectId

                        UNION ALL

                        SELECT lc.objectId as locationCategoryObjectId
                        FROM LocationCategory lc
                        INNER JOIN LineageCTE lcte on lcte.locationCategoryObjectId = lc.parentObjectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
            )

            SELECT locationObjectId as objectId FROM UserAccountLocation lac
            INNER JOIN Location l ON lac.locationObjectId = l.objectId
            WHERE lac.userAccountObjectId = @userObjectId
            AND l.organizationObjectId = @orgObjectId

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
