SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view [dbo].[OrganizationalUnitLocationCategoryIView] with schemabinding as 
( 
	  select 
		lc.[objectId] locationCategoryId,
		lc.[name],
		lc.[organizationObjectId],
		lc.[parentObjectId],
		lc.[depth],
		lc.[lineage],
		lc.[LocationCategoryTypeObjectId],
		lc.[version],
		lc.[externalId],
		ou.[objectId] orgUnitId,
		ou.[version] orgUnitVersion,
		ou.[locationObjectId],
		ou.[locationCategoryObjectId]
	  FROM 
		[dbo].[LocationCategory] lc
		JOIN [dbo].[OrganizationalUnit] ou
		ON lc.[objectId] = ou.[locationCategoryObjectId]
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
