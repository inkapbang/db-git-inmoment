SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   FUNCTION dbo.GetAccessibleLocationCategories(@userObjectId INT)
RETURNS TABLE
AS
RETURN	SELECT objectId FROM LocationCategory, (SELECT locationCategoryObjectId FROM UserAccountLocationCategory
			 WHERE userAccountObjectId = @userObjectId) UserLocCats
		 WHERE LocationCategory.objectId = UserLocCats.locationCategoryObjectId OR
			(CHARINDEX('/' + CAST(UserLocCats.locationCategoryObjectId AS VARCHAR) + '/', LocationCategory.lineage) <> 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
