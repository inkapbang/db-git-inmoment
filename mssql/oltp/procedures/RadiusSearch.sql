SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--drop procedure [dbo].[RadiusSearch]
--GO

CREATE PROCEDURE [dbo].[RadiusSearch]
	@PostalCode char(10),
	@ISOCountryCode char(2),
	@Miles decimal(11, 6)
AS

SELECT	z.objectId,
	z.postalCode,
	--z.cityName,
	/* add any other fields here */
	/* Distance Assistant required */
	[dbo].[DistanceAssistant](z.latitude,z.longitude,r.latitude,r.longitude) As Distance
FROM	[dbo].[PostalCode] z,
	[dbo].[RadiusAssistant](@PostalCode, @ISOCountryCode, @Miles) r
	--, [dbo].[Address] address

WHERE	1=1
	AND z.latitude BETWEEN r.MinLat AND r.MaxLat
	AND z.longitude BETWEEN r.MinLong AND r.MaxLong
	AND z.cityType = 'D' /* only one result per postal code */
	AND (z.postalCodeType != 'M' OR z.postalCodeType is null)/* don't include "Military" postal codes which don't have a lat/long */
	/* SQL caches the result of this function - so performance is not impacted even though we run it twice */
	AND [dbo].[DistanceAssistant](z.latitude,z.longitude,r.latitude,r.longitude) <= @Miles
	--AND address.postalCode = z.postalCode
ORDER BY
	Distance,
	z.PostalCode
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
