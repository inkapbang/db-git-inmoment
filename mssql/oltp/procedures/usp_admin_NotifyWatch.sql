SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_NotifyWatch] (@date DATETIME)
AS
BEGIN
	DECLARE @weekBegin DATETIME, @primaryEmail VARCHAR(100), @secondaryEmail VARCHAR(100)
	SELECT TOP 1
		@weekBegin = watch.weekBegin,
		@primaryEmail = watch.primaryEmail,
		@secondaryEmail = watch.secondaryEmail
	FROM dbo.GetWatchSchedule(@date, @date) watch

	DECLARE @message VARCHAR(2000)
	SET @message =
		'Watch schedule for week beginning ' + convert(varchar(10), @weekBegin, 101) + CHAR(13) +
		'Primary: ' + @primaryEmail + CHAR(13) +
		'Secondary: ' + @secondaryEmail

	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = @primaryEmail,
		@subject = '[Watch] YOU ARE PRIMARY',
		@body = @message,
		@importance = 'High'

	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = @secondaryEMail,
		@subject = '[Watch] YOU ARE SECONDARY',
		@body = @message,
		@importance = 'High'

	DECLARE @subject VARCHAR(1000)
	SET @subject = '[Watch] Watch Schedule for ' + convert(varchar(10), @weekBegin, 101)
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'jsperry@mshare.net;kwilliams@mshare.net;dnewbold@mshare.net;bluther@mshare.net',
		@subject = @subject,
		@body = @message

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
