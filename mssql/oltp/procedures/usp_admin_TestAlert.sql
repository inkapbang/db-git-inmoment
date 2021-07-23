SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_TestAlert]
AS
BEGIN
    DECLARE @alertMessage VARCHAR(2000)

	SET @alertMessage =
	'This is a test of database email sending from the alert profile'

	EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'Alert', 
	@recipients = 'mshare@mailman.xmission.com',
	@subject = 'Test of database alert profile',
	@body = @alertMessage,
	@importance = 'High'
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
