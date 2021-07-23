SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE PROCEDURE sp_cust_wsvWalgreensCallCenterGateway_vDoctor
CREATE PROCEDURE sp_cust_wsvWalgreensCallCenterGateway_vDoctor

AS

/******************************  Hourly Gateway Check  ***************************

	Requested by Will Frazier
	
	History
		2.8.2013	Tad Peterson
			-- Created and moved to Doctor
			
		8.28.2013	Tad Peterson
			-- Changed gateways from 3301 to 4018

*********************************************************************************/




-- This creates a between for last hour, even when it crosses midnight.
DECLARE @UtcDateTime		dateTime
		, @StartUtcDateTime dateTime
		, @EndUtcDateTime	dateTime
		--, @adjHour			int
		, @adjMinute		int
		, @adjSec			int
		, @adjMilsec		int



SET		@UtcDateTime		= ( SELECT GETUTCDATE() )
SET		@adjMinute			= DATEPART( Minute		, @UtcDateTime )
SET		@adjSec				= DATEPART( Second		, @UtcDateTime )
SET		@adjMilsec			= DATEPART( Millisecond	, @UtcDateTime )


SET		@EndUtcDateTime		= DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) )
SET		@StartUtcDateTime	= DATEADD( Hour, -1, @EndUtcDateTime )



DECLARE @SurveyVolume		int

SET		@SurveyVolume		= 
								(
									SELECT
											count(1)
																			
									FROM

											Mindshare.dbo.surveyResponse		t10					WITH (NOLOCK)
																			
									WHERE
											surveyGatewayObjectId = 4018		-- @sg
										AND 
											(
												t10.beginDateUTC	BETWEEN 
																			@StartUtcDateTime
																		AND 
																			@EndUtcDateTime
											)
										AND
											complete		= 1
										AND
											exclusionReason = 0
										AND
											modeType		= 1		-- Phone
								)

								
								
IF 	@SurveyVolume = 0
BEGIN


EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'AlertMonitor'
, @recipients					= 'WalgreensCallCenterAlerts@mshare.net'
, @copy_recipients 				= 'tpeterson@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @importance					= 'High'
, @subject						= 'wsv Walgreens Call Center Gateway - Zero Volume Alert'
, @body_format					= 'Text'
, @body							=
'
Zero Volume Alert

Gateway: wsv Walgreens Call Center Gateway
ObjectId: 4018
Mode: Phone
Time Frame: 8 AM - 7 PM 
Check Frequency: Hourly
Execution Time:  Previous Hour

'


								
								
								
END								
								
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
