SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view [dbo].[OrganizationalUnitLocationIView] with schemabinding as 
( 
	  select 
		l.[objectId] locationId,
		l.[name],
		l.[addressObjectId],
		l.[contactInfoObjectId],
		l.[organizationObjectId],
		l.[locationNumber],
		l.[hidden],
		l.[version] locationVersion,
		l.[enabled],
		l.[nameInSurvey],
		l.[vxml],
		l.[timeZone],
		ou.[objectId] orgUnitId,
		ou.[version] orgUnitVersion,
		ou.[locationObjectId],
		ou.[locationCategoryObjectId]
	  FROM 
		[dbo].[Location] l
		JOIN [dbo].[OrganizationalUnit] ou
		ON l.[objectId] = ou.[locationObjectId]
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
