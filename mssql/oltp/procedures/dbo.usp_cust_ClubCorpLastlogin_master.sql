SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create Proc [dbo].[dbo.usp_cust_ClubCorpLastlogin_master] as

declare @alertMessage VARCHAR(2000), @delim char(1)
	SET @delim = CHAR(9)
SET @alertMessage =
		'Clubcorp Last Login'
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'bluther@mshare.net,treese@mshare.net',
		@subject = 'Clubcorp Last Login',
		@body = 'The attached file contains the activity for Clubcorp Last Login f',
		@query = 'exec dbo.usp_cust_ClubCorpLastlogin',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'ClubCorpLastLogin.csv',
		@importance = 'Normal'
   --select * from @results
--exec [dbo].[dbo.usp_cust_ClubCorpLastlogin_master]
--------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
