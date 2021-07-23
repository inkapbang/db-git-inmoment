SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION GetSubscribedUsers(@locationsCrit VARCHAR(200), @locCatsCrit VARCHAR(200), @subscribedLocCatTypes VARCHAR(200), @includeLocations BIT)
RETURNS @results TABLE (objectId INT)
AS
BEGIN
	DECLARE @locCats TABLE (objectId INT)
	DECLARE @users TABLE (objectId INT)
	IF (@locationsCrit IS NOT NULL)
	BEGIN
		INSERT INTO @locCats (objectId)
			SELECT objectId FROM GetSubscribedLocCatsFromLocs(@locationsCrit, @subscribedLocCatTypes)
		IF @includeLocations = 1
			INSERT INTO @users
				SELECT userAccountObjectId FROM UserAccountLocation
				WHERE locationObjectId in (SELECT token FROM dbo.Split(@locationsCrit, ','))
	END

	IF @locCatsCrit IS NOT NULL
	BEGIN
		INSERT INTO @locCats (objectId)
			SELECT objectId FROM GetSubscribedLocCatsFromLocCats(@locCatsCrit, @subscribedLocCatTypes)
		IF @includeLocations = 1
			INSERT INTO @users
				SELECT userAccountObjectId FROM UserAccountLocation
				WHERE locationObjectId in (SELECT locationObjectId FROM dbo.GetCategoryLocations(@locCatsCrit))
	END

	INSERT INTO @users (objectId)
		SELECT DISTINCT UserAccountLocationCategory.userAccountObjectId FROM UserAccountLocationCategory
			INNER JOIN @locCats LC1 ON UserAccountLocationCategory.locationCategoryObjectId = LC1.objectId

/*	IF @includeLocations = 1
		INSERT INTO @users (objectId)
			SELECT DISTINCT UserAccountLocation.userAccountObjectId FROM UserAccountLocation
				INNER JOIN LocationCategoryLocation ON UserAccountLocation.locationObjectId = LocationCategoryLocation.locationObjectId
				INNER JOIN @locCats LC1 ON LocationCategoryLocation.locationCategoryObjectId = LC1.objectId*/
		
	INSERT INTO @results SELECT DISTINCT objectId FROM @users

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
