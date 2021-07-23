SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Proc [dbo].[usp_cust_ReportLinks3_master] as

declare @alertMessage VARCHAR(2000), @delim char(1)
	SET @delim = CHAR(9)
SET @alertMessage =
		'Mcdonalds Report Links'
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'bluther@mshare.net',
		@subject = 'McDonalds Report Links',
		@body = 'The attached file contains the Regis Report Links',
		@query = 'exec dbo.usp_cust_reportLinks3 569,''4/14/2010'',''4/15/2010''',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'RegisReportLinks.html',
		@importance = 'Normal'
   --select * from @results
--exec [dbo].[usp_cust_ReportLinks3_master]

--------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
