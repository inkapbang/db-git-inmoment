SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [Monitor].[AccessPolicyByOffer_OpsView]

as

declare @weekstart datetime
declare @weekend datetime
DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

DECLARE @dt DATE = '1905-01-01';
SELECT @weekstart = DATEADD(WEEK, DATEDIFF(WEEK, @dt, CURRENT_TIMESTAMP), @dt), 
@weekend = DATEADD(DAY, 6, DATEADD(WEEK, DATEDIFF(WEEK, @dt, CURRENT_TIMESTAMP), @dt));

SET @t1 = GETDATE();

DECLARE @count int
select 
	@count = count(*) 
from SurveyResponse sr with (nolock) 
where 
	sr.complete = 1 
	and sr.exclusionReason = 0 
	and sr.offerObjectId = 1007 
	and sr.ani = convert(varchar(255),'6787211666') 
	and sr.beginDate between @weekstart and @weekend 
	and sr.beginTime between '1900-01-01 00:00:00.0' and '1900-01-01 23:59:59.999'

SET @t2 = GETDATE();
DECLARE @elapsedMs int = DATEDIFF(millisecond,@t1,@t2);

if @elapsedMs < 1000

Select 'Query by offer took less than 1000 ms |  ''Access Policy by offer''='+CAST(@elapsedMs as varchar) as output, 0 as stateValue
ELSE
Select 'Query by offer took: '+ cast(@elapsedMs as varchar)+'ms |  ''Access Policy by offer''='+ cast(@elapsedMs as varchar) as output, 2 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
