SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[OfferCodesByDTMFPostalCodeAndGateway]
	@dtmfCode char(10),
	@ISOCountryCode char(2),
	@Miles decimal(11, 6),
	@GatewayObjectId int
AS
	SELECT	distinct oc.objectId as offerCodeObjectId,
		z.objectId as postalCodeObjectId,
		z.postalCode as postalCode,	
		oc.offerCode as offerCode,
		/* Average is as good as anything else */
		avg(dbo.DistanceAssistant(z.latitude,z.longitude,r.latitude,r.longitude)) as distance
	FROM	PostalCode z
		inner join Address a on a.postalCode = z.postalCode
		inner join Location l on l.addressObjectId = a.objectId
		inner join OfferCode oc on oc.locationObjectId = l.objectId,
		RadiusAssistantByDTMFCode(@dtmfCode, @ISOCountryCode, @Miles) r
	WHERE 1=1 and
		z.latitude BETWEEN r.minLat AND r.maxLat
		AND z.longitude BETWEEN r.minLong AND r.maxLong
		AND l.enabled = 1
		AND oc.surveyGatewayObjectId = @GatewayObjectId
		AND z.cityType = 'D' /* only one result per postal code */
		AND (z.postalCodeType != 'M' OR z.postalCodeType is null)/* don't include "Military" postal codes which don't have a lat/long */
		AND dbo.DistanceAssistant(z.latitude,z.longitude,r.latitude,r.longitude) <= @Miles
		/* Group by to eliminate duplicate offer codes accessible from surrounding postal codes */
	GROUP BY
		oc.objectId, z.objectId, z.postalCode, oc.offerCode
	ORDER BY
		distance, postalCode
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
