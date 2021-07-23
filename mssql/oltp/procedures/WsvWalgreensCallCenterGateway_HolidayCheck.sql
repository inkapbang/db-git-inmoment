SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--ALTER PROCEDURE [dbo].[WsvWalgreensCallCenterGateway_HolidayCheck]
CREATE PROCEDURE [dbo].[WsvWalgreensCallCenterGateway_HolidayCheck]


AS
/*********************************************  Job Disabling on Holidays  *********************************************

	Will Frazier request to disable some jobs during holidays.

	Uses a table named Holidays to check a list to enabled/disable job WsvWalgreensCallCenterGateway.
	This table must be manually updated every year.  You can either insert more or truncate, 
	then insert a fresh set of values.
	This also has a built-in reminder that will be sent on 12/07/xxxx.
	
	History
		7.23.2013	Tad Peterson
			created, tested, and scheduled job
			
		9.3.2013	Tad Peterson
			added the sp_update_job to flush the cache to allow new settings to be loaded.
	
	

***********************************************************************************************************************/
SET NOCOUNT ON

-- Creates initial holiday table
/*
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Holidays') AND type = (N'U'))    DROP TABLE Holidays
CREATE TABLE Holidays
(
	objectId		int Identity (1,1)
	, beginDate		dateTime
	, name			varchar(150)
)

		PRINT 'Create table is enabled'
--*/ 	PRINT 'Create table is disabled'




-- Truncate Table for reuse or new dates & names
/*
TRUNCATE TABLE Holidays

		PRINT 'Truncate table is enabled'
--*/ 	PRINT 'Truncate table is disabled'



-- Initial & new holidays 
/*
INSERT INTO Holidays ( beginDate, name )
VALUES	( '01/01/1900', 'This table is used for Turning On & Off WsvWalgreensCallCenterGateway Job; this table is not part of Apps code base.' )
		, ( '12/31/2012', 'New Years Eve' )
		, ( '1/1/2013', 'New Years'		)
		, ( '5/27/2013', 'Memorial Day'	)
		, ( '7/4/2013', '4th of July'	)
		, ( '9/2/2013', 'Labor Day'		)
		, ( '11/28/2013', 'Thanksgiving'	)
		, ( '12/24/2013', 'Christmas Eve' )
		, ( '12/25/2013', 'Christmas'		)

		PRINT 'Holidays table load is enabled'
--*/ 	PRINT 'Holidays table load is disabled'




-- Testing
--SELECT *	FROM Holidays




-- Manual Validation.  Schedule job to run Daily 00:05:00
/* 
SELECT
		*
FROM
		Holidays
WHERE
		beginDate BETWEEN 
							DATEADD( Minute, -15,'2013-09-01 23:50:03.000')
						AND	
							DATEADD( Minute, 15, '2013-09-02 0:20:03.000' )

		PRINT 'Manual validation is enabled'
--*/ 	PRINT 'Manual validation is disabled'






-- Declare processing variables
DECLARE @TurnJob_Off		int
DECLARE @TurnJob_On			int
DECLARE @NewDatesValue		varchar(10)
DECLARE @NewDatesReminder	int


-- Manual test version; both
--SET	@TurnJob_Off		= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Minute, -15, '2013-09-01 23:50:03.000')	AND DATEADD( Minute, 15, '2013-09-02 0:20:03.000' )		)
--SET	@TurnJob_On			= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Day, -1, DATEADD( Minute, -15, '2013-09-03 00:00:05.000') ) 	AND		DATEADD( Day, -1, DATEADD( Minute, 15, '2013-09-03 00:00:05.000' ) )		)


-- Manual test version; off
--SET	@TurnJob_Off		= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Minute, -15, '2013-09-01 23:50:03.000')	AND DATEADD( Minute, 15, '2013-09-02 0:20:03.000' )		)
--SET	@TurnJob_On			= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Day, -1, DATEADD( Minute, -15, '2013-09-01 23:50:03.000') ) 	AND		DATEADD( Day, -1, DATEADD( Minute, 15, '2013-09-02 0:20:03.000' ) )		)


-- Manual test version; on
--SET	@TurnJob_Off		= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Minute, -15, '2013-09-03 00:00:05.000')	AND DATEADD( Minute, 15, '2013-09-03 00:00:05.000' )		)
--SET	@TurnJob_On			= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Day, -1, DATEADD( Minute, -15, '2013-09-03 00:00:05.000') ) 	AND		DATEADD( Day, -1, DATEADD( Minute, 15, '2013-09-03 00:00:05.000' ) )		)
		

-- Variable version & Nothing will happen testing
SET	@TurnJob_Off		= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Minute, -15, GETDATE() )	AND		DATEADD( Minute, 15, GETDATE() )		)
SET	@TurnJob_On			= ( SELECT COUNT(1)	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Day, -1, DATEADD( Minute, -15, GETDATE()) ) 	AND		DATEADD( Day, -1, DATEADD( Minute, 15, GETDATE() ) )		)



-- Testing Checks for NewDatesReminder
--SET 	@NewDatesValue		= ( SELECT '12/07/' + CAST( DATEPART(Year, GETDATE()) as varchar ) 	)
--SET		@NewDatesReminder	= ( CASE WHEN '12/7/2013 00:05:00' BETWEEN DATEADD( Minute, -15,CAST(@NewDatesValue as DATETIME) )	AND		DATEADD( Minute, 15, CAST(@NewDatesValue as DATETIME) ) THEN 1 ELSE 0 END	)


-- Live Check for NewDatesReminder
SET 	@NewDatesValue		= ( SELECT '12/07/' + CAST( DATEPART(Year, GETDATE()) as varchar ) 	)
SET		@NewDatesReminder	= ( CASE WHEN GETDATE() BETWEEN DATEADD( Minute, -15, CAST(@NewDatesValue as DATETIME) )	AND		DATEADD( Minute, 15, CAST(@NewDatesValue as DATETIME) ) THEN 1 ELSE 0 END	)




-- New Date Reminder Testing
--SELECT @NewDatesValue, @NewDatesReminder



IF @NewDatesReminder = 1
BEGIN
	GOTO New_Dates_Reminder
END


-- Testing
--SELECT @TurnJob_Off  AS JobOff, @TurnJob_On  AS JobOn


-- Email variables
DECLARE @HolidayName			varchar(25)
DECLARE	@TextSubject			varchar(255)
DECLARE @TextBody				varchar(75)
DECLARE @TextBodyAndValue		varchar(75)
DECLARE @EmailSubject			varchar(255)
DECLARE	@EmailBody				varchar(255)
DECLARE @TextJobName			varchar(255)
DECLARE @EmailJobName			varchar(255)
DECLARE @EnabledValue			tinyInt


-- Live version
SET		@HolidayName			= ( SELECT name	FROM Holidays	WHERE beginDate	BETWEEN DATEADD( Day, -1, DATEADD( Minute, -15, GETDATE()) ) 	AND		DATEADD( Day, -1, DATEADD( Minute, 15, GETDATE() ) )		)

-- Testing version
--SET		@HolidayName			= ( SELECT name	FROM Holidays	WHERE beginDate BETWEEN DATEADD( Minute, -15,'2013-09-01 23:50:03.000') AND	DATEADD( Minute, 15, '2013-09-02 0:20:03.000' )		)





-- Email prep
SET		@TextJobName			= 'Walgrn CCG 0VolAlert'
SET		@EmailJobName			= 'wsv Walgreens Call Center Gateway - Zero Volume Alert'



-- Processing Logic
-- Both are on
IF @TurnJob_Off = 1 AND @TurnJob_On = 1
BEGIN
	PRINT 'Both = 1'



	SET @TextSubject	= @TextJobName + ' now ON now OFF'
	SET @TextBody		= @HolidayName + ' caused '	+ @TextJobName	+ ' to be adjusted.' 

	SET @EmailSubject	= @EmailJobName + ' now ON now OFF'
	SET @EmailBody		= @HolidayName + ' holiday has caused ' + @EmailJobName + ' to be turned ON and then turned back OFF.  This double switch occurs when there is an eve holiday followed by the actual holiday.'


	
	-- DANGER!!!  Net process turns job on and then back off
	BEGIN
		EXECUTE	msdb.dbo.sp_update_job @job_name	= 'WsvWalgreensCallCenterGateway', @enabled	= 0; 
	END
	



	-- Validates the enabled value
	SET @EnabledValue		= ( SELECT [enabled]	FROM MSDB.DBO.SYSJOBS WHERE name LIKE 'WsvWalgreensCallCenterGateway' )
	SET @TextBodyAndValue	= @TextBody	+ 'Enabled = ' + CAST( @EnabledValue as varchar(1) ) + '.'
	SET @EmailBody			= @EmailBody + ' Current Enabled Value = ' + CAST( @EnabledValue as varchar(1) )




	GOTO Email_Processing

END


-- Turns Job OFF
IF @TurnJob_Off = 1 AND @TurnJob_On != 1
BEGIN
	PRINT 'Job_off = 1'



	SET @TextSubject	= @TextJobName + ' now OFF'
	SET @TextBody		= @HolidayName + ' caused '	+ @TextJobName	+ ' to be turned OFF.' 

	SET @EmailSubject	= @EmailJobName + ' now OFF'
	SET @EmailBody		= @HolidayName + ' holiday has caused ' + @EmailJobName + ' to be turned OFF.'



	-- DANGER!!!  Turns job off
	BEGIN
		EXECUTE	msdb.dbo.sp_update_job @job_name	= 'WsvWalgreensCallCenterGateway', @enabled	= 0; 
	END
	

	-- Validates the enabled value
	SET @EnabledValue		= ( SELECT [enabled]	FROM MSDB.DBO.SYSJOBS WHERE name LIKE 'WsvWalgreensCallCenterGateway' )
	SET @TextBodyAndValue	= @TextBody	+ 'Enabled = ' + CAST( @EnabledValue as varchar(1) ) + '.'
	SET @EmailBody			= @EmailBody + ' Current Enabled Value = ' + CAST( @EnabledValue as varchar(1) )




	GOTO Email_Processing

END


-- Turns Job ON
IF @TurnJob_Off != 1 AND @TurnJob_On = 1
BEGIN
	PRINT 'Job_on = 1'



	SET @TextSubject	= @TextJobName + ' now ON'
	SET @TextBody		= @HolidayName + ' caused '	+ @TextJobName	+ ' to be turned ON.' 

	SET @EmailSubject	= @EmailJobName + ' now ON'
	SET @EmailBody		= @HolidayName + ' holiday has caused ' + @EmailJobName + ' to be turned ON.'



	-- DANGER!!!  Turns job on
	BEGIN
		EXECUTE	msdb.dbo.sp_update_job @job_name	= 'WsvWalgreensCallCenterGateway', @enabled	= 1; 
	END




	-- Validates the enabled value
	SET @EnabledValue		= ( SELECT [enabled]	FROM MSDB.DBO.SYSJOBS WHERE name LIKE 'WsvWalgreensCallCenterGateway' )
	SET @TextBodyAndValue	= @TextBody	+ 'Enabled = ' + CAST( @EnabledValue as varchar(1) ) + '.'
	SET @EmailBody			= @EmailBody + ' Current Enabled Value = ' + CAST( @EnabledValue as varchar(1) )



	GOTO Email_Processing

END 


-- Nothing to process
IF @TurnJob_Off != 1 AND @TurnJob_On != 1
BEGIN
	PRINT 'Nothing proccessed on this pass'



	SET @EmailSubject	= @EmailJobName + ' holiday check, nothing happened.'
	SET @EmailBody		= 'No holiday has caused this job to be adjusted.'



	-- Validates the value
	SET @EnabledValue	= ( SELECT enabled FROM MSDB.DBO.SYSJOBS WHERE name LIKE 'WsvWalgreensCallCenterGateway' )
	SET @EmailBody		= @EmailBody + ' Current Enabled Value = ' + CAST( @EnabledValue as varchar(1) )


	GOTO Email_Only

END









Email_Processing:
BEGIN
	PRINT 'Text portion executed'

	-- Text
	EXEC msdb.dbo.sp_send_dbmail
	@profile_name	= 'Notification'
	, @from_address	= 'Status@mshare.net'
	--, @reply_to		= 'dba@mshare.net'	
	, @recipients	= '' --; 8016786926@vtext.com; ' 	-- Tad; Bob; Keith
	--, @recipients = '; 8016786926@vtext.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8012581964@txt.att.net; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com'	--Tad, Bob, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J 
	, @subject		= @TextSubject 
	, @body_format	= 'text'
	, @body			= @TextBodyAndValue
	;
	
	GOTO Email_Only
END


Email_Only:
BEGIN
	PRINT 'Email portion executed'

	-- Email
	EXEC msdb.dbo.sp_send_dbmail
	@profile_name	= 'Notification'
	, @from_address	= 'Status@mshare.net'
	, @reply_to		= 'dba@mshare.net'	
	, @recipients	= 'tpeterson@mshare.net; '-- bluther@mshare.net; kmciff@mshare.net' -- Tad; Bob; Keith
	--, @recipients = '; 8016786926@vtext.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8012581964@txt.att.net; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com'	--Tad, Bob, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J 
	, @subject		= @EmailSubject 
	, @body_format	= 'text'
	, @body			= @EmailBody
	;

	GOTO Cleanup
END


New_Dates_Reminder:
IF @NewDatesReminder = 1
BEGIN
PRINT 'Reminder portion executed'

---- Text Version
EXEC msdb.dbo.sp_send_dbmail
@profile_name	= 'Notification'
, @from_address	= 'Status@mshare.net'
--, @reply_to		= 'dba@mshare.net'	
, @recipients	= '' --; 8016786926@vtext.com; ' 	-- Tad; Bob; Keith
--, @recipients = '; 8016786926@vtext.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8012581964@txt.att.net; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com'	--Tad, Bob, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J 
, @subject		= 'New Holiday Dates Reminder'
, @body_format	= 'text'
, @body			= 'Please add next years holidays to the holiday table on Doctor. See email for code to execute'
;



EXEC msdb.dbo.sp_send_dbmail
@profile_name	= 'Notification'
, @from_address	= 'Status@mshare.net'
--, @reply_to		= 'dba@mshare.net'	
, @recipients	= 'tpeterson@mshare.net; '-- bluther@mshare.net; kmciff@mshare.net' -- Tad; Bob; Keith
, @subject		= 'New Holiday Dates Reminder'
, @body_format	= 'text'
, @body			= '
Please add next years holidays to the holiday table on Doctor.
The biggest concern is for the up-and-coming New Years Holiday 
to be present so the job will properly be re-enabled.
In the past, Will Frazier has been the one who has decided which dates are necessary.

Run the following SQL Code to see current values and table structure.


SELECT *	FROM Doctor.Mindshare.dbo.Holidays

--Tad Peterson
'

;


GOTO Cleanup

END


Cleanup:
	PRINT 'Cleanup portion executed'
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
