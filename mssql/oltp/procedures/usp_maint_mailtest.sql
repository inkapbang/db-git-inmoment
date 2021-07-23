SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure dbo.usp_maint_mailtest
as
--exec  dbo.usp_maint_mailtest
		--EXEC msdb.dbo.sp_send_dbmail
		--@profile_name = 'Alert', 
		----@recipients = 'mshare@mailman.xmission.com;8016786926@vtext.com',
		--@recipients = '8016786926@vtext.com;bluther@mshare.net',
		--@subject = 'Blocked SQLServer Pocesses',
		--@body = 'blah blah blah',
		--@importance = 'High'
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
--		@recipients = 'alert@mshare.net;8016786926@vtext.com;bluther@mshare.net',
		@recipients = 'developers@mshare.net',--;Developers@mshare.net',--;bluther@mshare.net',
		@subject = 'Blocked SQLServer Processes Status',
		----@body = @alertMessage,
		--@body = 'The attached file contains the results from usp_admin_CheckDeadlocks.',
		@query = 'exec dbo.usp_admin_CheckDeadlocks',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = ',',
		@query_attachment_filename = 'blocks.csv'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
