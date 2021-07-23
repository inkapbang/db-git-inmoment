SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure SurveyRequestParam_FtpFileFormat_v3
CREATE  Procedure SurveyRequestParam_FtpFileFormat_v3
AS
/**************************  Survey Request Post 3rd Attempt Convert To Web - Time Warner Version 2  **************************

	Originally Requested by Paul Pratt, Eli Fillmore, Eric Deitz
	Contributions by Will Frazier, Stephen Gowdey

	Pivot portion
		http://www.calsql.com/2009/10/pivot-with-out-aggregate.html
	
	History
		8.08.2013	Tad Peterson
			-- initial creation
			
		8.08.2013	Tad Peterson
			-- re-wrote; misunderstanding on required paramerters
			
		8.14.2013	Tad Peterson
			-- add the update statement to make version = 2 for no email param
		
		2.3.2014	Tad Peterson
			-- modified the paths to reflect PutWh01

****************************************************************************************************************************/
SET NOCOUNT ON

-- Builds file name & timestamp
IF EXISTS ( SELECT 1	FROM tempdb.dbo.sysobjects	WHERE ID = OBJECT_ID(N'tempdb..##FileNameAndTimestamp')	)
	BEGIN
		-- Table Exists; Do this
		TRUNCATE TABLE ##FileNameAndTimestamp
		INSERT INTO ##FileNameAndTimestamp ( dateStamp, [timeStamp], csvFileName )
		SELECT 
				CONVERT(char(8), GETDATE(), 112)
				, REPLACE( SUBSTRING( CAST(CAST( GETDATE() as time ) as varchar ), 1, 8 ), ':', '.' )
				, 'C:\SSIS Packages\SurveyRequestParam_FtpFileFormat\CsvFileLocation_PrepForFtpMove\' + CONVERT(char(8), GETDATE(), 112) + '_' + REPLACE( SUBSTRING( CAST(CAST( GETDATE() as time ) as varchar ), 1, 8 ), ':', '.' ) + '_TWC_Outbound.csv'
	END
ELSE
	BEGIN
		-- Table Does Not Exist; Do this instead
		CREATE TABLE ##FileNameAndTimestamp
			( dateStamp		varchar(8), [timeStamp]		varchar(8), csvFileName		varchar(255)  )

		INSERT INTO ##FileNameAndTimestamp ( dateStamp, [timeStamp], csvFileName )
		SELECT 
				CONVERT(char(8), GETDATE(), 112)
				, REPLACE( SUBSTRING( CAST(CAST( GETDATE() as time ) as varchar ), 1, 8 ), ':', '.' )
				, 'C:\SSIS Packages\SurveyRequestParam_FtpFileFormat\CsvFileLocation_PrepForFtpMove\' + CONVERT(char(8), GETDATE(), 112) + '_' + REPLACE( SUBSTRING( CAST(CAST( GETDATE() as time ) as varchar ), 1, 8 ), ':', '.' ) + '_TWC_Outbound.csv'
	END

	
	
	
-- Creates or Truncates ##SurveyRequestParam_FtpFileFormat
--DROP TABLE ##SurveyRequestParam_FtpFileFormat		
IF EXISTS ( SELECT 1	FROM tempdb.dbo.sysobjects	WHERE ID = OBJECT_ID(N'tempdb..##SurveyRequestParam_FtpFileFormat')	)
	BEGIN
		-- Table Exists; Do this
		TRUNCATE TABLE ##SurveyRequestParam_FtpFileFormat
		
	END
ELSE
	BEGIN
		-- Table Does Not Exist; Do this instead
		CREATE TABLE dbo.##SurveyRequestParam_FtpFileFormat
		(
			[SurveyRequestObjectId] int 
			, [SurveyGatewayAlias] 	varchar(10)
			, [d] 					varchar(255) 
			, [ts] 					varchar(255) 
			, [te] 					varchar(255) 
			, [oc] 					varchar(255) 
			, [an] 					varchar(255) 
			, [cc] 					varchar(255) 
			, [vdn] 				varchar(255) 
			, [s] 					varchar(255) 
			, [sn] 					varchar(255) 
			, [a] 					varchar(255) 
			, [m] 					varchar(255) 
			, [cip] 				varchar(255) 
			, [anm] 				varchar(255) 
			, [can] 				varchar(255) 
			, [v] 					varchar(255) 
			, [hsd] 				varchar(255) 
			, [p] 					varchar(255) 
			, [mrr] 				varchar(255) 
			, [ct] 					varchar(255) 
			, [ctb] 				varchar(255) 
			, [e] 					varchar(255) 
			, [ccn] 				varchar(255) 
			, [eb] 					varchar(255) 
			, [sc] 					varchar(255) 
			, [ss] 					varchar(255)
		)		
	END




	
-- SurveyRequest Table
IF OBJECT_ID('tempdb..##SurveyRequestParam_TransformToWebRequest') IS NOT NULL			DROP TABLE ##SurveyRequestParam_TransformToWebRequest
SELECT
		--TOP 10 
		--*

		t10.objectId							AS	SurveyRequestObjectId
		, t10.surveyGatewayObjectId
		, CASE	WHEN t10.surveyGatewayObjectId = 3978	THEN 'TMCinstwsw'	--3981
				WHEN t10.surveyGatewayObjectId = 3979	THEN 'TWCservwsw'	--3980
				WHEN t10.surveyGatewayObjectId = 3983	THEN 'TWCscwsw'		--3982
			END
												AS SurveyGatewayAlias
						
INTO ##SurveyRequestParam_TransformToWebRequest

FROM
		SurveyRequest		t10
	LEFT JOIN
		SurveyResponse		t20
			ON t10.SurveyResponseObjectId = t20.ObjectId

WHERE
		t10.surveyGatewayObjectId IN
		
									(
										3978		--> 3981									
										, 3979 		--> 3980								
										, 3983		--> 3982
									) 


	 -- /*  filters for 3 attempts  */
	AND
		t10.AttemptCount >= 2


	 -- /*  filters for those that have already been processed  */
	AND
		(
				t10.version < 1
			OR
				t10.version IS NULL
		)
		
	
	-- /*  filters for only incompletes  */
	AND
		(
				t20.complete != 1

			OR
				t20.complete IS NULL

		)


		
-- Creates Work Temp Table
IF OBJECT_ID('tempdb..##WorkTable01') IS NOT NULL			DROP TABLE ##WorkTable01
SELECT 
		t10.SurveyRequestObjectId
		, t10.param_name
		, t10.param_value 

INTO	##WorkTable01			

FROM 
		SurveyRequestParam		t10
	JOIN
		##SurveyRequestParam_TransformToWebRequest	t20
			ON t10.SurveyRequestObjectId = t20.SurveyRequestObjectId
					

--SELECT *	FROM ##WorkTable01

	
-- Pivot of data	
IF EXISTS ( SELECT 1	FROM tempdb.dbo.sysobjects	WHERE ID = OBJECT_ID(N'tempdb..##GROUPS')	) DROP TABLE ##GROUPS	
;
--with cte_group(RID,IID,COL0,COL1)
WITH SRParam_CTE( RID, SurveyRequestObjectId, param_name, param_value )

AS

(

SELECT 
		ROW_NUMBER() OVER (ORDER BY SurveyRequestObjectId )AS RID
		, * 
FROM

--customers ~ SELECT statement with adding one row at the end with value Name

(
		SELECT 
				* 
		FROM 
				--customers
				##WorkTable01				 
		UNION 
		
		SELECT 
				MAX(SurveyRequestObjectId) + 1
				,'oc'
				,''
								
				
		FROM 
				--customers
				##WorkTable01				
)	AS A

WHERE 
		param_name = 'oc'

)

-- sent data to a temp table

SELECT 
		* 
INTO	##GROUPS 

FROM 
		##WorkTable01 a
	join 
		(
			SELECT 
					A.RID
					, A.SurveyRequestObjectId as strt 
					, B.SurveyRequestObjectId as ends 
			FROM 
					SRParam_CTE A 
				JOIN 
					SRParam_CTE B 
						ON B.RID - A.RID = 1
		) b

			ON 
					a.SurveyRequestObjectId >= b.strt 
				AND 
					a.SurveyRequestObjectId < b.ends

					
/*  Testing
SELECT 
		* 
FROM 
		##GROUPS 
WHERE 
		SurveyRequestObjectId = 227121620
		--param_name = 'd'
*/




INSERT INTO ##SurveyRequestParam_FtpFileFormat ( SurveyRequestObjectId, [d], [ts], [te], [oc], [an], [cc], [vdn], [s], [sn], [a], [m], [cip], [anm], [can], [v], [hsd], [p], [mrr], [ct], [ctb], [e], [ccn], [eb], [sc], [ss] )
SELECT
		SurveyRequestObjectId 
		, [d] 
		, [ts] 
		, [te] 
		, [oc] 
		, [an] 
		, [cc] 
		, [vdn] 
		, [s] 
		, [sn] 
		, [a] 
		, [m] 
		, [cip] 
		, [anm] 
		, [can] 
		, [v] 
		, [hsd] 
		, [p] 
		, [mrr] 
		, [ct] 
		, [ctb] 
		, [e] 
		, [ccn] 
		, [eb] 
		, [sc] 
		, [ss] 

FROM

		(
			SELECT 
					SurveyRequestObjectId
					, param_name
					, param_value
					, RID

			FROM 
					--SRParam_CTE
					##GROUPS 
		) AS t10

	PIVOT

		(
			MAX(param_value) FOR param_name IN 
												(
													[d] 
													, [ts] 
													, [te] 
													, [oc] 
													, [an] 
													, [cc] 
													, [vdn] 
													, [s] 
													, [sn] 
													, [a] 
													, [m] 
													, [cip] 
													, [anm] 
													, [can] 
													, [v] 
													, [hsd] 
													, [p] 
													, [mrr] 
													, [ct] 
													, [ctb] 
													, [e] 
													, [ccn] 
													, [eb] 
													, [sc] 
													, [ss] 
												)

		) AS PivotTable;
	


-- Testing	
--SELECT *	FROM 	##SurveyRequestParam_FtpFileFormat
	

-- Updates Records that do not have email param associated with it
UPDATE 	t10
SET		t10.version = 2
FROM
		SurveyRequest	t10
	JOIN
		##SurveyRequestParam_FtpFileFormat	t20
			ON t10.objectId = SurveyRequestObjectId
WHERE
		t20.[e]						IS NULL
	OR
		t20.[e]						NOT LIKE '%@%'

			
	
-- Deletes any NULL rows
DELETE	t10
FROM
		##SurveyRequestParam_FtpFileFormat		t10
WHERE
		[e]						IS NULL
	OR
		[e]						NOT LIKE '%@%'


-- Testing	
--SELECT *	FROM 	##SurveyRequestParam_FtpFileFormat
	
	
	
-- Updates File to have have proper gateway	
UPDATE	t10
SET		t10.SurveyGatewayAlias = t20.SurveyGatewayAlias
FROM	
		##SurveyRequestParam_FtpFileFormat	t10
	JOIN
		(
			SELECT
					DISTINCT SurveyRequestObjectId
					, SurveyGatewayAlias
			FROM
					##SurveyRequestParam_TransformToWebRequest
		)
			AS t20
				ON t10.SurveyRequestObjectId = t20.SurveyRequestObjectId
	


-- Views contents results
--SELECT *	FROM ##FileNameAndTimestamp
--SELECT *	FROM ##SurveyRequestParam_FtpFileFormat


-- Testing Stored Procedure
--EXECUTE SurveyRequestParam_FtpFileFormat_v3
	
	
	
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
