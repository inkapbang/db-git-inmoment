SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_TranslationsImport_AutoDelivery]
	@DisplayInfo		int 			= 1
	, @ShowChecks		int 			= 0
	
	, @DeliveryEmail	varchar(100)	= NULL
	, @FileName			varchar(255) 	= NULL
	
	, @Answer			varchar(10)		= NULL		
	, @Throttle			int 			= 1
	

AS
/**********************************  Translation Import   **********************************

		Translated labels, names, context, description, text, etc.
		Inserts new values into localizedStringValue
		Update existing values to new values if needed


		
		NOTE: from excel save file as unicode text then upload as normal.
		
		History
			10.08.2014	Tad Peterson
				-- started
		
			
			
*******************************************************************************************/
SET NOCOUNT ON


-- For use with RAISERROR
DECLARE @message	nvarchar(200)

DECLARE @answerCheck						int
SET		@answerCheck						= CASE	WHEN @answer IS NULL 		THEN 0
													WHEN @answer = 'EXECUTE'	THEN 1
												ELSE 2
												END

DECLARE @deliveryEmailCheck					int
SET		@deliveryEmailCheck					= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
													WHEN LEN(@deliveryEmail) = 0	THEN 0
													WHEN LEN(@deliveryEmail) > 0	THEN 1
												END
									


									
									
DECLARE @DisplayInfoCheck					int
DECLARE @ShowChecksCheck					int
DECLARE @FileNameCheck						int
DECLARE @ThrottleCheck						int



SET		@DisplayInfoCheck					= CASE	WHEN @DisplayInfo	= 1					THEN 1							ELSE 0		END
SET		@ShowChecksCheck					= CASE	WHEN @ShowChecks	= 1					THEN 1							ELSE 0		END

SET		@FileNameCheck						= CASE	WHEN LEN(@FileName) IS NULL 			THEN 0
													WHEN LEN(@FileName) = 0					THEN 0
													WHEN LEN(@FileName) > 0					THEN 1
												END

SET		@ThrottleCheck						= CASE	WHEN @throttle IS NULL			THEN 1
													WHEN @throttle = 0 				THEN 0
													ELSE 1
												END



-- These are used for throttling														
DECLARE @check								int

												
												
IF @answerCheck = 1
BEGIN
	GOTO PROCESSING									
END



IF @answerCheck = 2
BEGIN

	PRINT 'Terminating Script'
	PRINT ''

	
GOTO CLEANUP
END												
												
												

-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC sp_TranslationsImport_AutoDelivery'
	PRINT N'	@DisplayInfo			   = 0'
	PRINT N'    , @ShowChecks			   = 0'	
	PRINT N'	, @DeliveryEmail           = ''tpeterson@InMoment.com'''	
	PRINT N'	, @FileName                = ''GiantTiger_Import.txt'''
	
	PRINT N'    , @Throttle			       = 1'	
	PRINT N' '
	PRINT N' '


	RETURN

	
END








-- Enables input checking
IF @ShowChecksCheck = 1
BEGIN
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  



	SELECT

			@DisplayInfoCheck					AS DisplayInfoCheck
			, @DisplayInfo						AS DisplayInfo
	
			, @ShowChecksCheck					AS ShowChecksCheck
			, @ShowChecks						AS ShowChecks
			
			, @DeliveryEmailCheck				AS DeliveryEmailCheck
			, @DeliveryEmail					AS DeliveryEmail
			
			, @FileNameCheck					AS FileNameCheck
			, @FileName							AS FileName

			, @ThrottleCheck					AS ThrottleCheck
			, @Throttle							AS Throttle
			
			
END









-- Prep
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Upload') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_Upload		
CREATE TABLE ##CompanyTranslatedFields_Upload
	(
		LocalizedStringObjectId			int
		, LocaleKey						nvarchar(25)
		, Value							nvarchar(max)
		
	)


	
	
-- Loads file	
DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##CompanyTranslatedFields_Upload   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''\t'',  DATAFILETYPE =	''widechar''   )'


EXECUTE (@FileNameBulkInsertStatement)

	
	
	
	
	
-- Testing	
--SELECT *	FROM ##CompanyTranslatedFields_Upload
	
	
	
	

-- File size info
DECLARE	@originalFileSize	int
SET 	@originalFileSize	=	( SELECT count(1)	FROM ##CompanyTranslatedFields_Upload	)





DECLARE @nullCount			int
SET		@nullCount			= 
								( 
									SELECT 
											COUNT(1)
									FROM 
											##CompanyTranslatedFields_Upload	
									WHERE 
											LocalizedStringObjectId		IS NULL	
										OR
											LocaleKey					IS NULL
										OR
											Value						IS NULL				 
								)


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE 
				t10
	FROM 
			##CompanyTranslatedFields_Upload	t10	
	WHERE 
			LocalizedStringObjectId		IS NULL	
		OR
			LocaleKey					IS NULL
		OR
			Value						IS NULL				 
			
END			




-- Validates LocalizedStringObjectId
DECLARE @notLegitLocalizedStringObjectId	int
SET		@notLegitLocalizedStringObjectId	=
												(
													SELECT
															COUNT(1)
													FROM
															##CompanyTranslatedFields_Upload	t10
														LEFT JOIN
															LocalizedStringValue				t20
																ON t10.LocalizedStringObjectId = t20.LocalizedStringObjectId
													WHERE
															t20.LocalizedStringObjectId IS NULL
												)




-- Testing
-- SELECT @notLegitLocalizedStringObjectId



-- Non legit LocalizedStringObjectId; preserved and deleted 
IF @notLegitLocalizedStringObjectId > 0
BEGIN
	
	IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NotLegitLocalizedStringObjectId') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_NotLegitLocalizedStringObjectId		
	SELECT
			t10.LocalizedStringObjectId
			, t10.LocaleKey
			, t10.Value
			
	INTO 	##CompanyTranslatedFields_NotLegitLocalizedStringObjectId
			
	FROM
			##CompanyTranslatedFields_Upload	t10
		LEFT JOIN
			LocalizedStringValue				t20
				ON t10.LocalizedStringObjectId = t20.LocalizedStringObjectId
	WHERE
			t20.LocalizedStringObjectId IS NULL
			
			
			
	-- Delete Step
	DELETE	
			t10
	FROM
			##CompanyTranslatedFields_Upload							t10
		JOIN
			##CompanyTranslatedFields_NotLegitLocalizedStringObjectId	t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value
			


END



-- Testing
-- SELECT * FROM ##CompanyTranslatedFields_NotLegitLocalizedStringObjectId









-- Validates LegitLocaleKey
DECLARE @notLegitLocaleKey				int
SET		@notLegitLocaleKey				=
											(
												SELECT
														COUNT(1)
												FROM
														##CompanyTranslatedFields_Upload	t10
													LEFT JOIN
														Locale								t20
															ON t10.LocaleKey = t20.LocaleKey
												WHERE
														t20.ObjectId IS NULL
											)





-- Non legit LocaleKey; preserved and deleted 
IF @notLegitLocaleKey > 0
BEGIN
	
	IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NotLegitLocaleKey') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_NotLegitLocaleKey		
	SELECT
			t10.LocalizedStringObjectId
			, t10.LocaleKey
			, t10.Value
			
	INTO 	##CompanyTranslatedFields_NotLegitLocaleKey
			
	FROM
			##CompanyTranslatedFields_Upload	t10
		LEFT JOIN
			Locale								t20
				ON t10.LocaleKey = t20.LocaleKey
	WHERE
			t20.ObjectId IS NULL
			
			
			
	-- Delete Step
	DELETE	
			t10
	FROM
			##CompanyTranslatedFields_Upload				t10
		JOIN
			##CompanyTranslatedFields_NotLegitLocaleKey		t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value

END




-- Testing
-- SELECT *	FROM ##CompanyTranslatedFields_NotLegitLocaleKey	








-- Duplicate data section
DECLARE @Duplicates				int
SET		@Duplicates				=
											(
												SELECT
														COUNT(1)
												FROM
														(													
															SELECT 
																	LocalizedStringObjectId	
																	, localeKey
																	, value

															FROM 
																	##CompanyTranslatedFields_Upload
																	
															GROUP BY 	
																	LocalizedStringObjectId
																	, LocaleKey
																	, Value	
															HAVING 
																	COUNT(1) > 1
														)	AS t10								
											)


-- Removal duplicate
IF @Duplicates > 0
BEGIN

		-- Creates duplicates table
		IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Duplicates') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_Duplicates				
		SELECT 
				LocalizedStringObjectId	
				, localeKey
				, value
				
		INTO	##CompanyTranslatedFields_Duplicates				

		FROM 
				##CompanyTranslatedFields_Upload
				
		GROUP BY 	
				LocalizedStringObjectId
				, LocaleKey
				, Value	
		HAVING 
				COUNT(1) > 1
		


		-- Removes duplicates upload table
		DELETE 
				t10
		FROM
				##CompanyTranslatedFields_Upload		t10
			JOIN
				##CompanyTranslatedFields_Duplicates	t20
						ON 
								t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
							AND	
								t10.LocaleKey					= t20.LocaleKey
							AND 
								t10.Value						= t20.Value




		-- Puts single version of duplicates back INTO original table
		INSERT INTO ##CompanyTranslatedFields_Upload
		SELECT 
				LocalizedStringObjectId
				, LocaleKey
				, Value
		FROM
				##CompanyTranslatedFields_Duplicates





END



-- Testing
-- SELECT * FROM  ##CompanyTranslatedFields_Duplicates





-- Exists data section
DECLARE @CompanyTranslatedFields_Exists				int
SET		@CompanyTranslatedFields_Exists				=
														(
															SELECT
																	COUNT(1)
															FROM
																	##CompanyTranslatedFields_Upload		t10
																JOIN
																	LocalizedStringValue					t20
																		ON 
																				t10.LocalizedStringObjectId = t20.LocalizedStringObjectId
																			AND
																				t10.LocaleKey = t20.LocaleKey
																			AND
																				t10.Value = t20.Value

														)



IF @CompanyTranslatedFields_Exists > 0
BEGIN
	IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Exists') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_Exists
	SELECT
			t10.LocalizedStringObjectId
			, t10.LocaleKey
			, t10.Value
			, t20.Value		AS Value_Old
	INTO	##CompanyTranslatedFields_Exists
	FROM
			##CompanyTranslatedFields_Upload		t10
		JOIN
			LocalizedStringValue					t20
				ON 
						t10.LocalizedStringObjectId = t20.LocalizedStringObjectId
					AND
						t10.LocaleKey = t20.LocaleKey
					AND
						t10.Value = t20.Value


	-- Delete Step
	DELETE	
			t10
	FROM
			##CompanyTranslatedFields_Upload				t10
		JOIN
			##CompanyTranslatedFields_Exists		t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value


END










-- Conflicting Values
DECLARE @CompanyTranslatedFields_ConflictingValues		int
SET 	@CompanyTranslatedFields_ConflictingValues		=
															(
																SELECT
																		COUNT(1)
																FROM
																		(													
																			SELECT 
																					LocalizedStringObjectId	
																					, localeKey

																			FROM 
																					##CompanyTranslatedFields_Upload
																					
																			GROUP BY 	
																					LocalizedStringObjectId
																					, LocaleKey
																					
																			HAVING 
																					COUNT(1) > 1
																		)	AS t10								
															)



															
IF @CompanyTranslatedFields_ConflictingValues > 0
BEGIN
		-- Creates ConflictingValues table
		IF OBJECT_ID('tempdb..##CompanyTranslatedFields_ConflictingValues') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_ConflictingValues	
		SELECT
				t10.LocalizedStringObjectId
				, t10.LocaleKey
				, t10.Value
				
		INTO	##CompanyTranslatedFields_ConflictingValues				
				
		FROM
				##CompanyTranslatedFields_Upload		t10
			JOIN
				(
					SELECT 
							LocalizedStringObjectId	
							, localeKey
							
					FROM 
							##CompanyTranslatedFields_Upload
							
					GROUP BY 	
							LocalizedStringObjectId
							, LocaleKey
					HAVING 
							COUNT(1) > 1
							
				)	AS t20	
						ON 
								t10.LocalizedStringObjectId = t20.LocalizedStringObjectId
							AND
								t10.LocaleKey				= t20.LocaleKey
							

				

		-- Removes conflicting values from upload table
		DELETE 
				t10
		FROM
				##CompanyTranslatedFields_Upload				t10
			JOIN
				##CompanyTranslatedFields_ConflictingValues		t20
						ON 
								t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
							AND	
								t10.LocaleKey					= t20.LocaleKey



END



-- Testing
-- SELECT * FROM  ##CompanyTranslatedFields_ConflictingValues	












-- Needs to be updated
DECLARE @CompanyTranslatedFields_NeedsUpdate	int
SET		@CompanyTranslatedFields_NeedsUpdate	=
														(
															SELECT
																	COUNT(1)
															FROM
																	##CompanyTranslatedFields_Upload	t10
																JOIN
																	LocalizedStringValue				t20
																		ON 
																				t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
																			AND
																				t10.LocaleKey					= t20.LocaleKey
																			AND
																				t10.Value						!= t20.Value
														)

														

IF @CompanyTranslatedFields_NeedsUpdate > 0
BEGIN

	IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NeedsUpdate') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_NeedsUpdate		
	SELECT
			t10.LocalizedStringObjectId
			, t10.LocaleKey
			, t10.Value
			, t20.Value			AS Value_Old
			
	INTO 	##CompanyTranslatedFields_NeedsUpdate
			
	FROM
			##CompanyTranslatedFields_Upload	t10
		JOIN
			LocalizedStringValue				t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						!= t20.Value
			
			
			
	-- Delete Step
	DELETE	
			t10
	FROM
			##CompanyTranslatedFields_Upload		t10
		JOIN
			##CompanyTranslatedFields_NeedsUpdate	t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value
			



END









														

-- Needs to be inserted
DECLARE @CompanyTranslatedFields_NeedsInsert 	int
SET 	@CompanyTranslatedFields_NeedsInsert	=
													(
														SELECT
																COUNT(1)
														FROM
																##CompanyTranslatedFields_Upload	t10
															LEFT JOIN
																LocalizedStringValue				t20
																	ON 
																			t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
																		AND
																			t10.LocaleKey					= t20.LocaleKey
																		AND
																			t10.Value						= t20.Value
														WHERE
																t20.LocalizedStringObjectId IS NULL


													)



IF @CompanyTranslatedFields_NeedsInsert > 0
BEGIN

	IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NeedsInsert') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_NeedsInsert		
	SELECT
			t10.LocalizedStringObjectId
			, t10.LocaleKey
			, t10.Value
			
	INTO	##CompanyTranslatedFields_NeedsInsert	
	
	FROM
			##CompanyTranslatedFields_Upload	t10
		LEFT JOIN
			LocalizedStringValue				t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value
	WHERE
			t20.LocalizedStringObjectId IS NULL


			
			
			
	-- Delete Step
	DELETE	
			t10
	FROM
			##CompanyTranslatedFields_Upload		t10
		JOIN
			##CompanyTranslatedFields_NeedsInsert	t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value
			


END





-- Unidentified records
DECLARE @CompanyTranslatedFields_Unidentified 	int
SET 	@CompanyTranslatedFields_Unidentified	=
													(
														SELECT
																COUNT(1)
														FROM
																##CompanyTranslatedFields_Upload	t10
													)








IF @CompanyTranslatedFields_Unidentified > 0
BEGIN

	IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Unidentified') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_Unidentified		
	SELECT
			t10.LocalizedStringObjectId
			, t10.LocaleKey
			, t10.Value
			
	INTO	##CompanyTranslatedFields_Unidentified	
	
	FROM
			##CompanyTranslatedFields_Upload	t10


			
			
			
	-- Delete Step
	DELETE	
			t10
	FROM
			##CompanyTranslatedFields_Upload		t10
		JOIN
			##CompanyTranslatedFields_Unidentified	t20
				ON 
						t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
					AND
						t10.LocaleKey					= t20.LocaleKey
					AND
						t10.Value						= t20.Value
			


END








-- Removes original table so no accidental things happen
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Upload') IS NOT NULL				DROP TABLE ##CompanyTranslatedFields_Upload		




IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Statistics') IS NOT NULL			DROP TABLE ##CompanyTranslatedFields_Statistics
CREATE TABLE ##CompanyTranslatedFields_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitLocalizedStringObjectId						int
		, notLegitLocaleKey										int
		, Duplicates											int
		, CompanyTranslatedFields_Exists						int
		, CompanyTranslatedFields_ConflictingValues				int
		, CompanyTranslatedFields_NeedsUpdate					int
		, CompanyTranslatedFields_NeedsInsert					int
		, CompanyTranslatedFields_Unidentified					int
		, throttle												int		
		, processingStart										dateTime
		, processingComplete									dateTime

	)		


INSERT INTO ##CompanyTranslatedFields_Statistics 
( 
	DeliveryEmail
	, inputFileName
	, serverName
	, originalCount
	, nullCount
	, notLegitLocalizedStringObjectId
	, notLegitLocaleKey
	, Duplicates
	, CompanyTranslatedFields_Exists
	, CompanyTranslatedFields_ConflictingValues
	, CompanyTranslatedFields_NeedsUpdate
	, CompanyTranslatedFields_NeedsInsert
	, CompanyTranslatedFields_Unidentified
	, Throttle 
)	
SELECT 
	@DeliveryEmail
	, @FileName
	, @@SERVERNAME
	, @OriginalFileSize
	, @nullCount
	, @notLegitLocalizedStringObjectId
	, @notLegitLocaleKey
	, @Duplicates
	, @CompanyTranslatedFields_Exists
	, @CompanyTranslatedFields_ConflictingValues
	, @CompanyTranslatedFields_NeedsUpdate
	, @CompanyTranslatedFields_NeedsInsert
	, @CompanyTranslatedFields_Unidentified
	, @Throttle







	
-- Results Print Out
PRINT ''
PRINT ''
PRINT 'Translated Fields Import Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   							AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   									AS money)), 1), '.00', '')
PRINT 'Non Legit LocalizedString Id             :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitLocalizedStringObjectId				AS money)), 1), '.00', '')
PRINT 'Non Legit Locale Key                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitLocaleKey								AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@Duplicates   								AS money)), 1), '.00', '')
PRINT 'Records With Conflicting Values          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@CompanyTranslatedFields_ConflictingValues   	AS money)), 1), '.00', '')
PRINT 'Records Already Exists                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@CompanyTranslatedFields_Exists   				AS money)), 1), '.00', '')
PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@CompanyTranslatedFields_NeedsUpdate   			AS money)), 1), '.00', '')
PRINT 'Records Needing Insert                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@CompanyTranslatedFields_NeedsInsert   			AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@CompanyTranslatedFields_Unidentified   		AS money)), 1), '.00', '')




PRINT ''
PRINT 'Throttled                                :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                  AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_TranslationsImport_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_TranslationsImport_AutoDelivery	@answer = ''terminate'''

RETURN


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	






--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM ##CompanyTranslatedFields_Statistics )
SET		@check			=	( 
								SELECT 
										MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
								FROM 
										PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf
								WHERE
										--CurrentAsOf IS NOT NULL
										ReportingEnabled 	= 1
									AND
										Eligible 			= 1
							)



					


IF @answerCheck = 1
BEGIN
	
	-- Update Check
	DECLARE @ImportUpdateCheck		int
	SET		@ImportUpdateCheck		= ( SELECT CompanyTranslatedFields_NeedsUpdate		FROM ##CompanyTranslatedFields_Statistics )
	

	-- Insert Check
	DECLARE @ImportInsertCheck		int
	SET		@ImportInsertCheck		= ( SELECT CompanyTranslatedFields_NeedsInsert		FROM ##CompanyTranslatedFields_Statistics )


	UPDATE	##CompanyTranslatedFields_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @ImportUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@ImportUpdateCheck AS varchar) + ' records'




		/**************  Comnpany Translated Field Update  **************/


		DECLARE @count bigint, @LocalizedStringObjectId bigint, @LocaleKey nvarchar(25), @Value nvarchar(max)
		SET @count = 0

		DECLARE mycursor Cursor for
		SELECT LocalizedStringObjectId, LocaleKey, Value FROM ##CompanyTranslatedFields_NeedsUpdate

		OPEN mycursor
		FETCH next FROM mycursor INTO @LocalizedStringObjectId, @LocaleKey, @Value

		WHILE @@Fetch_Status=0
		BEGIN
			  
		PRINT cast(@count as varchar)+', '+cast(@LocalizedStringObjectId as varchar)+', '+cast(@localeKey as varchar)+', '+ @value


		----*******************  W A R N I N G  ***************************

		
		
		UPDATE 
				LocalizedStringValue	WITH ( ROWLOCK )
		SET
				Value = @Value
		WHERE
				LocalizedStringObjectId = @LocalizedStringObjectId
			AND
				LocaleKey = @LocaleKey	
						
		

		----***************************************************************
		
		
		-- Slows down the cursor
		IF @ThrottleCheck != 0
		BEGIN
			WAITFOR DELAY '00:00:00.001'
		END


		-- Keeps larger files from running away
		IF @ThrottleCheck != 0
		BEGIN
			SET		@check	=	( 
									SELECT 
											MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
									FROM 
											PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf
									WHERE
											--CurrentAsOf IS NOT NULL
											ReportingEnabled 	= 1
										AND
											Eligible 			= 1
								)	

			-- 2.5 min behind
			WHILE @check >= 180
			BEGIN
				
				-- Print results			
				SET @message = 'Waiting for another 1 minute, max current delay is ' + CAST( -@check as varchar )
				RAISERROR (@message,0,1) with NOWAIT

				
				WAITFOR DELAY '00:01:00'

				SET		@check	=	( 
										SELECT 
												MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
										FROM 
												PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf
										WHERE
												--CurrentAsOf IS NOT NULL
												ReportingEnabled 	= 1
											AND
												Eligible 			= 1
									)	
			END
		END



		SET @count = @count + 1
		FETCH next FROM mycursor INTO @LocalizedStringObjectId, @LocaleKey, @Value

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@count as varchar)+' Records Processed'

		/**************************************************************************************************/




		
		
		PRINT ''			
		PRINT 'Update Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Updates'
		
		DECLARE @successfulUpdates		int
		SET		@successfulUpdates		= ( 
												SELECT 
														COUNT(1)
												FROM 
														##CompanyTranslatedFields_NeedsUpdate	t10		
													JOIN 
														LocalizedStringValue					t20	WITH (NOLOCK) 
															ON	
																	t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
																AND
																	t10.LocaleKey					= t20.LocaleKey
																AND
																	t10.Value						= t20.Value
											)


		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST( @ImportUpdateCheck AS varchar ) + ' Successful: ' + CAST( @successfulUpdates as varchar )
		PRINT ''
		PRINT ''
	
		
	END












	--If statements for Cursors Here
	IF @ImportInsertCheck > 0
	BEGIN



	
		PRINT 'Inserting ' + CAST( @ImportInsertCheck AS varchar) + ' records'




		/**************  Comnpany Translated Field Update  **************/

		
		DECLARE @countV2 bigint, @LocalizedStringObjectIdV2 bigint, @LocaleKeyV2 nvarchar(25), @ValueV2 nvarchar(max)
		
		SET @countV2 = 0

		DECLARE mycursor Cursor for
		SELECT LocalizedStringObjectId, LocaleKey, Value FROM ##CompanyTranslatedFields_NeedsInsert

		OPEN mycursor
		FETCH next FROM mycursor INTO @LocalizedStringObjectIdV2, @LocaleKeyV2, @ValueV2

		WHILE @@Fetch_Status=0
		BEGIN
			  
		PRINT cast( @countV2 as varchar )+', '+cast( @LocalizedStringObjectIdV2 as varchar )+ ', ' + cast( @localeKeyV2 as varchar ) + ', ' + @valueV2


		----*******************  W A R N I N G  ***************************

		
		INSERT INTO LocalizedStringValue	WITH ( ROWLOCK )	( LocalizedStringObjectId, LocaleKey, Value )
		SELECT @LocalizedStringObjectIdV2, @LocaleKeyV2, @ValueV2
						

		----***************************************************************
		
		
		-- Slows down the cursor
		IF @ThrottleCheck != 0
		BEGIN
			WAITFOR DELAY '00:00:00.001'
		END


		-- Keeps larger files from running away
		IF @ThrottleCheck != 0
		BEGIN
			SET		@check	=	( 
									SELECT 
											MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
									FROM 
											PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf
									WHERE
											--CurrentAsOf IS NOT NULL
											ReportingEnabled 	= 1
										AND
											Eligible 			= 1
								)	

			-- 2.5 min behind
			WHILE @check >= 180
			BEGIN
				
				-- Print results			
				SET @message = 'Waiting for another 1 minute, max current delay is ' + CAST( -@check as varchar )
				RAISERROR (@message,0,1) with NOWAIT

				
				WAITFOR DELAY '00:01:00'

				SET		@check	=	( 
										SELECT 
												MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
										FROM 
												PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf
										WHERE
												--CurrentAsOf IS NOT NULL
												ReportingEnabled 	= 1
											AND
												Eligible 			= 1
									)	
			END
		END



		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @LocalizedStringObjectIdV2, @LocaleKeyV2, @ValueV2

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast( @countV2 as varchar )+' Records Processed'

		/**************************************************************************************************/




		
		
		PRINT ''			
		PRINT 'Insert Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Inserts'
		
		DECLARE @successfulInserts		int
		SET		@successfulInserts		= ( 
												SELECT 
														COUNT(1)
												FROM 
														##CompanyTranslatedFields_NeedsInsert	t10		
													JOIN 
														LocalizedStringValue					t20	WITH (NOLOCK) 
															ON	
																	t10.LocalizedStringObjectId		= t20.LocalizedStringObjectId
																AND
																	t10.LocaleKey					= t20.LocaleKey
																AND
																	t10.Value						= t20.Value
											)


		
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST( @ImportInsertCheck AS varchar ) + ' Successful: ' + CAST( @successfulInserts as varchar )
		PRINT ''
		PRINT ''
	
		
	END




	UPDATE	##CompanyTranslatedFields_Statistics
	SET		processingComplete = GETDATE()
	
	

END














PROCESSING_COMPLETE:
IF @ImportUpdateCheck > 0 OR @ImportInsertCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'


DECLARE  @DeliveryEmailV2											varchar(100)			
		, @FileNameV2												varchar(100)
		, @ServerNameV2												varchar(25)
		, @OriginalFileSizeV2										int
		, @NullCountV2												int
		, @NotLegitLocalizedStringObjectIdV2						int
		, @NotLegitLocaleKeyV2										int
		, @DuplicateCheckV2											int
		, @CompanyTranslatedFields_ExistsV2							int
		, @CompanyTranslatedFields_ConflictingValuesV2				int
		, @CompanyTranslatedFields_NeedsUpdateV2					int
		, @CompanyTranslatedFields_NeedsInsertV2					int
		, @CompanyTranslatedFields_UnidentifiedV2					int

		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @DeliveryEmailV2								= ( SELECT DeliveryEmail								FROM ##CompanyTranslatedFields_Statistics )
SET @FileNameV2										= ( SELECT InputFileName								FROM ##CompanyTranslatedFields_Statistics )
SET @ServerNameV2									= ( SELECT ServerName									FROM ##CompanyTranslatedFields_Statistics )
SET @OriginalFileSizeV2								= ( SELECT OriginalCount								FROM ##CompanyTranslatedFields_Statistics )
SET @NullCountV2									= ( SELECT NullCount									FROM ##CompanyTranslatedFields_Statistics )
SET @NotLegitLocalizedStringObjectIdV2 				= ( SELECT NotLegitLocalizedStringObjectId				FROM ##CompanyTranslatedFields_Statistics )
SET @NotLegitLocaleKeyV2							= ( SELECT NotLegitLocaleKey							FROM ##CompanyTranslatedFields_Statistics )
SET @DuplicateCheckV2								= ( SELECT Duplicates									FROM ##CompanyTranslatedFields_Statistics )
SET @CompanyTranslatedFields_ExistsV2				= ( SELECT CompanyTranslatedFields_Exists				FROM ##CompanyTranslatedFields_Statistics )
SET @CompanyTranslatedFields_ConflictingValuesV2	= ( SELECT CompanyTranslatedFields_ConflictingValues	FROM ##CompanyTranslatedFields_Statistics )
SET @CompanyTranslatedFields_NeedsUpdateV2			= ( SELECT CompanyTranslatedFields_NeedsUpdate			FROM ##CompanyTranslatedFields_Statistics )
SET @CompanyTranslatedFields_NeedsInsertV2			= ( SELECT CompanyTranslatedFields_NeedsInsert			FROM ##CompanyTranslatedFields_Statistics )
SET @CompanyTranslatedFields_UnidentifiedV2			= ( SELECT CompanyTranslatedFields_Unidentified			FROM ##CompanyTranslatedFields_Statistics )



SET @ProcessingStartV2								= ( SELECT ProcessingStart								FROM ##CompanyTranslatedFields_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete							FROM ##CompanyTranslatedFields_Statistics )
		
SET 	@Minutes	= ( SELECT (DATEDIFF( ss, @ProcessingStartV2, @ProcessingCompleteV2 )) / 60		)
SET 	@Seconds	= ( SELECT (DATEDIFF( ss, @ProcessingStartV2, @ProcessingCompleteV2 )) % 60		) 




IF @Minutes < 10
	BEGIN
		SET @Minutes = '0' + @Minutes
	END

	
IF @Seconds < 10
	BEGIN
		SET @Seconds = '0' + @Seconds
	END

SET @ProcessingDurationV2 = 'Minutes ' + @Minutes + ' Seconds ' + @Seconds


IF OBJECT_ID('tempdb..##CompanyTranslatedFieldsStatus_Action') IS NOT NULL	DROP TABLE ##CompanyTranslatedFieldsStatus_Action
CREATE TABLE ##CompanyTranslatedFieldsStatus_Action
	(
		Action							varchar(50)
		, LocalizedStringObjectId		int
		, LocaleKey						varchar(25)
		, Value							nvarchar(max)
		, Value_Old						nvarchar(max)
	)



IF @NotLegitLocalizedStringObjectIdV2 > 0
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'NonLegit LocalizedStringObjectId'
			, LocalizedStringObjectId
			, LocaleKey
			, Value
	FROM
			##CompanyTranslatedFields_NotLegitLocalizedStringObjectId
END



IF @NotLegitLocaleKeyV2 > 0
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'NonLegit LocaleKey'
			, LocalizedStringObjectId
			, LocaleKey
			, Value
	FROM
			##CompanyTranslatedFields_NotLegitLocaleKey
END



IF @DuplicateCheckV2 > 0
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'Duplicate'
			, LocalizedStringObjectId
			, LocaleKey	
			, Value
	FROM
			##CompanyTranslatedFields_Duplicates

END



IF @CompanyTranslatedFields_UnidentifiedV2 > 0	
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'Unidentified'
			, LocalizedStringObjectId
			, LocaleKey
			, Value		
	FROM
			##CompanyTranslatedFields_Unidentified

END



IF @CompanyTranslatedFields_ConflictingValuesV2 > 0	
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'Conflicting Values'
			, LocalizedStringObjectId
			, LocaleKey		
			, Value
	FROM
			##CompanyTranslatedFields_ConflictingValues

END



IF @CompanyTranslatedFields_ExistsV2 > 0
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'Record Exists'
			, LocalizedStringObjectId
			, LocaleKey
			, Value		
	FROM
			##CompanyTranslatedFields_Exists

END



IF @CompanyTranslatedFields_NeedsUpdateV2 > 0	
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value, Value_Old )
	SELECT 	
			'Update'
			, LocalizedStringObjectId
			, LocaleKey		
			, Value
			, Value_Old
	FROM
			##CompanyTranslatedFields_NeedsUpdate

END



IF @CompanyTranslatedFields_NeedsInsertV2 > 0	
BEGIN
	INSERT INTO ##CompanyTranslatedFieldsStatus_Action ( Action, LocalizedStringObjectId, LocaleKey, Value )
	SELECT 	
			'Insert'
			, LocalizedStringObjectId
			, LocaleKey		
			, Value
	FROM
			##CompanyTranslatedFields_NeedsInsert

END
		
		
		
		
		
		
		
		
		
		
		
		
		
		


-- Builds Final Email
IF OBJECT_ID('tempdb..##CompanyTranslatedFieldsStatus_Action_Results') IS NOT NULL	DROP TABLE ##CompanyTranslatedFieldsStatus_Action_Results
CREATE TABLE ##CompanyTranslatedFieldsStatus_Action_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##CompanyTranslatedFieldsStatus_Action_Results ( Item, Criteria )
SELECT 'Server Name'						, @ServerNameV2
UNION ALL
SELECT 'Delivery Email'						, @DeliveryEmailV2
UNION ALL	
SELECT 'Input File Name'					, @FileNameV2
UNION ALL
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @OriginalFileSizeV2 , 0)   									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @NullCountV2 , 0)    										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit LocalizedStringObjectIds'	, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @NotLegitLocalizedStringObjectIdV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit LocaleKey'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @NotLegitLocaleKeyV2 , 0)    						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @DuplicateCheckV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @CompanyTranslatedFields_ExistsV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @CompanyTranslatedFields_UnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @CompanyTranslatedFields_NeedsUpdateV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Inserts'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @CompanyTranslatedFields_NeedsInsertV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Inserts'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulInserts , 0)   								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'CompanyTranslatedFields_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, LocalizedStringObjectId
										, LocaleKey									
										, Value
										, Value_Old
												
								FROM 
										##CompanyTranslatedFieldsStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##CompanyTranslatedFieldsStatus_Action_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Company Translated Fields
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @DeliveryEmailV2
, @copy_recipients 				= 'zbelghali@InMoment.com; bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Company Translated Fields Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	








END













CLEANUP:
	PRINT 'Cleaning up tmp tables'
	PRINT ''



 
 
 -- Clean up
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Upload') IS NOT NULL								DROP TABLE ##CompanyTranslatedFields_Upload		
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NotLegitLocalizedStringObjectId') IS NOT NULL		DROP TABLE ##CompanyTranslatedFields_NotLegitLocalizedStringObjectId		
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NotLegitLocaleKey') IS NOT NULL						DROP TABLE ##CompanyTranslatedFields_NotLegitLocaleKey		
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Duplicates') IS NOT NULL							DROP TABLE ##CompanyTranslatedFields_Duplicates				
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_ConflictingValues') IS NOT NULL						DROP TABLE ##CompanyTranslatedFields_ConflictingValues	
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Exists') IS NOT NULL								DROP TABLE ##CompanyTranslatedFields_Exists
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NeedsUpdate') IS NOT NULL							DROP TABLE ##CompanyTranslatedFields_NeedsUpdate		
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_NeedsInsert') IS NOT NULL							DROP TABLE ##CompanyTranslatedFields_NeedsInsert		
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Unidentified') IS NOT NULL							DROP TABLE ##CompanyTranslatedFields_Unidentified		
IF OBJECT_ID('tempdb..##CompanyTranslatedFields_Statistics') IS NOT NULL							DROP TABLE ##CompanyTranslatedFields_Statistics


 
 
 
 /*
 
 
 
-- Visuals
SELECT * FROM  ##CompanyTranslatedFields_Upload
SELECT * FROM  ##CompanyTranslatedFields_NotLegitLocalizedStringObjectId
SELECT * FROM  ##CompanyTranslatedFields_NotLegitLocaleKey
SELECT * FROM  ##CompanyTranslatedFields_Duplicates
SELECT * FROM  ##CompanyTranslatedFields_ConflictingValues
SELECT * FROM  ##CompanyTranslatedFields_Exists
SELECT * FROM  ##CompanyTranslatedFields_NeedsUpdate
SELECT * FROM  ##CompanyTranslatedFields_NeedsInsert
SELECT * FROM  ##CompanyTranslatedFields_Unidentified
SELECT * FROM  ##CompanyTranslatedFields_Statistics

 
 
 
 */
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
