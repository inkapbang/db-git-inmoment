SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_PeriodRangesByPeriodValues](
	@periodType INT, 
	@contextDate DATETIME, 
	@intervalCount INT, 
	@intervalOffset INT, 
	@periodCount INT = 1, 
	@locale varchar(5) = 'en_US')

RETURNS TABLE
AS
RETURN
(
	WITH [AllIntervals]([beginDate],[endDate],[intervalNum],[intervalName])
	AS(
		SELECT
			r.beginDate,
			r.endDate,
			(ROW_NUMBER() OVER (ORDER BY r.beginDate DESC)) + @intervalOffset AS intervalNum,
			(SELECT TOP 1 CAST(VALUE AS NVARCHAR(3000)) FROM dbo.ufn_app_LocalizedStringTable(r.labelObjectId, @locale)) AS intervalName
		FROM
			PeriodRange r  
		WHERE
			r.periodTypeObjectId = @periodType 
			AND r.beginDate <= @contextDate
	),
	[Intervals]([beginDate],[endDate],[intervalNum],[intervalName],[periodGroup])
	AS(
	SELECT
		beginDate,
		endDate,
		intervalNum,
		intervalName,
		(intervalNum - 1) / @intervalCount AS periodGroup
	FROM AllIntervals
	WHERE
			intervalNum BETWEEN 1  AND ((@intervalCount ) * @periodCount)
	)

	SELECT 
		MIN(i.beginDate) AS beginDate,
		MAX(i.endDate) AS endDate,
		(SELECT TOP 1 intervalName from Intervals where beginDate = (SELECT MIN(beginDate) FROM Intervals WHERE periodGroup = i.periodGroup) ) AS beginName,
		(SELECT TOP 1 intervalName from Intervals where endDate = (SELECT MAX(endDate) FROM Intervals WHERE periodGroup = i.periodGroup) ) AS endName,
		periodGroup
	FROM
		Intervals i
	GROUP BY i.periodGroup
);
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
