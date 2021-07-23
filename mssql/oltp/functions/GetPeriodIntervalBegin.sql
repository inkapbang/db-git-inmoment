SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetPeriodIntervalBegin](@periodTypeId int, @organizationObjectId int, @date DATETIME) 
returns DATETIME
as
begin
	declare @periodType int
	select @periodType = [type] from PeriodType where objectId = @periodTypeId
	return case @periodType
		when 1 then -- Day
			@date
		when 2 then -- Week
			(select dbo.Date_WeekBegin(@date, reportingWeekBeginsOnDay) from Organization where objectId = @organizationObjectId)
		when 3 then -- Month
			DATEADD(mm, DATEDIFF(mm, 0, @date),0)
		when 4 then -- Quarter
			DATEADD(qq, DATEDIFF(qq, 0, @date),0)
		when 5 then -- Year
			DATEADD(yy, DATEDIFF(yy, 0, @date), 0)
		when 6 then -- Custom
			(select top 1 beginDate from PeriodRange where periodTypeObjectId = @periodTypeId and @date between beginDate and endDate)
		end
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
