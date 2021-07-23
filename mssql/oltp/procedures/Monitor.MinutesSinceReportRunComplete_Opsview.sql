SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [Monitor].[MinutesSinceReportRunComplete_Opsview]
(@warning int, @critical int)
AS
--warning and critical are the number of minutes SQL can be behind before we are alerted
DECLARE @diff int, @stateValue int

select top 1 @diff = datediff(minute,endTime,getdate())
from dbo.DeliveryRunLogEntry
where enqueued = 1
        and endTime is not null
order by objectid desc

IF (@diff > @warning)
select @stateValue = 1

IF (@diff > @critical)
Select @stateValue = 2 

IF (@diff < @warning)
Select @stateValue = 0 

Select 'Minutes since report run complete: '+ cast(@diff as varchar)+' |  ''report run gap''='+ cast(@diff as varchar) as output, @stateValue as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
