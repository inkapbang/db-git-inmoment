SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Proc monitor.reportRunFailure_OpsView
AS

--Must Be Empty by 5:30 AM

DECLARE @dTT01 TABLE(contextDate dateTime)
  
DECLARE @startDT datetime,@endDT datetime, @count int
SET @endDT		=	substring(convert(varchar(50),getdate(),121),1,10)+' 04:15:000'
set @startDT	=	dateadd(hh,-23,@endDT)

INSERT INTO @dTT01
SELECT 
	contextDate 
FROM deliveryRunLogEntry
WHERE startTime BETWEEN @startDT AND @endDT
	AND endTime IS NULL

SET @count = (SELECT count(1) FROM @dTT01)

IF (@count = 0)
Select 'No Failed Reports |  ''Failed Report Count''=0' as output, 0 as stateValue
ELSE 
Select 'Failed Reports Count: '+ cast(@count as varchar)+' DeliveryRunLogEntry where endTime is null  |  ''Failed Report Count''='+ cast(@count as varchar) as output, 2 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
