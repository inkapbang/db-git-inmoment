SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_CategoryUnits](@locationCategoryId int)
RETURNS TABLE
AS
RETURN
	WITH LC AS (
		SELECT 
			c.objectId,
			@locationCategoryId categoryId
		FROM 
			LocationCategory p
			JOIN [dbo].[LocationCategory] c
				ON p.[objectId] = @locationCategoryId
				AND c.leftExtent >= p.leftExtent
				AND c.rightExtent <= P.rightExtent
				AND c.rootObjectId = (SELECT rootObjectId FROM LocationCategory WHERE objectId = @locationCategoryId)
	)
	SELECT 
		DISTINCT(ou.[objectId]) unitObjectId,
		ou.[locationObjectId],
		ou2.[objectId] categoryUnitObjectId,
		@locationCategoryId categoryObjectId
	FROM
		[dbo].[OrganizationalUnit] ou
		JOIN [dbo].[LocationCategoryLocation] lcl
			ON lcl.[locationObjectId] = ou.[locationObjectId]
		JOIN LC
			ON lcl.[locationCategoryObjectId] = LC.[objectId]
		JOIN [dbo].[OrganizationalUnit] ou2
			ON ou2.[locationCategoryObjectId] = @locationCategoryId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
