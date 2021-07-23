SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_LocationAncestorCategories_new] (@locationId INT, @categoryTypeId INT) RETURNS TABLE
/*
      Returns a result set of Location Categories that are related to a specified location.  The procedure
      traverses up the hierarchy tree starting at the Location, finding categories of a specific Location Category Type (by id).
*/
AS RETURN (
      WITH LC
      AS
      (
            SELECT
                  c.objectId AS locationCategoryObjectId,
                  c.[name] AS locationCategoryName,
                  c.parentObjectId,
                  c.locationCategoryTypeObjectId,
                  p.depth-c.depth AS hierarchyLevel
            FROM LocationCategoryLocation lcl with (nolock)
            INNER JOIN LocationCategory lc with (nolock)
				ON lc.objectId = lcl.locationCategoryObjectId
					JOIN dbo.LocationCategory p
						ON lcl.locationCategoryObjectId = p.objectId
					JOIN [dbo].[LocationCategory] c
						ON p.[objectId] = lcl.locationCategoryObjectId
							AND c.leftExtent <= p.leftExtent
							AND c.rightExtent >= p.rightExtent
							AND c.rootObjectId = (SELECT rootObjectId
									 FROM dbo.LocationCategory
									 WHERE objectId = lcl.locationCategoryObjectId)
			WHERE lcl.locationObjectId = @locationId
      )
      SELECT
            locationCategoryObjectId,
            locationCategoryName,
            parentObjectId,
            locationCategoryTypeObjectId,
            hierarchyLevel
      FROM
            LC
      WHERE
            locationCategoryTypeObjectId = @categoryTypeId
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
