SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create FUNCTION [dbo].[ufn_app_PeriodRanges](
	/*
	Returns the period info and begin/end date ranges for a given period.
	For example, if the period is "Last 12 Months" and the contextDate is '5/19/2010' and the periodCount
	is 2, it will return two rows of data, one for 5/1/2009 through 4/30/2010 and one for 5/2/2008 through 4/30/2009.
	*/
	@periodId INT, -- The period to return ranges for
	@contextDate DATETIME, -- The starting date to work backwards from
	@periodCount INT, -- The number of period ranges to return
	@localeKey VARCHAR(25) = 'en_US' -- The locale to use when looking up the period name
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		periodObjectId,
		periodNameObjectId,
		(SELECT TOP 1 CAST(VALUE AS NVARCHAR(3000)) FROM dbo.ufn_app_LocalizedStringTable(periodNameObjectId, @localeKey)) AS periodName,
		intervalGroup,
		MAX(periodTypeObjectId) AS periodTypeObjectId,
		MIN(beginDate) AS beginDate,
		MAX(endDate) AS endDate,
		COUNT(intervalObjectId) AS intervalCount
	FROM
		[dbo].[ufn_app_PeriodIntervalRanges](@periodId, @contextDate, @periodCount, @localeKey) [intervals]
	GROUP BY
		periodObjectId,
		periodNameObjectId,
		intervalGroup
);
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
