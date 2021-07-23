SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MaxLinesInUseByHour] 
	-- Add the parameters for the stored procedure here
	@beginDate DATETIME, 
	@endDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		sampleDate, dayOfWeek,
		sum(H0) H0, 
		sum(H1) H0, 
		sum(H2) H0, 
		sum(H3) H0, 
		sum(H4) H0, 
		sum(H5) H0, 
		sum(H6) H0, 
		sum(H7) H0, 
		sum(H8) H0, 
		sum(H9) H0, 
		sum(H10) H0, 
		sum(H11) H0, 
		sum(H12) H0, 
		sum(H13) H0, 
		sum(H14) H0, 
		sum(H15) H0, 
		sum(H16) H0, 
		sum(H17) H0, 
		sum(H18) H0, 
		sum(H19) H0, 
		sum(H20) H0, 
		sum(H21) H0, 
		sum(H22) H0, 
		sum(H23) H0,
		sum(channelsAvailable) channelsAvailable
	FROM 
		(SELECT 
				host,
				convert(varchar(10), creationDateTime, 101) as sampleDate,
				datename(weekday, creationDateTime) as dayOfWeek,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 0 THEN channelsInUse ELSE NULL END) AS H0,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 1 THEN channelsInUse ELSE NULL END) AS H1,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 2 THEN channelsInUse ELSE NULL END) AS H2,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 3 THEN channelsInUse ELSE NULL END) AS H3,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 4 THEN channelsInUse ELSE NULL END) AS H4, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 5 THEN channelsInUse ELSE NULL END) AS H5,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 6 THEN channelsInUse ELSE NULL END) AS H6,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 7 THEN channelsInUse ELSE NULL END) AS H7,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 8 THEN channelsInUse ELSE NULL END) AS H8,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 9 THEN channelsInUse ELSE NULL END) AS H9, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 10 THEN channelsInUse ELSE NULL END) AS H10,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 11 THEN channelsInUse ELSE NULL END) AS H11,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 12 THEN channelsInUse ELSE NULL END) AS H12, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 13 THEN channelsInUse ELSE NULL END) AS H13,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 14 THEN channelsInUse ELSE NULL END) AS H14,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 15 THEN channelsInUse ELSE NULL END) AS H15, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 16 THEN channelsInUse ELSE NULL END) AS H16, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 17 THEN channelsInUse ELSE NULL END) AS H17,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 18 THEN channelsInUse ELSE NULL END) AS H18, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 19 THEN channelsInUse ELSE NULL END) AS H19,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 20 THEN channelsInUse ELSE NULL END) AS H20,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 21 THEN channelsInUse ELSE NULL END) AS H21, 
				MAX(CASE DatePart(hour, creationDateTime) WHEN 22 THEN channelsInUse ELSE NULL END) AS H22,
				MAX(CASE DatePart(hour, creationDateTime) WHEN 23 THEN channelsInUse ELSE NULL END) AS H23,
				MAX(channelsAvailable) channelsAvailable
			FROM PlumStatus
			WHERE
				creationDateTime BETWEEN @beginDate AND @endDate
			GROUP BY host, convert(varchar(10), creationDateTime, 101), datename(weekday, creationDateTime)
	) as HostPivot
	GROUP BY sampleDate, dayOfWeek
	ORDER BY sampleDate	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
