SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[DistanceAssistant](
	@Lat1 decimal(11, 6),
	@Lon1 decimal(11, 6),
	@Lat2 decimal(11, 6),
	@Lon2 decimal(11, 6))
RETURNS
	decimal(11, 6) AS
BEGIN

	IF @Lat1 = @Lat2 AND @Lon1 = @Lon2
		RETURN 0 /* same lat/long points, 0 distance = */

	DECLARE @x decimal(18,13)
	SET @x = 0.0

	/* convert from degrees to radians */
	SET @Lat1 = @Lat1 * PI() / 180
	SET @Lon1 = @Lon1 * PI() / 180
	SET @Lat2 = @Lat2 * PI() / 180
	SET @Lon2 = @Lon2* PI() / 180

	/* distance formula - accurate to within 30 feet */
	SET @x = Sin(@Lat1) * Sin(@Lat2) + Cos(@Lat1) * Cos(@Lat2) * Cos(@Lon2 - @Lon1)
	IF 1 = @x
		RETURN 0 /* same lat/long points - not enough precision in SQL Server to detect earlier */

	DECLARE @EarthRadius decimal(5,1)
	SET @EarthRadius = 3963.1

	RETURN @EarthRadius * (-1 * Atan(@x / Sqrt(1 - @x * @x)) + PI() / 2)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
