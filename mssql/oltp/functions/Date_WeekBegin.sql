SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[Date_WeekBegin](@date DATETIME, @beginOnDay int = 1)  
RETURNS DATETIME AS  
BEGIN
	DECLARE @weekDay INT
	SET @weekDay = DATEPART(weekday, @date)

	DECLARE @offset INT
	IF (@weekDay >= @beginOnDay)
		SET @offset =  @beginOnDay - @weekDay
	ELSE
		SET @offset = @beginOnDay - @weekDay - 7

	RETURN CAST(CONVERT(varchar(15), DATEADD(DAY, @offset, @date), 101) AS DATETIME)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
