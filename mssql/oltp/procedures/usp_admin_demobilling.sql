SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_demobilling] 
as
/* This procedure calculates the demo billing for the previous month

Bob Luther 11/14/2007

*/
    DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)
	declare @date datetime
	declare @firstdate datetime

select @date= DATEADD(mm, DATEDIFF(mm,0,getdate()), 0)
--select @date
select @firstdate = dateadd(mm, -3,@date)
--select @firstdate
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'mthomas@mshare.net;bluther@mshare.net',
		@subject = 'DemoBilling',
		@body = 'The attached file contains the results from usp_billingreport',
		@query = 'exec usp_admin_billingreportauto',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindsharei',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'billing.csv',
		@importance = 'Normal'
	

--dbo.usp_admin_demobilling
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
