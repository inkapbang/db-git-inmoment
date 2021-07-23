SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Proc [dbo].[usp_admin_user_audit_master] as

declare @alertMessage VARCHAR(2000), @delim char(1)
	SET @delim = CHAR(9)
SET @alertMessage =
		'User Role Audit'
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'alert', 
		@recipients = 'bluther@mshare.net;jcrofts@mshare.net;jsperry@mshare.net;bclark@mshare.net',
		@subject = 'User Role Audit',
		@body = 'The attached file contains reults for User Role Audit for today',
--		@query = 'select top 5 * from survey',
		@query = 'exec dbo.usp_admin_user_audit1',
		@query_result_width = 512,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'UserRoleAudit.csv',
		@importance = 'Normal'
--exec dbo.usp_admin_user_audit_master

--------sp_who2
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
