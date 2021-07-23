SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetPeriodBegin] (@periodId int, @date datetime)
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
	
	IF @count IS NULL OR @count < 1 SET @count = 1
	
	DECLARE @beginDate DATETIME
	IF @periodType = 1 SET @beginDate = dbo.Date_DayBegin(DATEADD(day, @offset - @count + 1, @date))
	ELSE IF @periodType = 2 SET @beginDate = dbo.GetWeekBeginDate(@orgId, DATEADD(week, @offset - @count + 1, @date))
	ELSE IF @periodType = 3 SET @beginDate = dbo.Date_MonthBegin(DATEADD(month, @offset - @count + 1, @date))
	ELSE IF @periodType = 4 SET @beginDate = dbo.Date_QuarterBegin(DATEADD(quarter, @offset - @count + 1, @date))
	ELSE IF @periodType = 5 SET @beginDate = dbo.Date_YearBegin(DATEADD(year, @offset - @count + 1, @date))
	ELSE IF @periodType = 6 
		BEGIN
			WITH NumberedRanges as (
				select
				ROW_NUMBER() OVER (order by beginDate) as rowNum,
				beginDate, endDate from periodrange where periodtypeobjectid = @periodTypeId
			)

			select @beginDate = beginDate from NumberedRanges
			where rowNum = (select top 1 rowNum from NumberedRanges
							where @date between beginDate and endDate) + @offset - @count + 1
		END
	ELSE SET @beginDate = NULL

	RETURN @beginDate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
