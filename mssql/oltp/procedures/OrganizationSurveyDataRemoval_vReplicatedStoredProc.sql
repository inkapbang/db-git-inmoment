SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.OrganizationSurveyDataRemoval_vReplicatedStoredProc
	@DisplayInfo				int				= 1
	, @ShowChecks				int				= 0		
	, @OrganizationObjectId		int				= NULL
	, @OrganizationName			varchar(100)	= NULL
	, @ValidateOrgIdNameOnly	int				= 1
	, @GenerateCountsTableOnly 	int				= 0
	, @ProcessDataRemoval		int				= 0
	, @BatchSize				int				= 0
	, @SubTableMultiplier		int				= 1



AS

/**************************  Organization Survey Data Removal  **************************

	Comments
		Result of a disk space meeting

		Comcast generate counts duration 35 minutes
		
		Based off of incompletes removal stored proc
		
		TR_SurveyResponse_AFTER_DELETE may cause Dev machines to error.  
		If so, copy productions doctor oltp version.
		
		SurveyResponseDeleted not present in Dev.
		
		
	History
		09.10.2014	Tad Peterson
			-- script & stored proc build

		09.24.2014 	Tad Peterson
			-- verified proper deleting in dev	

		10.23.2014	Tad Peterson
			-- changed SRA & SRScore delete to be @BatchSize * 10, reduce duration of IX lock
			-- as it iterates over all the answers
			-- Reordered the deletes sequence.  SRScore, SRA, SR  to be the last three
			-- tables to be deleted from
			
		10.24.2014	Tad Peterson
			-- changed to process a single table at over each iteration
			-- added SubTableMultiplier variable

		10.27.2014	Tad Peterson
			-- removed PK Clustered Constraints on temp tables
			-- varified failure will occur even with single # temp tables
			-- Modified opsView & db job blocking to 30000 ( 30 sec ) from 10000 mil
			
		10.31.2014	Tad Peterson
			-- removed order by clause for build SR temp table
			
			
***************************************************************************************/
SET NOCOUNT ON

									

DECLARE @OrganizationObjectIdCheck				int
SET		@OrganizationObjectIdCheck				= CASE	WHEN @OrganizationObjectId IS NULL 			THEN 0
														WHEN @OrganizationObjectId > 0				THEN 1
														ELSE 0
													END


DECLARE @OrganizationNameCheck					int
SET		@OrganizationNameCheck					= CASE	WHEN LEN(@OrganizationName) IS NULL 		THEN 0
														WHEN LEN(@OrganizationName) = 0				THEN 0
														WHEN LEN(@OrganizationName) > 0				THEN 1
													END


DECLARE @ShowChecksCheck						int
SET		@ShowChecksCheck						= CASE	WHEN @ShowChecks IS NULL 					THEN 0
														WHEN @ShowChecks = 1						THEN 1
														ELSE 0
													END
													
													
DECLARE @ValidateOrgIdNameOnlyCheck				int
SET		@ValidateOrgIdNameOnlyCheck				= CASE	WHEN @ValidateOrgIdNameOnly IS NULL 		THEN 0
														WHEN @ValidateOrgIdNameOnly = 1				THEN 1
														ELSE 0
													END
													
													
DECLARE @GenerateCountsTableOnlyCheck			int
SET		@GenerateCountsTableOnlyCheck			= CASE	WHEN @GenerateCountsTableOnly IS NULL 		THEN 0
														WHEN @GenerateCountsTableOnly = 1			THEN 1
														ELSE 0
													END
													
													
DECLARE @ProcessDataRemovalCheck				int
SET		@ProcessDataRemovalCheck				= CASE	WHEN @ProcessDataRemoval IS NULL 			THEN 0
														WHEN @ProcessDataRemoval = 1				THEN 1
														ELSE 0
													END
													
													
DECLARE @BatchSizeCheck							int
SET		@BatchSizeCheck							= CASE	WHEN @BatchSize IS NULL 					THEN 0
														WHEN @BatchSize > 0							THEN 1
														ELSE 0
													END


DECLARE @SubtableMultiplierCheck				int
SET 	@SubtableMultiplierCheck				= CASE	WHEN @SubtableMultiplier IS NULL 			THEN 0
														WHEN @SubtableMultiplier > 0				THEN 1
														ELSE 0
													END

													
DECLARE @DisplayInfoCheck						int
SET 	@DisplayInfoCheck						= CASE WHEN @DisplayInfo				= 1			THEN 1		ELSE 0						END
														

														
-- Used to expand 	TOP ( @BatchSize * @SubtableMultiplier )
SET @SubtableMultiplier 						= CASE WHEN @SubtableMultiplier IS NULL				THEN 1 		ELSE @SubtableMultiplier 	END






														
-- These are used for throttling														
DECLARE @message								nvarchar(200)
DECLARE @check									int



-- Table Counts Variables
DECLARE @SurveyResponseCount		BigInt
DECLARE @SurveyResponseAnswerCount	BigInt
DECLARE @CommentCount				Int
DECLARE @CommentAccessCount			Int
DECLARE @SurveyResponseAlertCount	Int
DECLARE @SurveyResponseNoteCount	BigInt
DECLARE @SurveyResponseScoreCount	BigInt
DECLARE @ResponseTagCount			Int
DECLARE @SurveyRequestCount			BigInt
DECLARE @SurveyRequestParamCount	BigInt
DECLARE @TermAnnotationCount		Int
DECLARE @TagAnnotationCount			Int

DECLARE @StartDelete				DateTime
DECLARE @EndDelete					DateTime
DECLARE @DeleteDuration				Int



/*

	Put processing logic here
	
	, @ValidateOrgIdNameOnly	= 1
	, @GenerateCountsTableOnly 	= 1
	, @ProcessDataRemoval		= NULL
	, @BatchSize				= NULL


*/




-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC dbo.OrganizationSurveyDataRemoval_vReplicatedStoredProc'
	PRINT N'	@DisplayInfo			    = 0'
	PRINT N'    , @ShowChecks				= 0'	
	PRINT N'    , @OrganizationObjectId     = 439'
	PRINT N'    , @OrganizationName         = ''zComcast Digital'''
	PRINT N' '
	PRINT N'    , @ValidateOrgIdNameOnly	= 0'
	PRINT N'    , @GenerateCountsTableOnly 	= 1'
	PRINT N'    , @ProcessDataRemoval		= 1'
	PRINT N'    , @BatchSize				= 5000'
	PRINT N'    , @SubTableMultiplier		= 10'
	
	PRINT N' '
	PRINT N' '
	PRINT N' '
	


	RETURN

	
END









-- Enables input checking
IF @ShowChecksCheck = 1
BEGIN
	SELECT @ShowChecks     AS ShowChecks, @ShowChecksCheck		AS ShowChecksCheck, @OrganizationObjectId				AS OrganizationObjectId, @OrganizationObjectIdCheck		AS OrganizationObjectIdCheck, @OrganizationName					AS OrganizationName, @OrganizationNameCheck			AS OrganizationNameCheck, @ValidateOrgIdNameOnly			AS ValidateOrgIdNameOnly, @ValidateOrgIdNameOnlyCheck		AS ValidateOrgIdNameOnlyCheck, @GenerateCountsTableOnly			AS GenerateCountsTableOnly, @GenerateCountsTableOnlyCheck		AS GenerateCountsTableOnlyCheck, @ProcessDataRemoval				AS ProcessDataRemoval, @ProcessDataRemovalCheck			AS ProcessDataRemovalCheck, @BatchSize						AS [BatchSize], @BatchSizeCheck					AS [BatchSizeCheck], @SubtableMultiplierCheck		AS SubtableMultiplierCheck, @SubtableMultiplier		AS SubtableMultiplier 
END


		





VALIDATE:

-- Organization Validation; no id present
IF @OrganizationObjectIdCheck <> 1
BEGIN
		SET @message = 'No Organization Id present, check inputs and reprocess.'
		RAISERROR (@message,0,1) with NOWAIT

		RETURN
END





-- Organization Validation; no name present
IF @OrganizationObjectIdCheck <> 1 OR @OrganizationNameCheck <> 1
BEGIN
		SET @message = 'No Organization name present, check inputs and reprocess.'
		RAISERROR (@message,0,1) with NOWAIT

		RETURN
END





-- Organization Validation; Proper Id and Proper Naming Combination
IF @OrganizationObjectIdCheck = 1 AND @OrganizationNameCheck = 1
BEGIN

		-- Validates proper name
		IF NOT EXISTS ( SELECT Name 		FROM Organization	WHERE Name = @OrganizationName )
		BEGIN
		 
			SET @message = 'Organization name does not exist. Please check input.'
			RAISERROR (@message,0,1) with NOWAIT
			
			RETURN				
		END



		-- Validates proper objectId
		IF NOT EXISTS ( SELECT objectId 	FROM Organization	WHERE objectId = @OrganizationObjectId )
		BEGIN
		 
			SET @message = 'Organization id does not exist. Please check input.'
			RAISERROR (@message,0,1) with NOWAIT
			
			RETURN
		END



		-- Validating Proper Name and OrgId
		IF( SELECT ObjectId 	FROM Organization	WHERE Name = @OrganizationName ) <> @OrganizationObjectId AND ( SELECT Name 	FROM Organization	WHERE ObjectId = @OrganizationObjectId ) <> @OrganizationName
		BEGIN
			
			SET @message = 'Orgainzation Id and Organization Name combination is NOT accurate. Please check input.'
			RAISERROR (@message,0,1) with NOWAIT
			
			RETURN
						
		END



		-- Enabled Validation
		IF( SELECT ObjectId 	FROM Organization	WHERE Name = @OrganizationName ) = @OrganizationObjectId AND ( SELECT Name 	FROM Organization	WHERE ObjectId = @OrganizationObjectId ) = @OrganizationName
		BEGIN
			
			IF( SELECT Enabled	FROM Organization	WHERE ObjectId = @OrganizationObjectId ) = 1
			BEGIN
				SET @message = 'This organization is currently enabled.  Verify you have the proper organization id.'
				RAISERROR (@message,0,1) with NOWAIT
				
				RETURN
			END
						
		END



		-- Disabled Validation
		IF( SELECT ObjectId 	FROM Organization	WHERE Name = @OrganizationName ) = @OrganizationObjectId AND ( SELECT Name 	FROM Organization	WHERE ObjectId = @OrganizationObjectId ) = @OrganizationName
		BEGIN
			
			IF( SELECT Enabled	FROM Organization	WHERE ObjectId = @OrganizationObjectId ) = 0
			BEGIN
				SET @message = 'Orgainzation Id, Organization Name, and Organization Disabled has passed validation.'
				RAISERROR (@message,0,1) with NOWAIT
				
				-- No Return necessary as this needs to progress through stored proc.
			END
						
		END
END




IF @ValidateOrgIdNameOnlyCheck	= 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Org Name & Id validation check only was requested, nothing else can be processes while this flag is enabled ( default ).'
	RAISERROR (@message,0,1) with NOWAIT  

	RETURN
	
END



-- Makes sure both types of processing are not present
IF @GenerateCountsTableOnlyCheck = 1 AND @ProcessDataRemovalCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Both "generate table counts only" and "process data removal check" are present, check your inputs and resubmit.'
	RAISERROR (@message,0,1) with NOWAIT  

	RETURN

END






-- Generates Counts on Table Only
IF @GenerateCountsTableOnlyCheck = 1
BEGIN

-- Building Result Set
SET @message = ' '
RAISERROR (@message,0,1) with NOWAIT  
RAISERROR (@message,0,1) with NOWAIT  



SET @message = 'Organization Name      ' + @OrganizationName
RAISERROR (@message,0,1) with NOWAIT  


SET @message = 'Organization Id        ' + CAST( @OrganizationObjectId   as varchar )
RAISERROR (@message,0,1) with NOWAIT  


SET @message = ' '
RAISERROR (@message,0,1) with NOWAIT  


SET @message = 'Table Counts           '
RAISERROR (@message,0,1) with NOWAIT  



-- SurveyResponse
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
	(
		RowId						BigInt	Identity ( 1, 1 )
		, SurveyResponseObjectId	BigInt
	)		



-- SurveyResponse
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse ( SurveyResponseObjectId )
SELECT
		t10.objectId		AS SurveyResponseObjectId		
FROM
		SurveyResponse		t10
	JOIN
		Survey				t20
			ON t10.surveyObjectId = t20.objectId AND t20.organizationObjectId = @OrganizationObjectId
		


-- SurveyResponse Count
SET @SurveyResponseCount	= ( SELECT MAX( RowId )	FROM #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse )

SET @message = 'SurveyResponse         ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  











/*  Too many ids for this method to work
-- SurveyResponseAnswer
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAnswer') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAnswer		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAnswer
	(
		RowId							BigInt	Identity ( 1, 1 )
		, SurveyResponseAnswerObjectId	BigInt
	)		


-- SurveyResponseAnswer
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAnswer ( SurveyResponseAnswerObjectId )
SELECT
		t10.objectId				AS SurveyResponseObjectId		
FROM
		SurveyResponseAnswer		t10
WHERE
		
		SurveyResponseObjectId IN	( 
										SELECT	
												SurveyResponseObjectId
										FROM
												#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
									)	

*/

-- SurveyResponseAnswer Count
SET @SurveyResponseAnswerCount			=	( 
													SELECT 
															COUNT_BIG(1)
																
													FROM 
															SurveyResponseAnswer 
													WHERE
															SurveyResponseObjectId IN	( 
																							SELECT	
																									SurveyResponseObjectId
																							FROM
																									#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
																						)	
												)




SET @message = 'SurveyResponseAnswer   ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseAnswerCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  













-- Comment
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
	(
		RowId						Int	Identity ( 1, 1 )
		, CommentObjectId			Int
		
	)		



-- Comment
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment ( CommentObjectId )
SELECT
		t20.objectId				AS CommentObjectId		
FROM
		SurveyResponseAnswer		t10
	JOIN
		Comment						t20
			ON t10.objectId = t20.SurveyResponseAnswerObjectId
WHERE
		t10.SurveyResponseObjectId IN	( 
											SELECT	
													SurveyResponseObjectId
											FROM
													#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
										)	


-- Comment Count
SET @CommentCount		= ( SELECT MAX( RowId )	FROM #OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment )

SET @message = 'Comment                ' + REPLACE(CONVERT(varchar(20), (CAST( @CommentCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  










/*  Switched to varilable only
-- CommentAccess
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_CommentAccess') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_CommentAccess		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_CommentAccess
	(
		RowId						Int	Identity ( 1, 1 )
		, CommentAccessObjectId		Int
		
	)		



-- CommentAccess
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_CommentAccess ( CommentAccessObjectId )
SELECT
		t10.objectId				AS CommentAccessObjectId		
FROM
		CommentAccess				t10
WHERE
		t10.CommentObjectId IN	( 
									SELECT	
											CommentObjectId
									FROM
											#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
								)	

*/
-- CommentAccess Count
SET @CommentAccessCount		= 	( 
										SELECT 
												COUNT(1)
													
										FROM 
												CommentAccess 
										WHERE
												CommentObjectId IN	( 
																		SELECT	
																				CommentObjectId
																		FROM
																				#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
																	)	
									)

SET @message = 'CommentAccess          ' + REPLACE(CONVERT(varchar(20), (CAST( @CommentAccessCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  










/*  Switched to varilable only
-- SurveyResponseNote
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseNote') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseNote		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseNote
	(
		RowId								BigInt	Identity ( 1, 1 )
		, SurveyResponseNoteObjectId		BigInt
		
	)		



-- SurveyResponseNote
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseNote ( SurveyResponseNoteObjectId )
SELECT
		t10.objectId					AS SurveyResponseNoteObjectId		
FROM
		SurveyResponseNote				t10
WHERE
		t10.SurveyResponseObjectId IN	( 
											SELECT	
													SurveyResponseObjectId
											FROM
													#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
										)	

*/

-- SurveyResponseNote Count
SET @SurveyResponseNoteCount 				= 	( 
													SELECT 
															COUNT_BIG(1)
																
													FROM 
															SurveyResponseNote 
													WHERE
															SurveyResponseObjectId IN	( 
																							SELECT	
																									SurveyResponseObjectId
																							FROM
																									#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
																						)	
												)

SET @message = 'SurveyResponseNote     ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseNoteCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  










/*  Switched to varilable only
-- SurveyResponseScore
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseScore') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseScore		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseScore
	(
		RowId								BigInt	Identity ( 1, 1 )
		, SurveyResponseScoreObjectId		BigInt
		
	)		



-- SurveyResponseScore
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseScore ( SurveyResponseScoreObjectId )
SELECT
		t10.objectId					AS SurveyResponseScoreObjectId		
FROM
		SurveyResponseScore				t10
WHERE
		t10.SurveyResponseObjectId IN	( 
											SELECT	
													SurveyResponseObjectId
											FROM
													#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
										)	

*/

-- SurveyResponseScore Count
SET @SurveyResponseScoreCount				= 	( 
													SELECT 
															COUNT_BIG(1)
																
													FROM 
															SurveyResponseScore 
													WHERE
															SurveyResponseObjectId IN	( 
																							SELECT	
																									SurveyResponseObjectId
																							FROM
																									#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
																						)	
												)

SET @message = 'SurveyResponseScore    ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseScoreCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  











/*  Switched to varilable only
-- ResponseTag
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_ResponseTag') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_ResponseTag		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_ResponseTag
	(
		RowId						Int	Identity ( 1, 1 )
		, ResponseTagObjectId		Int
		
	)		



-- ResponseTag
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_ResponseTag ( ResponseTagObjectId )
SELECT
		t10.objectId					AS ResponseTagObjectId		
FROM
		ResponseTag						t10
WHERE
		t10.ResponseObjectId IN	( 
									SELECT	
											SurveyResponseObjectId
									FROM
											#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
								)	

*/

-- ResponseTag Count
SET @ResponseTagCount			= 	( 
										SELECT 
												COUNT(1)
													
										FROM 
												ResponseTag 
										WHERE
												ResponseObjectId IN	( 
																		SELECT	
																				SurveyResponseObjectId
																		FROM
																				#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
																	)	
									)

SET @message = 'ResponseTag            ' + REPLACE(CONVERT(varchar(20), (CAST( @ResponseTagCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  











/*  Switched to varilable only
-- SurveyRequest
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyRequest') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyRequest		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyRequest
	(
		RowId						BigInt	Identity ( 1, 1 )
		, SurveyRequestObjectId		BigInt
		
	)		



-- SurveyRequest
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyRequest ( SurveyRequestObjectId )
SELECT
		t10.objectId					AS SurveyRequestObjectId		
FROM
		SurveyRequest					t10
WHERE
		t10.SurveyResponseObjectId IN	( 
											SELECT	
													SurveyResponseObjectId
											FROM
													#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
										)	

*/

-- SurveyRequest Count
SET @SurveyRequestCount					= 	( 
												SELECT 
														COUNT_BIG(1)
															
												FROM 
														SurveyRequest 
												WHERE
														SurveyResponseObjectId IN	( 
																						SELECT	
																								SurveyResponseObjectId
																						FROM
																								#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
																					)	
											)

SET @message = 'SurveyRequest          ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyRequestCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  













/*  Switched to varilable only
-- SurveyResponseAlert
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAlert') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAlert		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAlert
	(
		RowId								Int	Identity ( 1, 1 )
		, SurveyResponseAlertObjectId		Int
		
	)		



-- SurveyResponseAlert
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponseAlert ( SurveyResponseAlertObjectId )
SELECT
		t10.objectId					AS SurveyResponseAlertObjectId		
FROM
		SurveyResponseAlert				t10
WHERE
		t10.SurveyResponseObjectId IN	( 
											SELECT	
													SurveyResponseObjectId
											FROM
													#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
										)	

*/

-- SurveyResponseAlert Count
SET @SurveyResponseAlertCount				= 	( 
													SELECT 
															COUNT(1)
																
													FROM 
															SurveyResponseAlert 
													WHERE
															SurveyResponseObjectId IN	( 
																							SELECT	
																									SurveyResponseObjectId
																							FROM
																									#OrgSurveyDataRemoval_GenerateCountsTableOnly_SurveyResponse
																						)	
												)

SET @message = 'SurveyResponseAlert    ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseAlertCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  











/*  Switched to varilable only
-- TermAnnotation
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_TermAnnotation') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_TermAnnotation		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_TermAnnotation
	(
		RowId							Int	Identity ( 1, 1 )
		, TermAnnotationObjectId		Int
		
	)		



-- TermAnnotation
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_TermAnnotation ( TermAnnotationObjectId )
SELECT
		t10.objectId					AS TermAnnotationObjectId		
FROM
		TermAnnotation					t10
WHERE
		t10.CommentId 	IN	( 
								SELECT	
										CommentObjectId
								FROM
										#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
							)	

*/

-- TermAnnotation Count
SET @TermAnnotationCount			= 	( 
											SELECT 
													COUNT(1)
														
											FROM 
													TermAnnotation 
											WHERE
													CommentId IN	( 
																		SELECT	
																				CommentObjectId
																		FROM
																				#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
																	)	
										)

SET @message = 'TermAnnotation         ' + REPLACE(CONVERT(varchar(20), (CAST( @TermAnnotationCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  












/*  Switched to varilable only
-- TagAnnotation
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_GenerateCountsTableOnly_TagAnnotation') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_TagAnnotation		
CREATE TABLE #OrgSurveyDataRemoval_GenerateCountsTableOnly_TagAnnotation
	(
		RowId						Int	Identity ( 1, 1 )
		, TagAnnotationObjectId		Int
		
	)		



-- TagAnnotation
INSERT INTO #OrgSurveyDataRemoval_GenerateCountsTableOnly_TagAnnotation ( TagAnnotationObjectId )
SELECT
		t10.objectId					AS TagAnnotationObjectId		
FROM
		TagAnnotation					t10
WHERE
		t10.CommentId 	IN	( 
								SELECT	
										CommentObjectId
								FROM
										#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
							)	

*/

-- TagAnnotation Count
SET @TagAnnotationCount	 		= 	( 
										SELECT 
												COUNT(1)
													
										FROM 
												TagAnnotation 
										WHERE
												CommentId IN	( 
																	SELECT	
																			CommentObjectId
																	FROM
																			#OrgSurveyDataRemoval_GenerateCountsTableOnly_Comment
																)	
									)

SET @message = 'TagAnnotation          ' + REPLACE(CONVERT(varchar(20), (CAST( @TagAnnotationCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  




RETURN

END

/**********  End Of Generate Table Counts Only  **********/





















PROCESSING:
-- Logic to remove improper data processing
IF @ProcessDataRemovalCheck = 1	AND @BatchSizeCheck = 0
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Request to process data exists, but no batchsize is present, please check inputs and resubmit.'
	RAISERROR (@message,0,1) with NOWAIT  

	RETURN



END



-- Logic to remove improper data processing
IF @ProcessDataRemovalCheck = 0	AND @BatchSizeCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Request to process data does not exists, but a batchsize is present, please check inputs and resubmit.'
	RAISERROR (@message,0,1) with NOWAIT  

	RETURN



END










-- Proper logic for processing
IF @ProcessDataRemovalCheck = 1	AND @BatchSizeCheck = 1 
BEGIN

-- Building Result Set
SET @message = ' '
RAISERROR (@message,0,1) with NOWAIT  
RAISERROR (@message,0,1) with NOWAIT  



SET @message = 'Organization Name      ' + @OrganizationName
RAISERROR (@message,0,1) with NOWAIT  


SET @message = 'Organization Id        ' + CAST( @OrganizationObjectId   as varchar )
RAISERROR (@message,0,1) with NOWAIT  


SET @message = ' '
RAISERROR (@message,0,1) with NOWAIT  


SET @message = 'Delete Table Counts    '
RAISERROR (@message,0,1) with NOWAIT  





-- SurveyResponse
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse		
CREATE TABLE #OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
	(
		RowId						BigInt	Identity ( 1, 1 )
		, SurveyResponseObjectId	BigInt
		
	)		








-- SurveyResponse
INSERT INTO #OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse ( SurveyResponseObjectId )
SELECT
		TOP ( @BatchSize )
		t10.objectId		AS SurveyResponseObjectId		
FROM
		SurveyResponse		t10
	JOIN
		Survey				t20
			ON t10.surveyObjectId = t20.objectId AND t20.organizationObjectId = @OrganizationObjectId

--ORDER BY
--		t10.ObjectId ASC








-- Comment
IF OBJECT_ID('tempdb..#OrgSurveyDataRemoval_ProcessDataRemoval_Comment') IS NOT NULL			DROP TABLE #OrgSurveyDataRemoval_ProcessDataRemoval_Comment		
CREATE TABLE #OrgSurveyDataRemoval_ProcessDataRemoval_Comment
	(
		RowId						Int	Identity ( 1, 1 )
		, CommentObjectId			Int
		
	)		








-- Comment
INSERT INTO #OrgSurveyDataRemoval_ProcessDataRemoval_Comment ( CommentObjectId )
SELECT
		objectId		
FROM
		Comment	
WHERE
		SurveyResponseAnswerObjectId IN	
										( 
											SELECT	
													ObjectId
											FROM
													SurveyResponseAnswer
											WHERE
													SurveyResponseObjectId IN 	( 
																					SELECT 
																							SurveyResponseObjectId
																					FROM 
																							#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse 
																				)
										)	








-- TermAnnotation
SET @TermAnnotationCount		= 	( 
										SELECT
												COUNT(1)
										FROM
												TermAnnotation
										WHERE
												CommentId 	IN	( 
																	SELECT	
																			CommentObjectId
																	FROM
																			#OrgSurveyDataRemoval_ProcessDataRemoval_Comment
																)	
									)

							
SET @message = 'TermAnnotation         ' + REPLACE(CONVERT(varchar(20), (CAST( @TermAnnotationCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- TagAnnotation
SET @TagAnnotationCount	 		= 	( 
										SELECT
												COUNT(1)
										FROM
												TagAnnotation
										WHERE
												CommentId 	IN	( 
																		SELECT	
																				CommentObjectId
																		FROM
																				#OrgSurveyDataRemoval_ProcessDataRemoval_Comment
																	)	
									)

SET @message = 'TagAnnotation          ' + REPLACE(CONVERT(varchar(20), (CAST( @TagAnnotationCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  






-- CommentAccess
SET @CommentAccessCount		= 
								( 
									SELECT
											COUNT(1)		
									FROM
											CommentAccess
									WHERE
											CommentObjectId IN	( 
																		SELECT	
																				CommentObjectId
																		FROM
																				#OrgSurveyDataRemoval_ProcessDataRemoval_Comment
																	)
								 )

SET @message = 'CommentAccess          ' + REPLACE(CONVERT(varchar(20), (CAST( @CommentAccessCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  






-- SurveyResponseNote
SET @SurveyResponseNoteCount	= 
									( 
										SELECT
												COUNT(1)	
										FROM
												SurveyResponseNote
										WHERE
												SurveyResponseObjectId IN	
																			( 
																				SELECT	
																						SurveyResponseObjectId
																				FROM
																						#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																			)	
									)

SET @message = 'SurveyResponseNote     ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseNoteCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- ResponseTag
SET @ResponseTagCount		= 
								( 
									SELECT
											COUNT(1)	
									FROM
											ResponseTag	
									WHERE
											ResponseObjectId IN	
																( 
																	SELECT	
																			SurveyResponseObjectId
																	FROM
																			#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																)	
								)

SET @message = 'ResponseTag            ' + REPLACE(CONVERT(varchar(20), (CAST( @ResponseTagCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- SurveyRequestParam
SET @SurveyRequestParamCount			= 
											(
												SELECT
														COUNT(1)
												FROM
														SurveyRequestParam
												WHERE
														SurveyRequestObjectId IN
																				( 
																					SELECT
																							ObjectId		
																					FROM
																							SurveyRequest
																					WHERE
																							SurveyResponseObjectId IN	
																														( 
																															SELECT	
																																	SurveyResponseObjectId
																															FROM
																																	#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																														)	
																				)
											)											

SET @message = 'SurveyRequestParam     ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyRequestParamCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- SurveyRequest
SET @SurveyRequestCount			= 
									( 
										SELECT
												COUNT(1)		
										FROM
												SurveyRequest
										WHERE
												SurveyResponseObjectId IN	
																			( 
																				SELECT	
																						SurveyResponseObjectId
																				FROM
																						#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																			)	
									)

SET @message = 'SurveyRequest          ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyRequestCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- SurveyResponseAlert
SET @SurveyResponseAlertCount		= 
										( 

											SELECT
													COUNT(1)		
											FROM
													SurveyResponseAlert	
											WHERE
													SurveyResponseObjectId IN	
																				( 
																					SELECT	
																							SurveyResponseObjectId
																					FROM
																							#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																				)	
										)

SET @message = 'SurveyResponseAlert    ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseAlertCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- Comment Count
SET @CommentCount		= 	( SELECT MAX( RowId )	FROM #OrgSurveyDataRemoval_ProcessDataRemoval_Comment )

SET @CommentCount		= CASE	WHEN @CommentCount IS NULL 	THEN 0
								WHEN @CommentCount = 0 		THEN 0
								ELSE @CommentCount
							END
													



SET @message = 'Comment                ' + REPLACE(CONVERT(varchar(20), (CAST( @CommentCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- SurveyResponseScore
SET @SurveyResponseScoreCount		= 
										(
											SELECT
													COUNT(1)	
											FROM
													SurveyResponseScore	
											WHERE
													SurveyResponseObjectId IN	
																				( 
																					SELECT	
																							SurveyResponseObjectId
																					FROM
																							#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																				)	
										)

SET @message = 'SurveyResponseScore    ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseScoreCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- SurveyResponseAnswer
SET @SurveyResponseAnswerCount		= 
										( 
											SELECT
													COUNT(1)		
											FROM
													SurveyResponseAnswer
											WHERE
													SurveyResponseObjectId IN	
																				( 
																					SELECT	
																							SurveyResponseObjectId
																					FROM
																							#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																				)	
										)

SET @message = 'SurveyResponseAnswer   ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseAnswerCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  








-- SurveyResponse Count
SET @SurveyResponseCount	= ( SELECT MAX( RowId )	FROM #OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse )

SET @message = 'SurveyResponse         ' + REPLACE(CONVERT(varchar(20), (CAST( @SurveyResponseCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  















/**************  Warning Actual Data Removal Section  **************/

BEGIN

	SET @message = ''
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'Starting Data Removal Using Batch Sizes ' + CAST( @BatchSize  as varchar )
	RAISERROR (@message,0,1) with NOWAIT  



	/*****   Must use Batching on every table so as to keep from having a run away blocking delete  *****/


	-- TermAnnotation Delete
	IF @TermAnnotationCount > 0
	BEGIN
		
			-- Deletes TermAnnotation in batches
			SET @message = 'TermAnnotation delete count this batch ' + CAST( @TermAnnotationCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
			
					TermAnnotation 		WITH ( ROWLOCK )	
			WHERE
					CommentId IN ( SELECT CommentObjectId FROM #OrgSurveyDataRemoval_ProcessDataRemoval_Comment )


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

		
	END
	
	
	-- TagAnnotation Delete
	IF @TagAnnotationCount > 0
	BEGIN
	
			-- Deletes TagAnnotation in batches
			SET @message = 'TagAnnotation delete count this batch ' + CAST( @TagAnnotationCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					TagAnnotation 		WITH ( ROWLOCK )	
			WHERE
					CommentId IN ( SELECT CommentObjectId FROM #OrgSurveyDataRemoval_ProcessDataRemoval_Comment )


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

		
	END
	
	
	
	
	
	
	-- CommentAccess Delete
	IF @CommentAccessCount > 0
	BEGIN
	
			-- Deletes CommentAccess in batches
			SET @message = 'CommentAccess delete count this batch ' + CAST( @CommentAccessCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					CommentAccess 		WITH ( ROWLOCK )	
			WHERE
					CommentObjectId IN ( SELECT CommentObjectId FROM #OrgSurveyDataRemoval_ProcessDataRemoval_Comment )


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT


	END







	-- SurveyResponseNote Delete
	IF @SurveyResponseNoteCount > 0
	BEGIN
	
			-- Deletes SurveyResponseNote in batches
			SET @message = 'SurveyResponseNote delete count this batch ' + CAST( @SurveyResponseNoteCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					SurveyResponseNote 		WITH ( ROWLOCK )	
			WHERE
					SurveyResponseObjectId IN	
												( 
													SELECT	
															SurveyResponseObjectId
													FROM
															#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
												)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END






	
	-- ResponseTag Delete
	IF @ResponseTagCount > 0
	BEGIN
	
			-- Deletes ResponseTag in batches
			SET @message = 'ResponseTag delete count this batch ' + CAST( @ResponseTagCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					ResponseTag 		WITH ( ROWLOCK )	
			WHERE
					ResponseObjectId IN	
												( 
													SELECT	
															SurveyResponseObjectId
													FROM
															#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
												)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END	


	
	
	-- SurveyRequestParam Delete
	IF @SurveyRequestParamCount > 0
	BEGIN
	
			-- Deletes SurveyRequestParam in batches
			SET @message = 'SurveyRequestParam delete count this batch ' + CAST( @SurveyRequestParamCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					SurveyRequestParam 		WITH ( ROWLOCK )	
			WHERE
					SurveyRequestObjectId IN
													( 
														SELECT
																ObjectId		
														FROM
																SurveyRequest
														WHERE
																SurveyResponseObjectId IN	
																							( 
																								SELECT	
																										SurveyResponseObjectId
																								FROM
																										#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
																							)	
													)


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END	
	



	
	-- SurveyRequest Delete
	IF @SurveyRequestCount > 0
	BEGIN
	
			-- Deletes SurveyRequest in batches
			SET @message = 'SurveyRequest delete count this batch ' + CAST( @SurveyRequestCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					SurveyRequest 		WITH ( ROWLOCK )	
			WHERE
					SurveyResponseObjectId IN	
												( 
													SELECT	
															SurveyResponseObjectId
													FROM
															#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
												)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END	







	
	-- SurveyResponseAlert Delete
	IF @SurveyResponseAlertCount > 0
	BEGIN
	
			-- Deletes SurveyResponseAlert in batches
			SET @message = 'SurveyResponseAlert delete count this batch ' + CAST( @SurveyResponseAlertCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					SurveyResponseAlert 		WITH ( ROWLOCK )	
			WHERE
					SurveyResponseObjectId IN	
												( 
													SELECT	
															SurveyResponseObjectId
													FROM
															#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
												)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END






	-- Comment Delete; note comment must come after CommentAccess delete
	IF @CommentCount > 0
	BEGIN
	
			-- Deletes Comment in batches
			SET @message = 'Comment delete count this batch ' + CAST( @CommentCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					Comment 		WITH ( ROWLOCK )	
			WHERE
					SurveyResponseAnswerObjectId IN	
													( 
														SELECT	
																ObjectId
														FROM
																SurveyResponseAnswer
														WHERE
																SurveyResponseObjectId IN 	
																							( 
																								SELECT 
																										SurveyResponseObjectId
																								FROM 
																										#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse 
																							)
													)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END









	
	
	-- SurveyResponseScore Delete
	IF @SurveyResponseScoreCount > 0
	BEGIN
	
			-- Deletes SurveyResponseScore in batches
			SET @message = 'SurveyResponseScore delete count this batch ' + CAST( @SurveyResponseScoreCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					SurveyResponseScore 		WITH ( ROWLOCK )	
			WHERE
					SurveyResponseObjectId IN	
												( 
													SELECT	
															SurveyResponseObjectId
													FROM
															#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
												)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END







	
	
	
	
	
	-- SurveyResponseAnswer Delete
	IF @SurveyResponseAnswerCount > 0
	BEGIN
	
			-- Deletes SurveyResponseAnswer in batches
			SET @message = 'SurveyResponseAnswer delete count this batch ' + CAST( @SurveyResponseAnswerCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			DELETE 
					TOP ( @BatchSize * @SubtableMultiplier )
			FROM	
					SurveyResponseAnswer 		WITH ( ROWLOCK )	
			WHERE
					SurveyResponseObjectId IN	
												( 
													SELECT	
															SurveyResponseObjectId
													FROM
															#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
												)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT

	END

	
	

	
	
	
	-- SurveyResponse Delete
	IF @SurveyResponseCount > 0
	BEGIN
	
			-- Deletes SurveyResponse in batches
			SET @message = 'SurveyResponse delete count this batch ' + CAST( @SurveyResponseCount as varchar )
			RAISERROR (@message,0,1) with NOWAIT  


			SET @StartDelete	= GETDATE()


			/*********  Warning  *********/
			-- The correct TR_SurveyResponse_AFTER_DELETE may need to be coppied from Prod Doctor.OLTP
			DELETE 
					TOP ( @BatchSize )
			FROM					
					SurveyResponse 		WITH ( ROWLOCK )	
			WHERE
					ObjectId IN	
									( 
										SELECT	
												SurveyResponseObjectId
										FROM
												#OrgSurveyDataRemoval_ProcessDataRemoval_SurveyResponse
									)	


			SET @EndDelete		= GETDATE()


			-- Exits to reduce table locking
			GOTO COMPLETED_TABLE_EXIT


	END




COMPLETED_TABLE_EXIT:

SET @DeleteDuration		= ( SELECT DATEDIFF( SECOND, @StartDelete, @EndDelete ) )
	
SET @message = ''
RAISERROR (@message,0,1) with NOWAIT  

SET @message = 'This batch of survey data removal has completed'
RAISERROR (@message,0,1) with NOWAIT  

SET @message = ''
RAISERROR (@message,0,1) with NOWAIT  
RAISERROR (@message,0,1) with NOWAIT  
	

SET @message = 'Delete Duration Seconds:      ' + CAST( @DeleteDuration  as varchar )
RAISERROR (@message,0,1) with NOWAIT  



END


END


-- Clean up
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
