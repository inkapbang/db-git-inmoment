SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[CallVolumeByHour](@begin DATETIME, @end DATETIME) AS
SELECT     beginDate, SUM(CASE DatePart(hour, beginTime) WHEN 0 THEN 1 ELSE 0 END) AS _12_00_AM, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 1 THEN 1 ELSE 0 END) AS _1_00, SUM(CASE DatePart(hour, beginTime) WHEN 2 THEN 1 ELSE 0 END) AS _2_00, SUM(CASE DatePart(hour,
                       beginTime) WHEN 3 THEN 1 ELSE 0 END) AS _3_00, SUM(CASE DatePart(hour, beginTime) WHEN 4 THEN 1 ELSE 0 END) AS _4_00, 
                      SUM(CASE DatePart(hour, beginTime) WHEN 5 THEN 1 ELSE 0 END) AS _5_00, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 6 THEN 1 ELSE 0 END) AS _6_00, SUM(CASE DatePart(hour, beginTime) WHEN 7 THEN 1 ELSE 0 END) AS _7_00, SUM(CASE DatePart(hour,
                       beginTime) WHEN 8 THEN 1 ELSE 0 END) AS _8_00, SUM(CASE DatePart(hour, beginTime) WHEN 9 THEN 1 ELSE 0 END) AS _9_00, 
                      SUM(CASE DatePart(hour, beginTime) WHEN 10 THEN 1 ELSE 0 END) AS _10_00, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 11 THEN 1 ELSE 0 END) AS _11_00, SUM(CASE DatePart(hour, beginTime) WHEN 12 THEN 1 ELSE 0 END) AS _12_00_PM, 
                      SUM(CASE DatePart(hour, beginTime) WHEN 13 THEN 1 ELSE 0 END) AS _1_00, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 14 THEN 1 ELSE 0 END) AS _2_00, SUM(CASE DatePart(hour, beginTime) WHEN 15 THEN 1 ELSE 0 END) AS _3_00, 
                      SUM(CASE DatePart(hour, beginTime) WHEN 16 THEN 1 ELSE 0 END) AS _4_00, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 17 THEN 1 ELSE 0 END) AS _5_00, SUM(CASE DatePart(hour, beginTime) WHEN 18 THEN 1 ELSE 0 END) AS _6_00, 
                      SUM(CASE DatePart(hour, beginTime) WHEN 19 THEN 1 ELSE 0 END) AS _7_00, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 20 THEN 1 ELSE 0 END) AS _8_00, SUM(CASE DatePart(hour, beginTime) WHEN 21 THEN 1 ELSE 0 END) AS _9_00, 
                      SUM(CASE DatePart(hour, beginTime) WHEN 22 THEN 1 ELSE 0 END) AS _10_00, SUM(CASE DatePart(hour, beginTime) 
                      WHEN 23 THEN 1 ELSE 0 END) AS _11_00_PM, count(*) as Total
FROM         (SELECT     convert(varchar(10), beginDate, 101) + ' (' + datename(weekday, beginDate) + ')' AS beginDate, beginTime
                       FROM          SurveyResponse
                       WHERE      (beginDate BETWEEN @begin AND @end) and SurveyResponse.modeType = 1) innerTable
GROUP BY beginDate
ORDER BY beginDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
