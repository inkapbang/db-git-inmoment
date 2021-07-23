SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   FUNCTION [dbo].[GetAccessibleLocationCategories_test](@userObjectId INT)
RETURNS TABLE
AS
RETURN	SELECT LocationCategory.objectId FROM LocationCategory
		INNER JOIN (SELECT locationCategoryObjectId FROM UserAccountLocationCategory
			 WHERE userAccountObjectId = @userObjectId) UserLocCats on (LocationCategory.objectId = UserLocCats.locationCategoryObjectId or (CHARINDEX('/' + CAST(UserLocCats.locationCategoryObjectId AS VARCHAR) + '/', LocationCategory.lineage) <> 0))
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
