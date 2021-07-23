SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_UserAccessibleLocationCategories](@userObjectId INT)
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
           AND c.rootObjectId = p.rootObjectId
           AND c.snapshotFromLocationCategoryObjectId IS NULL
    WHERE userLocCats.userAccountObjectId = @userObjectId
)
SELECT DISTINCT (lc.[objectId])
FROM LC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
