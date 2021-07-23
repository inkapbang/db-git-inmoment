SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* test radius search capability */
--EXEC [dbo].[RadiusSearch] '90210', 1000.123 /* 'PostalCode' (in single quotes), distance in miles (decimal) */

CREATE FUNCTION [dbo].[RadiusAssistantByDTMFCode](
	@dtmfCode char(10),
	@ISOCountryCode char(2),
	@Miles decimal(18, 9)
) RETURNS
	@MaxPoints TABLE (
		objectId int,
		Latitude decimal(10,8),
		Longitude decimal(11,8),
		MaxLat decimal(10,8),
		MinLat decimal(10,8),
		MaxLong decimal(11,8),
		MinLong decimal(11,8))
	AS
BEGIN
	DECLARE postalCodeCursor CURSOR LOCAL FOR
		SELECT	objectId, latitude, longitude
		FROM	PostalCode
		WHERE	dtmfCode = @dtmfCode
			AND isoCountryCode = @ISOCountryCode
			AND cityType = 'D' 
	DECLARE @id int,
		@Latitude decimal(10,8),
		@Longitude decimal(11,8)
	DECLARE @MilesPerDegree decimal(10,8)
	SET 	@MilesPerDegree = 69.172
	DECLARE
		@MaxLat decimal(10, 8),
		@MinLat decimal(10, 8),
		@MaxLong decimal(11, 8),
		@MinLong decimal(11, 8)


	OPEN postalCodeCursor
	FETCH NEXT From postalCodeCursor INTO @id, @Latitude, @Longitude
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @MaxLat = @Latitude + @Miles / @MilesPerDegree
		SET @MinLat = @Latitude - (@MaxLat - @Latitude)
		SET @MaxLong = @Longitude + @Miles / (Cos(@MinLat * PI() / 180) * @MilesPerDegree)
		SET @MinLong = @Longitude - (@MaxLong - @Longitude)
	
		INSERT @MaxPoints
			SELECT @id, @Latitude, @Longitude, @MaxLat, @MinLat, @MaxLong, @MinLong
		FETCH NEXT From postalCodeCursor INTO @id, @Latitude, @Longitude
	END
	CLOSE postalCodeCursor
	DEALLOCATE postalCodeCursor

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
