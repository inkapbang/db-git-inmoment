SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE PROCEDURE sp_cust_PandaExpress_DailySurveyVolumeAlert_vDoctor
CREATE PROCEDURE sp_cust_PandaExpress_DailySurveyVolumeAlert_vDoctor

AS

/******************************  Hourly Survey Check  ***************************

	Requested by Brad Clark
	
	History
		1.8.2014	Tad Peterson
			-- Created on Doctor
			-- Survey Ids 5352, 5353
		
		1.9.2014	Tad Peterson
			-- added distribution group
			-- removed exlusionReason
						

*********************************************************************************/

SET NOCOUNT ON

-- This creates a between for last hour, even when it crosses midnight.
DECLARE @UtcDateTime		dateTime
		, @StartUtcDateTime dateTime
		, @EndUtcDateTime	dateTime
		, @adjHour			int
		, @adjMinute		int
		, @adjSec			int
		, @adjMilsec		int



SET		@UtcDateTime		= ( SELECT GETUTCDATE() )
SET		@adjHour			= DATEPART( Hour		, @UtcDateTime )
SET		@adjMinute			= DATEPART( Minute		, @UtcDateTime )
SET		@adjSec				= DATEPART( Second		, @UtcDateTime )
SET		@adjMilsec			= DATEPART( Millisecond	, @UtcDateTime )


SET		@EndUtcDateTime		= DATEADD( Hour, -(@adjHour),   DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) ) )
SET		@StartUtcDateTime	= DATEADD( Day, -1, @EndUtcDateTime )


--SELECT @StartUtcDateTime, @EndUtcDateTime




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
		objectId IN ( 5352, 5353 )		
;

-- Testing
--SELECT *	FROM @dtt01



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
												complete = 1
								)




		SET @EmailSubject = @SurveyName + ' - Zero Volume Alert'

		SELECT @SurveyVolume
								
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

Time Frame: All Day 
Check Frequency: Daily
Execution Time:  Previous Day
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
