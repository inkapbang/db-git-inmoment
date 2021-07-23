SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_cust_DTEWebServiceOutboundEmailPhone_vDoctor]
AS

/******************************  Hourly Gateway Check  ***************************

	Requested by Will Frazier
	
	History
		Sep 20, 2016	Bailey Hu
			-- Hourly response volume check for a given gateway: 4426	DTE Web Service Outbound Email and Phone


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
											surveyGatewayObjectId = 4426		-- @sg
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
								)

select 	@SurveyVolume, @StartUtcDateTime, @EndUtcDateTime							
								
IF 	@SurveyVolume = 0
BEGIN


EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'AlertMonitor'
, @recipients					= 'wfrazier@inmoment.com;mstringham@inmoment.com;yvonne.tillman@dteenergy.com'
, @copy_recipients 				= 'dba@inmoment.com'
, @reply_to						= 'dba@inmoment.com'
, @importance					= 'High'
, @subject						= 'Gateway - Zero Volume Alert'
, @body_format					= 'Text'
, @body							=
'
Zero Volume Alert

Gateway: DTE Web Service Outbound Email and Phone
ObjectId: 4426
Mode: Phone
Time Frame: 9 AM - 5 PM 
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
