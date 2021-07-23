SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.usp_maint_updateModifiedResponses_vReplicatedStoredProc
	@DisplayInfo					int = 1
	, @GenerateCountsOnly			int = 1	
	, @ProcessModifiedData			int = 0
	, @BatchSize					int = 4000
	
	, @ShowChecks					int = 0



AS
/**********************************  Update Modified Responses  **********************************

	Comments
	
		To be executed on OLTP
				
		Dave originally wrote this for help with databus processing
			


	History
		08.01.2014	Dave Robinson	
			-- created
	
		09.19.2014	Tad Peterson
			-- turned it into a replicated stored proc
			-- re write for scalability


*************************************************************************************************/
SET NOCOUNT ON

-- For use with RAISERROR
DECLARE @message	nvarchar(200)



-- Processing Checks
DECLARE @BatchSizeCheck					int
DECLARE @ProcessModifiedDataCheck		int
DECLARE @GenerateCountsOnlyCheck		int
DECLARE @ShowChecksCheck				int
DECLARE @DisplayInfoCheck				int


SET @ProcessModifiedDataCheck			= CASE WHEN @ProcessModifiedData	> 0		THEN 1							ELSE 0		END
SET	@BatchSizeCheck						= CASE WHEN @BatchSize 				> 0		THEN 1							ELSE 0		END
SET @GenerateCountsOnlyCheck			= CASE WHEN @GenerateCountsOnly		= 0		THEN 0							ELSE 1		END
SET @ShowChecksCheck					= CASE WHEN @ShowChecks				= 1		THEN 1							ELSE 0		END
SET @DisplayInfoCheck					= CASE WHEN @DisplayInfo			= 1		THEN 1							ELSE 0		END




-- Table Counts Variables
DECLARE @SurveyResponseModifiedCount						Int
DECLARE @SurveyResponseModifiedDistinct						Int



-- Batching Variables
DECLARE @CurrentUpdateTime 		DateTime
DECLARE @ResMod_Total			int









-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC dbo.usp_maint_updateModifiedResponses_vReplicatedStoredProc'
	PRINT N'	@DisplayInfo			   = 0'
	PRINT N'	, @GenerateCountsOnly	   = 1'	
	PRINT N'	, @ProcessModifiedData     = 0'
	PRINT N'	, @BatchSize			   = 4000'
	PRINT N' '
	PRINT N'    , @ShowChecks			   = 1'


	RETURN

	
END









															
															
															
															
															


-- Enables input checking
IF @ShowChecksCheck = 1
BEGIN
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  



	SELECT
				
			@ShowChecksCheck							AS ShowChecksCheck
			, @ShowChecks								AS ShowChecks
			
			, @GenerateCountsOnlyCheck					AS GenerateCountsOnlyCheck
			, @GenerateCountsOnly						AS GenerateCountsOnly
			
			, @ProcessModifiedDataCheck					AS ProcessModifiedDataCheck
			, @ProcessModifiedData						AS ProcessModifiedData
			
			, @BatchSizeCheck							AS [BatchSizeCheck]			
			, @BatchSize								AS [BatchSize]
			

			
END











IF @GenerateCountsOnlyCheck = 1
BEGIN


	-- SurveyResponseModified table counts
	SET		@SurveyResponseModifiedCount				= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		ResponseModified
															)
															
	-- Distinct SurveyResponseModified table counts
	SET		@SurveyResponseModifiedDistinct
														=	
															(
																SELECT
																		COUNT(1)
																FROM
																		(
																			SELECT	
																					DISTINCT
																					ResponseId
																			FROM		
																					ResponseModified
																					
																		) AS t10
															)



															
															
	-- Max Lasted Modified														
	SET 	@CurrentUpdateTime 							= ( SELECT MAX( LastModified ) FROM ResponseModified )
															


	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'Information                       '
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'ResponseModified Counts           ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseModifiedCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 


	SET @message = 'ResponseModified Distinct Counts  ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseModifiedDistinct  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 



	SET @message = 'Max Last Modified Timestamp UTC   ' + CAST( @CurrentUpdateTime	as varchar )
	RAISERROR (@message,0,1) with NOWAIT 


	RETURN

															
															
END







IF @ProcessModifiedDataCheck = 1 AND @GenerateCountsOnly = 0
BEGIN
	
		-- Adjusts max batch size to not exceed 4000
		IF @BatchSize > 4000
		BEGIN
		
			SET @message = 'Max batch size can not exceed 4000.'
			RAISERROR (@message,0,1) with NOWAIT 
			
			SET @message = 'Max batch size is being set to 4000.'
			RAISERROR (@message,0,1) with NOWAIT  

			
			SET @message = ' '
			RAISERROR (@message,0,1) with NOWAIT  
			RAISERROR (@message,0,1) with NOWAIT  

			SET @BatchSize = 4000

		END




	SET @message = 'Processing Response Modified Data'
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  
	

	
	
-- Creates working table
IF OBJECT_ID('tempdb..#SurveyResponseModified') IS NOT NULL				DROP TABLE #SurveyResponseModified		
CREATE TABLE #SurveyResponseModified
	(
		RowId						int Identity ( 1, 1 )
		, SurveyResponseObjectId	int
		, LastModified				dateTime
		
		, CONSTRAINT PK_TempSurveyResponse PRIMARY KEY CLUSTERED
			( RowId ASC ) WITH ( FILLFACTOR = 100 ) 
		
	)



-- Creates current working table
IF OBJECT_ID('tempdb..#SurveyResponseModified_Current') IS NOT NULL		DROP TABLE #SurveyResponseModified_Current		
CREATE TABLE #SurveyResponseModified_Current
	(
		RowId						int Identity ( 1, 1 )
		, SurveyResponseObjectId	int
		, LastModified				dateTime
		
		, CONSTRAINT PK_TempSurveyResponse_Current PRIMARY KEY CLUSTERED
			( RowId ASC ) WITH ( FILLFACTOR = 100 ) 
		
	)
	

	
	

-- Sets the CurrentUpdateTime
SET 	@CurrentUpdateTime 	= ( SELECT MAX( LastModified ) FROM ResponseModified )








-- Loads batch table
INSERT INTO #SurveyResponseModified ( SurveyResponseObjectId, LastModified )
SELECT
		TOP ( @BatchSize )
		t10.ResponseId				AS SurveyResponseObjectId
		, MAX( t10.LastModified	)	AS LastModified
FROM 
		ResponseModified	t10
	JOIN 
		(
			SELECT 
					DISTINCT
					ResponseId
            FROM 
					ResponseModified
            WHERE 
					LastModified <= @CurrentUpdateTime
		) AS t20
				ON t10.ResponseId = t20.ResponseId
WHERE 
		LastModified <= @CurrentUpdateTime
GROUP BY
		t10.ResponseId
ORDER BY
		MAX( t10.LastModified	)		DESC
		, t10.ResponseId				DESC
		
		
		
		

		
-- Sets counts		
SET @ResMod_Total = ( SELECT COUNT(1)	FROM #SurveyResponseModified )
	


-- Processing the batch	
WHILE @ResMod_Total > 0
BEGIN

				-- Updates SurveyResponse table in batches
				SET @message = 'ResponseModified remaining in this batch ' + CAST( @ResMod_Total as varchar )
				RAISERROR (@message,0,1) with NOWAIT  


				
				-- Current 500 batch working table
				INSERT INTO #SurveyResponseModified_Current ( SurveyResponseObjectId, LastModified )
				SELECT
						TOP 500
						SurveyResponseObjectId
						, LastModified						
				FROM
						#SurveyResponseModified
				ORDER BY
						RowId ASC

						
						
				-- Update SurveyResponse Table
				UPDATE 	t10 
				SET 	t10.lastModTime = t20.LastModified
				FROM 
						SurveyResponse 						t10 	WITH ( ROWLOCK )
					JOIN
						#SurveyResponseModified_Current		t20
							ON t10.objectId = t20.SurveyResponseObjectId
						

				
				-- Deletes from original ResponseModified Table
				DELETE
						t10
				FROM
						ResponseModified					t10		WITH ( ROWLOCK )
					JOIN
						#SurveyResponseModified_Current		t20
							ON 
									t10.ResponseId 		= t20.SurveyResponseObjectId 
								AND 
									t10.LastModified 	<= @CurrentUpdateTime
						
						
						
						
				-- Deletes from working table
				DELETE 
						t10
				FROM
						#SurveyResponseModified				t10
					JOIN
						#SurveyResponseModified_Current		t20
							ON t10.SurveyResponseObjectId = t20.SurveyResponseObjectId
						



				-- Trucate current table
				TRUNCATE TABLE #SurveyResponseModified_Current
				
				


						
				-- Re-calculate Totals
				SET @ResMod_Total = ( SELECT COUNT(1)	FROM #SurveyResponseModified )


END



	
END





-- Testing
--SELECT *	FROM #SurveyResponseModified
--SELECT *	FROM #SurveyResponseModified	WHERE LastModified >= DATEADD( Minute, -1, @CurrentUpdateTime )
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
