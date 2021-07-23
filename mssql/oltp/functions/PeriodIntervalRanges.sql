SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[PeriodIntervalRanges](@periodId INT, @contextDate DATETIME, @localeKey NVARCHAR(20) = 'en_US')
RETURNS TABLE
AS RETURN
SELECT
      [range].distance,
      [range].rangeObjectId,
      [range].rangeLabel,
      [range].periodTypeObjectId,
      [range].beginDate,
      [range].endDate,
      [range].periodObjectId,
      (SELECT TOP 1 CAST(VALUE AS NVARCHAR(3000)) FROM dbo.ufn_app_LocalizedStringTable(periodNameObjectId, @localeKey)) [periodName]
FROM (
      SELECT
            ROW_NUMBER() OVER (ORDER BY r.beginDate DESC) distance,
            r.objectId rangeObjectId,
            (SELECT TOP 1 CAST(VALUE AS NVARCHAR(3000)) FROM dbo.ufn_app_LocalizedStringTable(r.labelObjectId, @localeKey)) [rangeLabel],
            r.periodTypeObjectId periodTypeObjectId,
            r.beginDate,
            r.endDate,
            --(case when '2/16/2010' between r.beginDate and r.endDate then 1 else 0 end) isCurrentRange,
            p.objectId periodObjectId,
            p.[count] periodCount,
            ABS(p.offsetValue) periodOffset,
            p.nameObjectId periodNameObjectId
      FROM
            Period p
            JOIN PeriodRange r
                  ON r.periodTypeObjectId = p.periodTypeObjectId
      WHERE
            p.objectId = @periodId
            AND r.beginDate <= @contextDate -- Only get ranges where begin date is before context date
) [range]
WHERE
      [range].distance between [range].periodOffset + [range].periodOffset and [range].periodCount + [range].periodOffset
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
