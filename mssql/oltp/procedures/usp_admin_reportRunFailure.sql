SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Stored Procedure

CREATE Proc [dbo].[usp_admin_reportRunFailure]
AS
--exec [dbo].[usp_admin_reportRunFailure]

IF Object_id(N'tempdb..#res3',N'U') IS NOT NULL
  DROP TABLE #res1;

create table #res1(contextdate datetime)

BEGIN
	DECLARE @count int
    DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
    Declare @startdt datetime,@enddt datetime,@contextdate datetime
--
set @enddt=substring(convert(varchar(50),getdate(),121),1,10)+' 04:15:000'
set @startdt=dateadd(hh,-23,@enddt)
--set @enddt='2010-01-17 04:15:00.000'
--set @startdt='2010-01-16 05:15:00.000'
--select @startdt,@enddt

insert into #res1
select contextdate 
from reportrunlogentry
where startTime between @startdt and @enddt
and endTime is null

	SET @delim = CHAR(9)

	select	@count =  COUNT(*) from #res1
--if @count=0 set @count=1

	if @count > 0
	begin
		SET @alertMessage =
		'Report Run Failure Last Night'

		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert',
		@recipients = 'alert@mshare.net', 
		--@recipients = 'mshare@mailman.xmission.com',
		@subject = 'Report Run failure last night check report run',
--		@subject = 'Report Run failure last night check report run',
		@body = @alertMessage,
		@importance = 'High'

	end
END

--exec [dbo].[usp_admin_reportRunFailure]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
