SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   FUNCTION [dbo].[GetAccessibleLocations3](@userObjectId INT)
RETURNS TABLE
AS
RETURN
	WITH LineageCTE(locationCategoryObjectId) AS
	(
		SELECT userLocCats.locationCategoryObjectId
		FROM UserAccountLocationCategory userLocCats
		WHERE userLocCats.userAccountObjectId = @userObjectId

		UNION ALL

		SELECT lc.objectId as locationCategoryObjectId
		FROM LocationCategory lc
		INNER JOIN LineageCTE lcte on lcte.locationCategoryObjectId = lc.parentObjectId
	)

	SELECT locationObjectId as objectId FROM UserAccountLocation
	WHERE UserAccountLocation.userAccountObjectId = @userObjectId

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
