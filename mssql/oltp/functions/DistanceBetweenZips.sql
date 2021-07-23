SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION DistanceBetweenZips (
	@StartZIP char(5),
	@EndZIP char(5))
RETURNS
	decimal(11, 6) AS
BEGIN
	DECLARE @Distance decimal(11, 6)

	SELECT	@Distance =
			[dbo].[DistanceAssistant](
			[first].latitude,
			[first].longitude,
			[second].latitude,
			[second].longitude)
	FROM	[dbo].[PostalCode] [first],
			[dbo].[PostalCode] [second]
		/* perform a "cartesian join" */
	WHERE	[first].postalCode = @StartZIP
		AND [second].postalCode = @EndZIP
		AND [first].cityType = 'D' /* only get the "default" record */
		AND [second].cityType = 'D'
		AND [first].postalCodeType != 'M' /* exclude military ZIPs, they don't have lat/long */
		AND [second].postalCodeType != 'M'

	return @Distance
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
