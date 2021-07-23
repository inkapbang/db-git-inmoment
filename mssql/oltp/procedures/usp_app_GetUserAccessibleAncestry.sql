SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Drake Bennion
-- Create date: 02/05/2018
-- Description:	Given an orgUnitId, a hierarchyId and a userId, this query returns all the locationCategories the user has access to
--				that are ancestors of the orgUnit in that hierarchy.
--				If the starting orgUnit is a locationCategory, it will be included in the resultSet.
-- =============================================
CREATE PROCEDURE [dbo].[usp_app_GetUserAccessibleAncestry]
	@hierarchyId VARCHAR(20),
	@userId VARCHAR(20),
	@startNodeId VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- this will be null if the start_id is a location category
	DECLARE @locationId VARCHAR(20);
	SET @locationId = (SELECT locationObjectId FROM OrganizationalUnit WHERE objectId = @startNodeId);

		-- this will be null if the start_id is a location
	DECLARE @locCatId VARCHAR(20);
	SET @locCatId = (SELECT locationCategoryObjectId FROM OrganizationalUnit WHERE objectId = @startNodeId);

		-- this will be empty if the start_id is a location category
	DECLARE @parentLocCats TABLE (locationCategoryObjectId VARCHAR(20));
	INSERT INTO @parentLocCats 
			SELECT locationCategoryObjectId
			FROM LocationCategoryLocation lcl
			JOIN LocationCategory locCat on lcl.locationCategoryObjectId = locCat.objectId
			JOIN LocationCategoryType locCatType ON locCatType.objectId = locCat.LocationCategoryTypeObjectId
			WHERE locationObjectId = @locationId and hierarchyObjectId = @hierarchyId;

	-- --

	-- ALL locationCategories the given user has access to
	WITH ualc AS (
		SELECT DISTINCT child.*
		FROM LocationCategory child
		JOIN LocationCategory parent
		ON child.leftExtent BETWEEN parent.leftExtent AND parent.rightExtent
		WHERE child.rootObjectId = parent.rootObjectId
		AND parent.objectId IN (SELECT locationCategoryObjectId FROM UserAccountLocationCategory WHERE userAccountObjectId = @userId)
	),
	-- ALL locationCategories in the ancestry of the starting point
	 ancestors AS (
		SELECT parent.* 
		FROM LocationCategory parent 
		JOIN LocationCategory child 
		ON child.leftExtent BETWEEN parent.leftExtent AND parent.rightExtent
		AND child.rootObjectId = parent.rootObjectId
		WHERE child.objectId = @locCatId OR child.objectId IN (SELECT locationCategoryObjectId FROM @parentLocCats)
	)

	SELECT ou.objectId, loc.name FROM OrganizationalUnit ou
	JOIN LocationCategory loc ON ou.locationCategoryObjectId = loc.objectId
	WHERE locationCategoryObjectId IN (
		SELECT DISTINCT ualc.objectId
		FROM ualc
		JOIN ancestors ON ualc.objectId = ancestors.objectId
	)
	ORDER BY loc.depth;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
