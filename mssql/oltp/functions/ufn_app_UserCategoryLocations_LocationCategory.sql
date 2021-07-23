SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_UserCategoryLocations_LocationCategory](@categoryIdList VARCHAR(max))
RETURNS TABLE
AS
RETURN
				WITH LC AS
				(
					SELECT DISTINCT
						c.objectId AS locationCategoryObjectId,
						c.parentObjectId
					FROM LocationCategory lc
					INNER JOIN Split(@categoryIdList, ',') ids ON lc.objectId = ids.token
						JOIN dbo.LocationCategory p
							ON lc.objectId = p.objectId
						JOIN [dbo].[LocationCategory] c
							ON p.[objectId] = lc.objectId
								AND c.leftExtent >= p.leftExtent
								AND c.rightExtent <= p.rightExtent
								AND c.rootObjectId = (SELECT rootObjectId
										 FROM LocationCategory
										 WHERE objectId = lc.objectId)
				)
SELECT DISTINCT
	LC.locationCategoryObjectId
FROM LC
INNER JOIN LocationCategoryLocation lcl on lcl.locationCategoryObjectId = LC.locationCategoryObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
