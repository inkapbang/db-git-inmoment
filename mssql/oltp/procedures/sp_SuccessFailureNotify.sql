SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_SuccessFailureNotify
CREATE Procedure sp_SuccessFailureNotify

@deliveryEmail				varchar(100)	= NULL

, @SubjectLine				varchar(50)		= NULL
, @BodyTaskDescription		varchar(255)	= NULL
, @ExecutionResult			varchar(10)		= NULL
, @TextNumber				varchar(255)	= NULL
, @CCEmail					varchar(255)	= NULL						


AS




SET NOCOUNT ON

DECLARE @deliveryEmailCheck		int
SET		@deliveryEmailCheck		= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
										WHEN LEN(@deliveryEmail) = 0	THEN 0
										WHEN LEN(@deliveryEmail) > 0	THEN 1
									END

DECLARE @TextNumberCheck		int
SET		@TextNumberCheck		= CASE	WHEN @TextNumber IS NULL 	THEN 0
										WHEN LEN(@TextNumber) = 0	THEN 0
										WHEN LEN(@TextNumber) > 0	THEN 1
									END




DECLARE @ServerName		varchar(25)
SET		@ServerName		= @@ServerName

DECLARE	@Timestamp		varchar(30)
SET		@Timestamp		= CONVERT(varchar, GETDATE(), 109)								
									
									


DECLARE @EmailSubjectBuild		NVARCHAR(MAX)
SET		@EmailSubjectBuild		= @SubjectLine + ' ' + @ExecutionResult



DECLARE @BodyBuild		NVARCHAR(MAX)
SET		@BodyBuild		= 
@Timestamp + '

Task Results: ' + @ExecutionResult + '
Executed On: ' + @@ServerName + '
Task:  ' + @SubjectLine + '
 
Brief Description:
' + @BodyTaskDescription 
									


DECLARE @TextBodyBuild		NVARCHAR(MAX)
SET		@TextBodyBuild		= @SubjectLine + '  ' + @ExecutionResult
 




IF @deliveryEmailCheck > 0
BEGIN

EXEC msdb.dbo.sp_send_dbmail
@profile_name		= 'DB Maintenance & Jobs'
, @recipients		= @deliveryEmail
, @reply_to			= 'dba@mshare.net'
, @copy_recipients	= @CCEmail
, @from_address		= 'Status@mshare.net'
, @importance		= 'High'
, @subject			= @EmailSubjectBuild
, @body_format		= 'Text'
, @body				= @BodyBuild

END



IF @TextNumberCheck > 0
BEGIN

EXEC msdb.dbo.sp_send_dbmail
@profile_name		= 'DB Maintenance & Jobs'
, @from_address		= 'Status@mshare.net'
, @recipients		= @TextNumber
, @subject			= @TextBodyBuild


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
