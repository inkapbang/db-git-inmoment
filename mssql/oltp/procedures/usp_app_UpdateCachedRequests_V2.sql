SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_UpdateCachedRequests_V2]
AS

/**************************************  usp_app_UpdateCachedRequests  **************************************

	Comments
	Original version was causing deadlocks on OLTP with a SurveyRequest Insert statement.
	
	Action purpose:
		Move Update join on these highly active tables to a SELECT join,
		then do a quick update via ids from a tmp table.
		
		Original version written by 	BJ Tenny
		Version 2 written by 			Tad Peterson
		Tmp Table version				Tad Peterson

	History
		00.00.0000	Tad Peterson
			-- n/a
		
		01.08.2014	Tad Peterson
			-- propose adding date limit, adjust indexes to use beginDate include UUID
				current estimated and actual rows are HUGE; i.e. traverse entire "table"
	
		02.02.2014	Tad Peterson
			-- Query taking 2:30 min to execute
				broke query into three seperate tmp tables
				to reduce data set size on surveyResponse table scan.
				suggest to add a filtered index on surveyRequest table
				Query execution time now subsecond
				
		05.30.2014	Tad Peterson
			-- placed it in Production

************************************************************************************************************/

/*

-- Create Filtered Index on SurveyRequest; suggest but not neccessary
CREATE INDEX IX_SurveyRequest_Filtered_SurveyResponseUuid_SurveyResponseObjectId
ON SurveyRequest ( SurveyResponseUuid, SurveyResponseObjectId )
WHERE SurveyResponseObjectId IS NULL AND SurveyResponseUuid IS NOT NULL


*/


-- This portion now subsecond
IF OBJECT_ID('tempdb..#SurveyRequestUuid') IS NOT NULL			DROP TABLE #SurveyRequestUuid		
CREATE TABLE #SurveyRequestUuid
(
	RowId						int Identity
	, SurveyRequestObjectId		int
	, SurveyResponseUuid		varchar(100)
)

CREATE INDEX IX_T_SurveyRequestUUID_UUID ON #SurveyRequestUuid(SurveyResponseUuid)


-- Scanning way too many records
IF OBJECT_ID('tempdb..#SurveyResponseUuid') IS NOT NULL			DROP TABLE #SurveyResponseUuid		
CREATE TABLE #SurveyResponseUuid
(
	RowId						int Identity
	, SurveyResponseObjectId	int
	, SurveyResponseUuid		varchar(100)
)



-- Combined Table used for updateing SurveyRequest
IF OBJECT_ID('tempdb..#UpdateCachedRequests_Prep') IS NOT NULL			DROP TABLE #UpdateCachedRequests_Prep	
CREATE TABLE #UpdateCachedRequests_Prep
(
	RowId						int Identity
	, SurveyRequestObjectId		int
	, SurveyResponseObjectId	int
	, SurveyResponseUuid		varchar(100)
)


-- Gets intial list 
INSERT INTO #SurveyRequestUuid ( SurveyRequestObjectId, SurveyResponseUuid )
SELECT
		--*
		t10.objectId
		, t10.SurveyResponseUuid					
FROM
		SurveyRequest		t10
WHERE 
		t10.surveyResponseObjectId IS NULL 
	AND
		t10.surveyResponseUuid IS NOT NULL



-- gets surveyresponse list based on surveyRequest list
INSERT INTO #SurveyResponseUuid ( SurveyResponseObjectId, SurveyResponseUuid  )
SELECT	s.objectId,
		s.Uuid
FROM	#SurveyRequestUuid t
		INNER JOIN SurveyResponse s WITH (NOLOCK) ON (t.SurveyResponseUuid = s.uuid)


-- Combines both # tables
INSERT INTO #UpdateCachedRequests_Prep ( SurveyRequestObjectId, SurveyResponseObjectId, SurveyResponseUuid )
SELECT
		t10.SurveyRequestObjectId
		, t20.SurveyResponseObjectId
		, t20.SurveyResponseUuid
FROM
		#SurveyRequestUuid		t10
	JOIN
		#SurveyResponseUuid	t20
			ON t10.SurveyResponseUuid = t20.SurveyResponseUuid






----******************* W A R N I N G***************************


-- Original Update Statment modified to use new combined # table
UPDATE	t30
SET		t30.SurveyResponseObjectId = t40.SurveyResponseObjectId	
FROM
		SurveyRequest				t30
	JOIN
		#UpdateCachedRequests_Prep	t40
			ON t30.objectId = t40.SurveyRequestObjectId


----***********************************************************




-- Testing
--SELECT *	FROM #SurveyRequestUuid
--SELECT *	FROM #SurveyResponseUuid
--SELECT *	FROM #UpdateCachedRequests_Prep





/*

	Results outcome
	
-- Was
Query Duration 		= 2:37 
	
SurveyRequest rows 	= 39
SurveyResponse rows	= 324,852,857

SurveyRequest data set size		= 3 KB
SurveyResponse  data set size	= 6,506MB



-- Now
Query Duration 		= 0:00 	
SurveyRequest rows 	= 39
SurveyResponse rows	= 324,852,857



*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
