SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetPeriodEnd] (@periodId int, @date datetime)
RETURNS datetime
AS
BEGIN
	DECLARE @periodTypeId int, @periodType int, @offset int, @count int, @orgId int
	SELECT @periodTypeId = pt.objectId,
		@periodType = pt.[type],
		@offset = p.offsetValue,
		@count = p.[count],
		@orgId = p.organizationObjectId
	FROM Period p
		INNER JOIN PeriodType pt
		on pt.objectId = p.periodTypeObjectId
	WHERE p.objectId = @periodId
	
	-- If the period is "to-date" (offset 0) then cut off at context date
	IF @offset = 0 RETURN @date	
	
	IF @count IS NULL OR @count < 1 SET @count = 1
	
	DECLARE @endDate DATETIME
	IF @periodType = 1 SET @endDate = dbo.Date_DayEnd(DATEADD(day, @offset, @date))
	ELSE IF @periodType = 2 SET @endDate = DATEADD(day, 6, dbo.GetWeekBeginDate(@orgId, DATEADD(week, @offset, @date)))
	ELSE IF @periodType = 3 SET @endDate = dbo.Date_MonthEnd(DATEADD(month, @offset, @date))
	ELSE IF @periodType = 4 SET @endDate = dbo.Date_QuarterEnd(DATEADD(quarter, @offset, @date))
	ELSE IF @periodType = 5 SET @endDate = dbo.Date_YearEnd(DATEADD(year, @offset, @date))
	ELSE IF @periodType = 6 
		BEGIN
			WITH NumberedRanges as (
				select
				ROW_NUMBER() OVER (order by beginDate) as rowNum,
				beginDate, endDate from periodrange where periodtypeobjectid = @periodTypeId
			)

			select @endDate = endDate from NumberedRanges
			where rowNum = (select top 1 rowNum from NumberedRanges
							where @date between beginDate and endDate) + @offset
		END
	ELSE SET @endDate = NULL

	RETURN @endDate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
