SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_PeriodIntervalRanges](
/*
	Inline table-valued function that returns a parameterized view of the intervals within one or more periods.
	For a specified period, it returns a specified number of interval groups (ranges) before a specified context date.

	For example, if the period is "last 7 days" from 1/1/2010 and the period count is 1, the function returns 7 day intervals starting with 12/31/2009.
	If, however, the period count is 3 (return 2 period's worth of ranges), it returns 21 day-length intervals starting with 12/31/2009 and working backwards.

	The function takes advantage of the ROW_NUMBER window function and returns a row number for each interval, starting with 1 for the current
	interval (defined by the context date and the period's offset (-1 for "last" and 0 for "current or this").  It also returns an "intervalGroup"
	which allows the results from each subsequent period to be grouped together.
*/
	@periodId INT, -- The period to return intervals for
	@contextDate DATETIME, -- The starting date to work backwards from
	@periodCount INT,  -- The number of periods to go back
	@localeKey VARCHAR(25) = 'en_US' -- the locale for the interval name
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		intervalObjectId,
		intervalNameObjectId,
		intervalNum,
		(intervalNum - 1) / intervalCount AS intervalGroup,

		periodObjectId,
		periodNameObjectId,
		periodTypeObjectId,

		beginDate,
		endDate,
		intervalCount,
		intervalOffset
	FROM
	(
		SELECT
			r.objectId AS intervalObjectId,
			r.labelObjectId AS intervalNameObjectId,
			(SELECT TOP 1 CAST(VALUE AS NVARCHAR(3000)) FROM dbo.ufn_app_LocalizedStringTable(r.labelObjectId, @localeKey)) AS intervalName,
			(ROW_NUMBER() OVER (ORDER BY r.beginDate DESC)) + p.offsetValue AS intervalNum,
			r.periodTypeObjectId AS periodTypeObjectId,
			r.beginDate,
			r.endDate,

			p.objectId AS periodObjectId,
			p.nameObjectId AS periodNameObjectId,
			p.[count] AS intervalCount,
			p.offsetValue AS intervalOffset
		FROM
			Period p
			JOIN PeriodRange r
				  ON r.periodTypeObjectId = p.periodTypeObjectId
		WHERE
			p.objectId = @periodId
			AND r.beginDate <= @contextDate -- Only get ranges where beginDate is before @contextDate
	) [interval]
	WHERE
		intervalNum BETWEEN 1 AND intervalCount * @periodCount -- Only rows from current interval, going back a number of intervals specified by the period, then multiplied by the number of periods requested

);
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
