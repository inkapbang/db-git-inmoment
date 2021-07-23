SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.sp_cust_PandaExpress_HourlySurveyVolumeAlert_vDoctor
AS

/******************************  Hourly Survey Check  ***************************

	Requested by Brad Clark
	
	History
		1.8.2014	Tad Peterson
			-- Created on Doctor
			-- Survey Ids 5339, 7076
		
		1.9.2014	Tad Peterson
			-- added distribution group
			-- removed exlusionReason
			
		9.15.2014	Tad Peterson
			-- changed the surveys being monitored, requested by Maria Caliendo
			-- removed 5339, 7076
			-- added 9215, 9185

						

*********************************************************************************/


SET NOCOUNT ON

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




-- Table Variable to hold Surveys to check
DECLARE @dtt01 TABLE
	(
		RowId				int Identity
		, SurveyObjectId	int
		, SurveyName		varchar(50)
	)

	
INSERT INTO @dtt01 ( SurveyObjectId, SurveyName )
SELECT
		objectId 
		, name
FROM
		.dbo.Survey
WHERE
		-- List of SurveyId to Check
		objectId IN ( 9215, 9185 )		
;


DECLARE @RowId				int
DECLARE @MinRow				int
DECLARE @MaxRow				int

DECLARE @SurveyObjectId		int
DECLARE @SurveyName			varchar(50)
DECLARE @SurveyVolume		int
DECLARE	@EmailSubject		nvarchar(75)


SET 	@MinRow	= ( SELECT MIN(rowId)	FROM @dtt01 )
SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM @dtt01 )
SET		@RowId	= @MinRow



WHILE 	@RowId 	<= 	@MaxRow
BEGIN

		SET @SurveyObjectId = ( SELECT SurveyObjectId	FROM @dtt01		WHERE RowId = @RowId )
		SET @SurveyName		= ( SELECT SurveyName		FROM @dtt01		WHERE RowId = @RowId )


		SET @SurveyVolume	= 
								( 

										SELECT
												COUNT(1)
										FROM
												Mindshare.dbo.surveyResponse		t10	WITH (NOLOCK)
										WHERE
												SurveyObjectId = @SurveyObjectId
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




		SET @EmailSubject = @SurveyName + ' - Zero Volume Alert'

								
		IF 	@SurveyVolume = 0
		BEGIN
		
			EXEC msdb.dbo.sp_send_dbmail
			@profile_name					= 'AlertMonitor'
			, @recipients					= 'Panda.Support@mshare.net'
			, @copy_recipients 				= 'tpeterson@mshare.net'
			, @reply_to						= 'dba@mshare.net'
			, @importance					= 'High'
			, @subject						= @EmailSubject
			, @body_format					= 'Text'
			, @body							=
'
Zero Volume Alert

Time Frame: 5 AM - 8 PM 
Check Frequency: Hourly
Execution Time:  Previous Hour
'
										
		END								


		SET @RowId = @RowId + 1
		

END








							
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
