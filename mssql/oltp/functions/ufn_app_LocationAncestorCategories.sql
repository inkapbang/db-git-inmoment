SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_LocationAncestorCategories] (@locationId INT, @categoryTypeId INT) RETURNS TABLE
/*
      Returns a result set of Location Categories that are related to a specified location.  The procedure
      traverses up the hierarchy tree starting at the Location, finding categories of a specific Location Category Type (by id).
*/
AS RETURN (
      WITH LineageCTE(locationCategoryObjectId, locationCategoryName, parentObjectId, locationCategoryTypeObjectId, hierarchyLevel)
      AS
      (
            SELECT
                  lc.objectId AS locationCategoryObjectId,
                  lc.[name] AS locationCategoryName,
                  lc.parentObjectId,
                  lc.locationCategoryTypeObjectId,
                  0 AS hierarchyLevel
            FROM LocationCategoryLocation lcl with (nolock)
                  INNER JOIN LocationCategory lc with (nolock) 
			ON lc.objectId = lcl.locationCategoryObjectId
            WHERE lcl.locationObjectId = @locationId
            
            UNION ALL
            
            SELECT
                  lc.objectId AS locationCategoryObjectId,
                  lc.[name] AS locationCategoryName,
                  lc.parentObjectId,
                  lc.LocationCategoryTypeObjectId,
                  lcte.hierarchyLevel + 1 AS hierarchyLevel
            FROM dbo.LocationCategory AS lc with (nolock)
                  INNER JOIN LineageCTE AS lcte ON lcte.parentObjectId = lc.objectId
      )
      SELECT
            locationCategoryObjectId,
            locationCategoryName,
            parentObjectId,
            locationCategoryTypeObjectId,
            hierarchyLevel
      FROM
            LineageCTE
      WHERE
            locationCategoryTypeObjectId = @categoryTypeId
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
