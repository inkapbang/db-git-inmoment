SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetPeriodIntervalLabel](@periodTypeId int, @date DATETIME) 
returns varchar(50)
as
begin
	declare @periodType int
	select @periodType = "type" from PeriodType where objectId = @periodTypeId
	return case @periodType
		when 1 then -- Day
			convert(varchar(10), @date, 101)
		when 2 then -- Week
			'Wk ' + dbo.PadLeft('0', 2, datepart(week, @date)) +
				--cast(datepart(week, @date) as char(2)) + 
				' ' + substring(cast(year(@date) as char(4)), 3, 2)
		when 3 then -- Month
			case datepart(month, @date)
				when 1 then 'Jan ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 2 then 'Feb ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 3 then 'Mar ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 4 then 'Apr ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 5 then 'May ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 6 then 'Jun ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 7 then 'Jul ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 8 then 'Aug ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 9 then 'Sep ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 10 then 'Oct ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 11 then 'Nov ' + substring(cast(year(@date) as char(4)), 3, 2)
				when 12 then 'Dec ' + substring(cast(year(@date) as char(4)), 3, 2)
			end
		when 4 then -- Quarter
			'Q' + cast(datepart(qq, @date) as char(1)) + ' ' + substring(cast(year(@date) as char(4)), 3, 2)
		when 5 then -- Year
			cast(year(@date) as char(4))
		when 6 then -- Custom
			--(select top 1 label from PeriodRange where periodTypeObjectId = @periodTypeId and @date between beginDate and endDate)
			(select top 1 lsv.value from PeriodRange p inner join LocalizedStringValue lsv on p.labelObjectId = lsv.localizedStringObjectId and lsv.localeKey = 'en_US'
			where p.periodTypeObjectId = @periodTypeId and @date between p.beginDate and p.endDate)
		end
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
