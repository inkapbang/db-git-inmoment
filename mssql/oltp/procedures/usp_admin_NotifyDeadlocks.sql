SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_NotifyDeadlocks]
AS
--exec [dbo].[usp_admin_NotifyDeadlocks]
BEGIN
	DECLARE @count int
    DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)

	select	@count = count(*) from master.dbo.sysprocesses where dbid !=9 and blocked>0 and waittime>10000
	select @count
	--select * from master.dbo.sysprocesses where dbid !=9 and blocked>0 and waittime>10000
	--select db_id('activemqdb')
	--select * from sys.databases
	if @count > 0
	begin
		SET @alertMessage =
		'There are blocked SQLServer processes!' + CHAR(13) +
        'Server: ' + @@SERVERNAME + CHAR(13) +
        'Count: ' + convert(varchar(100), @count) + CHAR(13) +
        'See status email for more info.'

		--EXEC msdb.dbo.sp_send_dbmail
		--@profile_name = 'Alert', 
		--@recipients = '8016786926@vtext.com',
		----@recipients = 'mshare@mailman.xmission.com;8016786926@vtext.com',
		--@subject = 'Blocked SQLServer Pocesses ',
		--@body = @alertMessage;		--@importance = 'High';
	
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
--		@recipients = 'alert@mshare.net;8016786926@vtext.com;bluther@mshare.net',
		@recipients = 'developers@mshare.net;8016786926@vtext.com;',--;Developers@mshare.net',--;bluther@mshare.net',
		@subject = 'Blocked SQLServer Processes Status',
		--@body = @alertMessage,
		@body = 'The attached file contains the results from usp_admin_CheckDeadlocks.',
		@query = 'exec usp_admin_CheckDeadlocks',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'blocks.csv',
		@importance = 'High'
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
