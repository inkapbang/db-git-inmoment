SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--drop procedure [dbo].[DistanceSearch]
--GO

CREATE PROCEDURE [dbo].[DistanceSearch]
	@StartPostalCode char(10),
	@EndPostalCode char(10),
	@ISOCountryCode char(2),
	@Distance decimal(11, 6) OUTPUT
AS

SELECT	@Distance =
		[dbo].[DistanceAssistant](
			[first].Latitude,
			[first].Longitude,
			[second].Latitude,
			[second].Longitude)
FROM	[dbo].[PostalCode] [first],
	[dbo].[PostalCode] [second]
	/* perform a "cartesian join" */
WHERE	[first].postalCode = @StartPostalCode
	AND [second].postalCode = @EndPostalCode
	AND [first].isoCountryCode = @ISOCountryCode
	AND [second].isoCountryCode = @ISOCountryCode
	AND [first].cityType = 'D' /* only get the "default" record */
	AND [second].cityType = 'D'
	AND [first].postalCodeType != 'M' /* exclude military postal codes, they don't have lat/long */
	AND [second].postalCodeType != 'M'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
