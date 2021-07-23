SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION dbo.ufn_app_UserAccessiblePages
(	
	@userId INT, @orgId INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT DISTINCT p.objectId AS [id], p.pageType AS [pageDiscriminator], p.folderObjectId AS [folderId], p.hidden AS [hidden]
	FROM Page p
	JOIN PageWebAccess pwe ON pwe.pageObjectId = p.objectId
	JOIN LocationCategoryType lct ON lct.objectId = pwe.locationCategoryTypeObjectId
	JOIN LocationCategory lc ON lc.LocationCategoryTypeObjectId = lct.objectId
	JOIN UserAccountLocationCategory ualc ON ualc.locationCategoryObjectId = lc.objectId AND ualc.userAccountObjectId = @UserId
	WHERE p.publicWebAccess = 0 AND p.organizationObjectId = @orgId
		AND (p.brandObjectId IS NULL OR p.brandObjectId IN (SELECT brandObjectId FROM ufn_app_GetAccessibleBrands2(@UserId)))
		AND p.hidden = 0
	UNION
	SELECT DISTINCT p.objectId AS [id], p.pageType AS [pageDiscriminator], p.folderObjectId AS [folderId], p.hidden AS [hidden]
	FROM Page p
	WHERE p.organizationObjectId = @orgId
		AND (p.brandObjectId IS NULL OR p.brandObjectId IN (SELECT brandObjectId FROM ufn_app_GetAccessibleBrands2(@UserId)))
		AND p.publicWebAccess = 1
		AND p.hidden = 0
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
