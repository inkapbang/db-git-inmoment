SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetLocationLineage] (@locationId INT)
RETURNS TABLE
AS RETURN
		WITH LC AS
			(
				SELECT
					c.objectId AS locationCategoryObjectId,
					c.[name] AS locationCategoryName,
					c.parentObjectId,
					c.locationCategoryTypeObjectId,
					p.depth-c.depth AS hierarchyLevel

				FROM LocationCategoryLocation lcl
				INNER JOIN LocationCategory lc ON lc.objectId = lcl.locationCategoryObjectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
					JOIN dbo.LocationCategory p
						ON lcl.locationCategoryObjectId = p.objectId AND p.snapshotFromLocationCategoryObjectId IS NULL
					JOIN [dbo].[LocationCategory] c
						ON p.[objectId] = lcl.locationCategoryObjectId
							AND c.leftExtent <= p.leftExtent
							AND c.rightExtent >= p.rightExtent
							AND c.rootObjectId = (SELECT rootObjectId
									 FROM dbo.LocationCategory
									 WHERE objectId = lcl.locationCategoryObjectId)
							AND c.snapshotFromLocationCategoryObjectId IS NULL
				WHERE lcl.locationObjectId = @locationId
			)
SELECT
	locationCategoryObjectId,
	locationCategoryName,
	parentObjectId,
	locationCategoryTypeObjectId,
  hierarchyLevel
FROM LC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
