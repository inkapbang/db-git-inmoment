SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[OfferCodesByPostalCodeAndGateway]
	@PostalCode char(10),
	@ISOCountryCode char(2),
	@Miles decimal(11, 6),
	@GatewayObjectId int
AS
SELECT	oc.objectId as offerCodeObjectId,
	z.objectId as postalCodeObjectId,
	z.postalCode as postalCode,	
	oc.offerCode as offerCode,
	--z.cityName,
	/* add any other fields here */
	/* Distance Assistant required */
	[dbo].[DistanceAssistant](z.latitude,z.longitude,r.latitude,r.longitude) As distance
FROM	[dbo].[PostalCode] z,
	[dbo].[OfferCode] oc,
	[dbo].[Location] l,
	[dbo].[Address] a,
	[dbo].[RadiusAssistant](@PostalCode, @ISOCountryCode, @Miles) r
	--, [dbo].[Address] address
WHERE l.objectId = oc.locationObjectId
	AND l.enabled = 1
	AND a.objectId = l.addressObjectId
	AND oc.surveyGatewayObjectId = @GatewayObjectId
	AND a.postalCode = z.postalCode
	AND z.latitude BETWEEN r.MinLat AND r.MaxLat
	AND z.longitude BETWEEN r.MinLong AND r.MaxLong
	--AND z.isoCountryCode = @ISOCountryCode
	AND z.cityType = 'D' /* only one result per postal code */
	AND (z.postalCodeType != 'M' OR z.postalCodeType is null)/* don't include "Military" postal codes which don't have a lat/long */
	/* SQL caches the result of this function - so performance is not impacted even though we run it twice */
	AND [dbo].[DistanceAssistant](z.latitude,z.longitude,r.latitude,r.longitude) <= @Miles
	--AND address.postalCode = z.postalCode
ORDER BY
	Distance,
	z.PostalCode,
	l.name
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
