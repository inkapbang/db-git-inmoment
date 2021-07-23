SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--drop function [dbo].[RadiusAssistant]
--GO

CREATE FUNCTION [dbo].[RadiusAssistant](
	@PostalCode char(10),
	@ISOCountryCode char(2),
	@Miles decimal(18, 9)
) RETURNS
	@MaxPoints TABLE (
		Latitude decimal(10,8),
		Longitude decimal(11,8),
		MaxLat decimal(10,8),
		MinLat decimal(10,8),
		MaxLong decimal(11,8),
		MinLong decimal(11,8))
	AS
BEGIN
	DECLARE
		@Latitude decimal(10,8),
		@Longitude decimal(11,8)

	SELECT	@Latitude = latitude,
			@Longitude = longitude
	FROM	[dbo].[PostalCode]
	WHERE	postalCode = @PostalCode
		AND isoCountryCode = @ISOCountryCode
		AND cityType = 'D'

	IF 0 = @@rowcount
		RETURN /* invalid postal code */

	DECLARE @MilesPerDegree decimal(10,8)
	SET @MilesPerDegree = 69.172

	DECLARE
		@MaxLat decimal(10, 8),
		@MinLat decimal(10, 8),
		@MaxLong decimal(11, 8),
		@MinLong decimal(11, 8)

	SET @MaxLat = @Latitude + @Miles / @MilesPerDegree
	SET @MinLat = @Latitude - (@MaxLat - @Latitude)
	SET @MaxLong = @Longitude + @Miles / (Cos(@MinLat * PI() / 180) * @MilesPerDegree)
	SET @MinLong = @Longitude - (@MaxLong - @Longitude)

	INSERT @MaxPoints
		SELECT @Latitude, @Longitude, @MaxLat, @MinLat, @MaxLong, @MinLong

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
