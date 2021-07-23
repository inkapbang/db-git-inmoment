SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.CampaignUnsubscribe_Automated
	@DisplayInfo		int = 1
	, @ShowChecks		int = 0
	, @DaysAgo			int = 0
	, @ShowResults      int = 1
	, @Process			int = 0



AS
/********************************** CampaignUnsubscribe_Automated  **********************************

	Comments
		Will Frazier request originally for AAA.
		
		AAA uses ani ( caller id system filed ) as the contactInfo


	History
		02.12.2015	Tad Peterson
			-- talked with Will go specs


******************************************************************************************************/
SET NOCOUNT ON


-- Processing Checks
DECLARE @DisplayInfoCheck		int
DECLARE @ShowChecksCheck		int
DECLARE @DaysAgoCheck			int
DECLARE @ShowResultsCheck		int
DECLARE @ProcessCheck			int



SET @DisplayInfoCheck			= CASE 	WHEN @DisplayInfo	= 1			THEN 1							ELSE 0		END
SET @ShowChecksCheck			= CASE 	WHEN @ShowChecks	= 1			THEN 1							ELSE 0		END
SET @ShowResultsCheck			= CASE 	WHEN @ShowResults 	= 1			THEN 1							ELSE 0		END
SET @ProcessCheck			    = CASE 	WHEN @Process 		= 1			THEN 1							ELSE 0		END


SET @DaysAgoCheck				= CASE 	WHEN @DaysAgo 					IS NULL 	THEN 0
										WHEN @DaysAgo					= 0			THEN 0
										WHEN @DaysAgo					>= 1		THEN 1
									END


									
									

-- This creates a between for last hour, even when it crosses midnight.
DECLARE @UtcDateTime		dateTime
		, @StartUtcDateTime dateTime
		, @EndUtcDateTime	dateTime
		, @adjMonth			int
		, @adjDay			int
		, @adjHour			int
		, @adjMinute		int
		, @adjSec			int
		, @adjMilsec		int



SET		@UtcDateTime		= ( SELECT GETUTCDATE() )
SET		@adjMonth			= DATEPART( Month		, @UtcDateTime )
SET		@adjDay				= DATEPART( Day			, @UtcDateTime )
SET		@adjHour			= DATEPART( Hour		, @UtcDateTime )
SET		@adjMinute			= DATEPART( Minute		, @UtcDateTime )
SET		@adjSec				= DATEPART( Second		, @UtcDateTime )
SET		@adjMilsec			= DATEPART( Millisecond	, @UtcDateTime )



---- This version does previous full month
--SET		@EndUtcDateTime		= DATEADD( Day, -(@adjDay - 1), DATEADD( Hour, -(@adjHour), DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) ) ) )
--SET		@StartUtcDateTime	= DATEADD( Month, -1, @EndUtcDateTime )

---- This version does previous 3 days
SET		@EndUtcDateTime		= DATEADD( Hour, -(@adjHour), DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) ) )
SET		@StartUtcDateTime	= DATEADD( Day, - @DaysAgo, @EndUtcDateTime )

---- This version does previous hour
--SET		@EndUtcDateTime		= DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) )
--SET		@StartUtcDateTime	= DATEADD( Hour, -1, @EndUtcDateTime )



-- Adjusts for using BeginDate
--SET		@EndUtcDateTime		= DATEADD( DAY, -1, @EndUtcDateTime )



-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXECUTE dbo.CampaignUnsubscribe_Automated'
	PRINT N'	@DisplayInfo        = 0'
	PRINT N'	, @ShowChecks       = 0'	
	PRINT N'	, @DaysAgo			= 3'
	PRINT N'	, @ShowResults      = 1'
	PRINT N'    , @Process			= 0'	
	PRINT N' '
	PRINT N' '
	PRINT N' '


	RETURN

	
END





IF @ShowChecksCheck = 1
BEGIN

	SELECT
			@DisplayInfoCheck		AS DisplayInfoCheck
			, @DisplayInfo			AS DisplayInfo
				
			, @ShowChecksCheck		AS ShowChecksCheck
			, @ShowChecks			AS ShowChecks
				
			, @DaysAgoCheck			AS DaysAgoCheck
			, @DaysAgo				AS DaysAgo
					
			, @ShowResultsCheck		AS ShowResultsCheck
			, @ShowResults			AS ShowResults
				
			, @ProcessCheck			AS ProcessCheck
			, @Process				AS Process
	
			, @StartUtcDateTime		AS StartUTCDateTime
			, @EndUtcDateTime		AS EndUTCDateTime

END



--  Creates Temporary Table
IF OBJECT_ID('tempdb..#CampaignUnsubscribe_Prep01') IS NOT NULL			DROP TABLE #CampaignUnsubscribe_Prep01
CREATE TABLE #CampaignUnsubscribe_Prep01
	(
		CampaignObjectId		int
		, [version]				int
		, ContactInfo			varchar(100)
		, unsubscribeType		int
		, dateAdded				dateTime
	)
	

		
		
-- Specific to AAA	
INSERT INTO #CampaignUnsubscribe_Prep01 ( CampaignObjectId, [Version], ContactInfo, UnsubscribeType, DateAdded )
SELECT
		DISTINCT
		'772'						AS CampaignObjectId
		, '0'						AS [Version]
		, t10.Ani					AS ContactInfo
		, '2'						AS UnsubscribeType
		, GETDATE()					AS DateAdded
		
FROM
		SurveyResponse				t10
	JOIN
		SurveyResponseAnswer		t20
			ON 
					t10.objectId = t20.SurveyResponseObjectId 
				AND 
					t20.dataFieldObjectId = 152139
				AND
					t10.beginDate > @StartUtcDateTime
					
	
	


-- Future Queries







IF @ShowResultsCheck = 1
BEGIN
	-- show results 
	SELECT
			t10.CampaignObjectId
			, t10.[Version]
			, t10.ContactInfo
			, t10.UnsubscribeType
			, t10.DateAdded

	FROM
			#CampaignUnsubscribe_Prep01			t10
		LEFT JOIN
			CampaignUnsubscribe					t20
				ON t10.ContactInfo = t20.ContactInfo
				
	WHERE
			t20.contactInfo IS NULL
END






IF @ProcessCheck = 1
BEGIN
	-- Inserts non-duplicated items
	INSERT INTO CampaignUnsubscribe ( CampaignObjectId, [Version], ContactInfo, UnsubscribeType, DateAdded )
	SELECT
			t10.CampaignObjectId
			, t10.[Version]
			, t10.ContactInfo
			, t10.UnsubscribeType
			, t10.DateAdded

	FROM
			#CampaignUnsubscribe_Prep01			t10
		LEFT JOIN
			CampaignUnsubscribe					t20
				ON t10.ContactInfo = t20.ContactInfo
				
	WHERE
			t20.contactInfo IS NULL

END





-- Clean up
IF OBJECT_ID('tempdb..#CampaignUnsubscribe_Prep01') IS NOT NULL			DROP TABLE #CampaignUnsubscribe_Prep01


			
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
