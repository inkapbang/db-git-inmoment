SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view [dbo].[OrganizationalUnitLocationCategoryLocationIView] with schemabinding as 
( 
	  select 
		l.[objectId] locationId,
		l.[name],
		l.[addressObjectId],
		l.[contactInfoObjectId],
		l.[organizationObjectId],
		l.[locationNumber],
		l.[hidden],
		l.[version],
		l.[enabled],
		l.[nameInSurvey],
		l.[vxml],
		l.[timeZone],
		lc.[objectId] locationCategoryId,
		lc.[name] locationCategoryName,
		lc.[organizationObjectId] locationCategoryOrgId,
		lc.[parentObjectId],
		lc.[depth],
		lc.[lineage],
		lc.[LocationCategoryTypeObjectId],
		lc.[version] locationCategoryVersion,
		lc.[externalId],
		ou.[objectId] orgUnitId,
		ou.[version] orgUnitVersion,
		ou.[locationObjectId],
		ou.[locationCategoryObjectId]
	  FROM 
		[dbo].[LocationCategory] lc
		JOIN [dbo].[OrganizationalUnit] ou
		ON lc.[objectId] = ou.[locationCategoryObjectId]
		JOIN [dbo].[Location] l
		ON l.[objectId] = ou.[locationObjectId]
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
