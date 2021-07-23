SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_WalgreensHourlyRecommendAlert]
AS

/*********************************  Walgreens Hourly Recommend Alert *********************************

	Marc Morris / Lupita Kyle Request

	Runs on Server: Doctor
	Job Name:		WalgreensHourlyRecommendAlert
	
	History
		2.26.2013	Tad Peterson
			-- created
			
		9.10.2013	Tad Peterson
			-- removed Ipsos from the check
			
		6.10.2014	Tad Peterson
			-- causing PLE issues on OLTP; rewrote using temp tables

************************************************************************************************/

SET NOCOUNT ON


-- This creates a between for last hour, even when it crosses midnight.
DECLARE @UtcDateTime		dateTime
		, @StartUtcDateTime dateTime
		, @EndUtcDateTime	dateTime
		--, @adjHour			int
		, @adjMinute		int
		, @adjSec			int
		, @adjMilsec		int


		, @ResultsCount		int


SET		@UtcDateTime		= ( SELECT GETUTCDATE() )
SET		@adjMinute			= DATEPART( Minute		, @UtcDateTime )
SET		@adjSec				= DATEPART( Second		, @UtcDateTime )
SET		@adjMilsec			= DATEPART( Millisecond	, @UtcDateTime )


SET		@EndUtcDateTime		= DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) )
SET		@StartUtcDateTime	= DATEADD( Hour, -1, @EndUtcDateTime )



DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)

DECLARE @subjectName 	varchar(max)
DECLARE @deliveryEmail	varchar(max)
DECLARE @dbProfileName	varchar(max)

SET		@dbProfileName 	=	'alertMonitor'
SET		@deliveryEmail	=	'Walgreens.support@mshare.net'	--seperated by semi-colon
SET		@subjectName	=	'Walgreens Hourly Survey Recommend Question Alert'


-- SurveyRepsonse List
IF OBJECT_ID('tempdb..#SurveyResponse_List') IS NOT NULL			DROP TABLE #SurveyResponse_List		
SELECT

		t20.objectId		AS SurveyResponseObjectId
		, t20.ModeType		AS ModeType
		
INTO	#SurveyResponse_List

FROM
		
		Survey				t10
	JOIN
		SurveyResponse		t20
			ON 
				t10.objectId = t20.surveyObjectId 
			AND 
				t10.organizationObjectId = 1030 
			AND 
				t20.BeginDateUTC	
								BETWEEN
										@StartUtcDateTime
									AND
										@EndUtcDateTime
			
			AND
				t20.exclusionReason = 0
			AND
				t20.complete = 1
			AND
				t20.ModeType IN ( 1, 2 ) 	


-- Index the SurveyResponse_List Table
CREATE NONCLUSTERED INDEX IX_NC_SurveyResponse_List 
ON #SurveyResponse_List( SurveyResponseObjectId, ModeType )
WITH ( FILLFACTOR = 100 )


-- Gets DataFields based on ResponseIds
IF OBJECT_ID('tempdb..#SurveyResponseAnswer_List') IS NOT NULL			DROP TABLE #SurveyResponseAnswer_List		
SELECT
		SurveyResponseObjectId
		, DataFieldObjectId

INTO	#SurveyResponseAnswer_List

FROM
		SurveyResponseAnswer
				
WHERE
		SurveyResponseObjectId IN				
									(
										SELECT
												SurveyResponseObjectId
										FROM
												#SurveyResponse_List
									)			
												
	AND
		DataFieldObjectId IN ( 59104, 64432 )										
												
												
												
-- Index the SurveyResponse_List Table
CREATE NONCLUSTERED INDEX IX_NC_SurveyResponseAnswer_List 
ON #SurveyResponseAnswer_List( SurveyResponseObjectId, DataFieldObjectId )
WITH ( FILLFACTOR = 100 )

												
												
												
-- Final Query
IF OBJECT_ID('tempdb..#WalgreensHourlySurveyRecommendQntyCheck') IS NOT NULL			DROP TABLE #WalgreensHourlySurveyRecommendQntyCheck													
SELECT
		CASE	WHEN DataFieldObjectId = 59104 THEN 'Ipsos'
				WHEN DataFieldObjectId = 64432 THEN 'Mindshare'
			END														AS Survey
		, CASE	WHEN ModeType = 1	THEN 'Phone'
				WHEN ModeType = 2	THEN 'Web'
			END														AS ModeType
		, COUNT(1)				AS Qnty

INTO	#WalgreensHourlySurveyRecommendQntyCheck
												
FROM
		#SurveyResponse_List				t10
	JOIN
		#SurveyResponseAnswer_List			t20
			ON t10.SurveyResponseObjectId = t20.surveyResponseObjectId											


GROUP BY 
		DataFieldObjectId
		, ModeType



												




IF OBJECT_ID('tempdb..#WalgreensSurveyList') IS NOT NULL			DROP TABLE #WalgreensSurveyList	
CREATE TABLE #WalgreensSurveyList
	( 
		Survey		varchar(10)
		, ModeType	varchar(6)
	)

-- old version; when ipsos was part of check	
--INSERT INTO #WalgreensSurveyList
--VALUES ('Ipsos', 'Phone' )
--		, ('Ipsos', 'Web' )
--		, ('Mindshare', 'Phone' )
--		, ('Mindshare', 'Web' )


INSERT INTO #WalgreensSurveyList
VALUES ('Mindshare', 'Phone' )
		, ('Mindshare', 'Web' )



IF OBJECT_ID('tempdb..#WalgreensHourlySurveyRecommendQntyCheck_Results') IS NOT NULL			DROP TABLE #WalgreensHourlySurveyRecommendQntyCheck_Results	
SELECT
		t10.Survey
		, t10.ModeType
		, ISNULL( t20.Qnty, 0 )						AS Qnty

INTO #WalgreensHourlySurveyRecommendQntyCheck_Results

FROM
		#WalgreensSurveyList						AS t10
	LEFT JOIN
		#WalgreensHourlySurveyRecommendQntyCheck	AS t20
			ON t10.Survey = t20.Survey AND t10.ModeType = t20.ModeType
ORDER BY
		Qnty
		, Survey
		, ModeType
				


--For Testing Only
--UPDATE #WalgreensHourlySurveyRecommendQntyCheck_Results	SET Qnty = 0	WHERE Survey LIKE 'Mindshare' AND ModeType LIKE 'Phone'


--For Testing Only
--SET @ResultsCount = 1


SET @ResultsCount = ( SELECT COUNT(1)	FROM #WalgreensHourlySurveyRecommendQntyCheck_Results	WHERE Qnty = 0 )



IF @ResultsCount != 0
BEGIN

		PRINT 'Alert Issued'


		SET @xml = CAST(( 

		SELECT 	
				Survey																			
								AS 'td',''
				, ModeType																				
								AS 'td',''
				, Qnty																										
								AS 'td'
		FROM 
				#WalgreensHourlySurveyRecommendQntyCheck_Results
		ORDER BY
				Qnty
				, Survey
				, ModeType



		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))





		-----Header Naming and Column Naming below

		SET @body =											
															'<html><body><H1><font color="#4040C5">
		Greetings From Mindshare													
															</font></H1><br /><H4>
															
		Walgreens Hourly Survey Recommend Question Alert
			
															</H4><table border = 2><tr><th> 
		Survey							
															</th><th> 
		ModeType 							
															</th><th> 
		Qnty						
															</th></tr>'    

		 
		 
		 
		 
		SET @body = @body + @xml +'</table></body></html>'




		EXEC msdb.dbo.sp_send_dbmail
		@profile_name		= @dbProfileName
		, @recipients		= @deliveryEmail
		, @reply_to			= 'dba@mshare.net'
		, @copy_recipients	= 'bluther@mshare.net'
		--, @from_address		= 'Status@mshare.net'
		, @importance		= 'High'
		, @subject			= @subjectName
		, @body_format		= 'HTML'
		, @body				= @Body

		;

END




CLEANUP:
	IF OBJECT_ID('tempdb..#SurveyResponse_List') IS NOT NULL								DROP TABLE #SurveyResponse_List	
	IF OBJECT_ID('tempdb..#SurveyResponseAnswer_List') IS NOT NULL							DROP TABLE #SurveyResponseAnswer_List			
	IF OBJECT_ID('tempdb..#WalgreensHourlySurveyRecommendQntyCheck') IS NOT NULL			DROP TABLE #WalgreensHourlySurveyRecommendQntyCheck	
	IF OBJECT_ID('tempdb..#WalgreensSurveyList') IS NOT NULL								DROP TABLE #WalgreensSurveyList	
	IF OBJECT_ID('tempdb..#WalgreensHourlySurveyRecommendQntyCheck_Results') IS NOT NULL	DROP TABLE #WalgreensHourlySurveyRecommendQntyCheck_Results	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
