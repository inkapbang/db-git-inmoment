SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_PromptDataFieldChange_AutoDelivery]
		@deliveryEmail	varchar(100)	= NULL
		, @FileName		varchar(100)	= NULL
		
		, @answer		varchar(10)		= NULL		

		
AS

/************** Prompt and Corresponding DataField Change  **************

	Comments

		Updates PromtType.Prompt and FieldType.DataField 
		from a provided file .
		
		Executed against OLTP only

		Note: Executing these SP without any parameters will
		print out requirements.
		
		sp_PromptDataFieldChange_AutoDelivery	
			@DeliveryEmail	= ''''
			, @FileName		= ''''
	


	History
		00.00.0000	Tad Peterson
			-- created 

		00.00.0000	Tad Peterson
			-- added textValue and NumericValue

		09.09.2014	Tad Peterson
			-- added comment type support

	
************************************************************************/

SET NOCOUNT ON

DECLARE @answerCheck				int
SET		@answerCheck				= CASE	WHEN @answer IS NULL 		THEN 0
											WHEN @answer = 'EXECUTE'	THEN 1
										ELSE 2
										END

													
DECLARE @deliveryEmailCheck			int
SET		@deliveryEmailCheck			= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
											WHEN LEN(@deliveryEmail) = 0	THEN 0
											WHEN LEN(@deliveryEmail) > 0	THEN 1
										END
									

DECLARE @FileNameCheck				int
SET		@FileNameCheck				= CASE	WHEN LEN(@FileName) IS NULL 	THEN 0
											WHEN LEN(@FileName) = 0			THEN 0
											WHEN LEN(@FileName) > 0			THEN 1
										END

										
IF @answerCheck > 0
GOTO PROCESSING									
										
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@FileNameCheck			= 0	
			
	BEGIN
	
		PRINT 'Prompt and corresponding dataField change'
		PRINT CHAR(9) + 'Description: '
		PRINT CHAR(9) + CHAR(9) + 'Changes PromtType.Prompt and its corresponding FieldType.DataField  '
		PRINT CHAR(9) + CHAR(9) + 'based on a PromptId and new Prompt Type combination from a provide file.'
		PRINT CHAR(9) + CHAR(9) + 'Currently it changes Multiple Choice to Rating and vice versa.'
		PRINT CHAR(9) + CHAR(9) + 'All other prompt change requests will be classified as an unidentified request.'
		PRINT ''
		PRINT ''
		PRINT 'Minimum Requirements:'
		PRINT CHAR(9) + 'Delivery email address ' 
		PRINT CHAR(9) + 'File name'
		PRINT ''
		PRINT ''
		PRINT 'Optional Criteria:'
		PRINT CHAR(9) + 'None'
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'OrgId'
		PRINT CHAR(9) + 'PromptId'
		PRINT CHAR(9) + 'NewPromptType'
		PRINT CHAR(9) + 'DataFieldId'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a form to fill out, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_PromptDataFieldChange_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail     = ''Their Email Here'''
		
	RETURN
	END		




-- Sends Form to requestor; and requirements
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN
	PRINT 'Emailed form to ' + @deliveryEmail
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name		= 'Internal Request'
, @recipients		= @deliveryEmail
, @reply_to			= 'dba@InMoment.com'
, @subject			= 'Prompt and DataField Change Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.

Prompt Id and Types
--------------------

 0 = ReadOnlyPrompt
 1 = NumericPrompt
 2 = TextPrompt
 3 = DatePrompt
 4 = RatingPrompt
 5 = CommentPrompt
 6 = CompositeTextPrompt
 7 = LogicPrompt
 8 = TransferPrompt
 9 = RatingGroupPrompt
10 = OfferCodeSearchPrompt
11 = EmployeeSelectorPrompt
12 = (unused)
13 = TimePrompt
14 = BooleanPrompt
15 = BooleanGroupPrompt
16 = MultipleChoicePrompt
17 = MultipleChoiceGroupPrompt





File Setup & Contents Example
------------------------------

OrgId		PromptId	NewPromptType	DataFieldId
876		72643		4			56561
678		72644		16			56562



Notes & Comments
-----------------
	
	*Notice*
		If you choose to do anything other than a Rating to Multiple Choice OR Multiple Choice to Rating,
		the prompt change will require the historical data to be migrated to new storage location.
	
	1. Please be aware of proper file setup (order) to ensure successful processing.
	2. Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	3. File should be in CSV format.
	4. Please make sure your file is attached to return email.





Return Email
-------------

sp_PromptDataFieldChange_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''file name here''
		

		
		
-- Example Below --

sp_PromptDataFieldChange_AutoDelivery
	@DeliveryEmail	= ''tpeterson@InMoment.com''
	, @FileName		= ''20120702JasonDeliPromptChange.csv''
		

		
'		
	
RETURN	
END




/*******************************************************************  Upload & Processing Portion  *******************************************************************/


-- Upload and Process Statistics
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 1
		
BEGIN

SET NOCOUNT ON 

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange
CREATE TABLE _PromptDataField_PromptChange
		(
			OrgId				bigint
			, PromptId			int	
			, NewPromptType		int
			, DataFieldId		int		
		)


DECLARE @FileNameBulkInsertStatement	nvarchar(max)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _PromptDataField_PromptChange   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

--SELECT @FileNameBulkInsertStatement

EXECUTE (@FileNameBulkInsertStatement)




			
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _PromptDataField_PromptChange	)
			

--SELECT @originalFileSize

DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _PromptDataField_PromptChange	WHERE OrgId IS NULL	OR	PromptId IS NULL	OR  NewPromptType IS NULL	OR DataFieldId IS NULL )


--SELECT @nullCount

-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _PromptDataField_PromptChange
	WHERE
			OrgId 			IS NULL
		OR
			PromptId 		IS NULL
		OR
			NewPromptType 	IS NULL
		OR
			DataFieldId 	IS NULL
			
END			






-- Verifies Org, Prompt and DataField combination are legit
DECLARE @OrgPromptDataFieldCombinationBad	int
SET		@OrgPromptDataFieldCombinationBad	= 
												(
													SELECT
															COUNT(1)
													FROM
															_PromptDataField_PromptChange	t01
														LEFT JOIN
															(
																SELECT
																		t101.objectId		AS OrgId
																		, t102.objectId		AS PromptId
																		, t103.objectId		AS DataFieldId
																FROM
																		organization		t101
																	JOIN
																		prompt				t102
																				ON t101.objectId = t102.organizationObjectId
																	JOIN
																		dataField			t103
																				ON t102.dataFieldObjectId = t103.objectId
															) AS t100
																	ON t01.OrgId = t100.OrgId AND t01.PromptId = t100.PromptId AND t01.DataFieldId = t100.DataFieldId
														
													WHERE
															t100.OrgId IS NULL		
												)


										
										
										
										
-- Non legit Org, Prompt and DataField combination; preserved and deleted
IF @OrgPromptDataFieldCombinationBad > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_BadOrgPromptDataFieldCombination') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange_BadOrgPromptDataFieldCombination	
	SELECT
			t01.OrgId
			, t01.PromptId
			, t01.DataFieldId						
	INTO _PromptDataField_PromptChange_BadOrgPromptDataFieldCombination	
	FROM
			_PromptDataField_PromptChange	t01
		LEFT JOIN
			(
				SELECT
						t101.objectId		AS OrgId
						, t102.objectId		AS PromptId
						, t103.objectId		AS DataFieldId
				FROM
						organization		t101
					JOIN
						prompt				t102
								ON t101.objectId = t102.organizationObjectId
					JOIN
						dataField			t103
								ON t102.dataFieldObjectId = t103.objectId
			) AS t100
					ON t01.OrgId = t100.OrgId AND t01.PromptId = t100.PromptId AND t01.DataFieldId = t100.DataFieldId
		
	WHERE
			t100.OrgId IS NULL		
	
	
	

	-- Delete Step
	DELETE	t01
	FROM	
			_PromptDataField_PromptChange					t01
		JOIN
			_PromptDataField_PromptChange_BadOrgPromptDataFieldCombination		t02
					ON t01.OrgId = t02.OrgId AND t01.PromptId = t02.PromptId AND t01.DataFieldId = t02.DataFieldId

END



										
										
										


-- Checks for Duplicate Prompts
DECLARE @duplicateCheckPrompt		int
SET		@duplicateCheckPrompt		= 
								(
								
									SELECT
											COUNT(1)
									FROM
										(		

											SELECT
													PromptId
													
											FROM
													_PromptDataField_PromptChange	t01

											GROUP BY 
													PromptId
											HAVING	COUNT(1) > 1
										) AS t101
										
								)





-- Removes Duplicate Prompt Request
IF @duplicateCheckPrompt	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_DuplicatePrompt') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange_DuplicatePrompt
	SELECT
			t01.OrgId
			, t01.PromptId
			, t01.NewPromptType
			, t01.DataFieldId
	INTO _PromptDataField_PromptChange_DuplicatePrompt		
	FROM
			_PromptDataField_PromptChange	t01
		JOIN
			(
				SELECT
					PromptId
						
				FROM
						_PromptDataField_PromptChange	t101

				GROUP BY 
						PromptId
				HAVING	COUNT(1) > 1
			) AS t100
					ON t01.promptId = t100.promptId

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_PromptDataField_PromptChange					t01
		JOIN
			_PromptDataField_PromptChange_DuplicatePrompt		t02
						ON	
							t01.OrgId			= t02.OrgId
						AND
							t01.PromptId		= t02.PromptId
						AND
							t01.NewPromptType	= t02.NewPromptType
						AND 
							t01.DataFieldId		= t02.DataFieldId	
							
							
		


END




-- Removes Duplicate DataField Request; this will rarely ever catch anything, but is included for completeness, most everything will be caught in bad combo OR duplicate prompt.
DECLARE @duplicateCheckDataField		int
SET		@duplicateCheckDataField		= 
											(
											
												SELECT
														COUNT(1)
												FROM
													(		

														SELECT
																DataFieldId
																
														FROM
																_PromptDataField_PromptChange	t01

														GROUP BY 
																DataFieldId
														HAVING	COUNT(1) > 1
													) AS t101
													
											)



IF @duplicateCheckDataField	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_DuplicateDataField') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange_DuplicateDataField
	SELECT
			t01.OrgId
			, t01.PromptId
			, t01.NewPromptType
			, t01.DataFieldId
	INTO _PromptDataField_PromptChange_DuplicateDataField		
	FROM
			_PromptDataField_PromptChange	t01
		JOIN
			(
				SELECT
					DataFieldId
						
				FROM
						_PromptDataField_PromptChange	t101

				GROUP BY 
						DataFieldId
				HAVING	COUNT(1) > 1
			) AS t100
					ON t01.DataFieldId = t100.DataFieldId

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_PromptDataField_PromptChange						t01
		JOIN
			_PromptDataField_PromptChange_DuplicateDataField	t02
						ON	
							t01.OrgId			= t02.OrgId
						AND
							t01.PromptId		= t02.PromptId
						AND
							t01.NewPromptType	= t02.NewPromptType
						AND 
							t01.DataFieldId		= t02.DataFieldId	
							
							
		


END








-- Adds the FieldType Column and proper value
IF OBJECT_ID('tempdb..##PromptDataField_PromptChange') IS NOT NULL		DROP TABLE ##PromptDataField_PromptChange
SELECT
		OrgId
		, PromptId
		, NewPromptType
		, DataFieldId

INTO ##PromptDataField_PromptChange
			
FROM
		_PromptDataField_PromptChange
		


		
		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange
CREATE TABLE _PromptDataField_PromptChange
		(
			OrgId				bigint
			, PromptId			int	
			, NewPromptType		int
			, DataFieldId		int
			, FieldType			int			
		)


INSERT INTO _PromptDataField_PromptChange ( OrgId, PromptId, NewPromptType, DataFieldId, FieldType )
SELECT
		OrgId
		, PromptId
		, NewPromptType
		, DataFieldId
		, CASE 	WHEN	NewPromptType = 4	THEN 4
				WHEN	NewPromptType = 16	THEN 83	
				WHEN	NewPromptType = 1	THEN 1
				WHEN	NewPromptType = 2	THEN 2			
				WHEN 	NewPromptType = 5	THEN 5		-- This needs to be adjusted when more prompt change types are requested
				
			END	

FROM
		##PromptDataField_PromptChange
	



--Seperates Prompts and DataFields for Cursor update later.
DECLARE @promptIdNewPromptType	int
SET 	@promptIdNewPromptType	= 
											(
												SELECT
														COUNT(1)														
												FROM
														_PromptDataField_PromptChange				t01
													JOIN
														Prompt										t02
																ON t01.PromptId = t02.objectId
												WHERE
														t01.NewPromptType IN ( 4, 16, 1, 2, 5 )
													AND
														t01.NewPromptType	!= t02.PromptType
											
											)

											
-- Seperates the Prompts and DataFields for cursor
IF @promptIdNewPromptType > 0 
BEGIN

--Prompt List and Preserve
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptId_NewPromptType_Update') AND type = (N'U'))    DROP TABLE _PromptId_NewPromptType_Update		
SELECT
		OrgId
		, PromptId
		, NewPromptType
		, PromptType			AS OldPromptType
		, DataFieldId

INTO	_PromptId_NewPromptType_Update	
		
FROM
		_PromptDataField_PromptChange				t01
	JOIN
		Prompt										t02
				ON t01.PromptId = t02.objectId
WHERE
		t01.NewPromptType IN ( 4, 16, 1, 2, 5 )							-- Will need to be modified when new promptType requests emerge
	AND
		t01.NewPromptType	!= t02.PromptType
		

--DataField List and Preserve
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataFieldId_FieldType_Update') AND type = (N'U'))    DROP TABLE _DataFieldId_FieldType_Update		
SELECT
		OrgId
		, PromptId
		, DataFieldId
		, t01.FieldType			AS NewFieldType
		, t02.FieldType			AS OldFieldType

INTO	_DataFieldId_FieldType_Update	
		
FROM
		_PromptDataField_PromptChange				t01
	JOIN
		DataField									t02
				ON t01.DataFieldId = t02.objectId
WHERE
		t01.FieldType IN ( 4, 83, 1, 2, 5 )							-- Will need to be modified when new promptType requests emerge
	AND
		t01.FieldType	!= t02.FieldType



		
	-- Deletes from origianl table
	DELETE	t01
	FROM
			_PromptDataField_PromptChange		t01
		JOIN
			_PromptId_NewPromptType_Update		t02
					ON 
							t01.OrgId 			= t02.OrgId
						AND
							t01.PromptId		= t02.PromptId
						AND
							t01.NewPromptType	= t02.NewPromptType
						AND
							t01.DataFieldId		= t02.DataFieldId


END






--Checks for existing records
DECLARE @promptIdDataFieldExist	int
SET 	@promptIdDataFieldExist	= 
									(
										SELECT
												COUNT(1)
										FROM
												_PromptDataField_PromptChange		t01
											JOIN
												Prompt								t02
														ON 
															t01.OrgId 			= t02.organizationObjectId
														AND
															t01.PromptId		= t02.ObjectId
														AND
															t01.NewPromptType	= t02.PromptType
														AND
															t01.DataFieldId		= t02.DataFieldObjectId
											JOIN
												DataField							t03
														ON 
															t01. DataFieldId 	= t03.objectId
														AND
															t01.FieldType		= t03.FieldType
									
									)








IF @promptIdDataFieldExist > 0
BEGIN

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_Exist') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange_Exist		
SELECT
		t01.OrgId
		,t01.PromptId
		, t01.NewPromptType
		, t02.PromptType			AS CurrentPromptType
		, t01.DataFieldId
		, t01.FieldType
		, t03.FieldType				AS CurrentFieldType	
		
INTO 	_PromptDataField_PromptChange_Exist	
		
FROM
		_PromptDataField_PromptChange		t01
	JOIN
		Prompt								t02
				ON 
					t01.OrgId 			= t02.organizationObjectId
				AND
					t01.PromptId		= t02.ObjectId
				AND
					t01.NewPromptType	= t02.PromptType
				AND
					t01.DataFieldId		= t02.DataFieldObjectId
	JOIN
		DataField							t03
				ON 
					t01. DataFieldId 	= t03.objectId
				AND
					t01.FieldType		= t03.FieldType
				



	-- Deletes from origianl table
	DELETE	t01
	FROM
			_PromptDataField_PromptChange		t01
		JOIN
			_PromptDataField_PromptChange_Exist	t02
				ON
					t01.OrgId			= t02.OrgId
				AND
					t01.PromptId		= t02.PromptId
				AND
					t01.NewPromptType	= t02.NewPromptType
				AND
					t01.DataFieldId		= t02.DataFieldId
				AND
					t01.FieldType		= t02.FieldType



END






-- Identifies any remaining rows in original file
DECLARE @PromptDataFieldUnidentified		int
SET		@PromptDataFieldUnidentified		= ( SELECT COUNT(1)	FROM _PromptDataField_PromptChange )


IF @PromptDataFieldUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_Unidentified') AND type = (N'U'))    DROP TABLE _PromptDataField_PromptChange_Unidentified
	SELECT
			*
	INTO _PromptDataField_PromptChange_Unidentified
	FROM
		_PromptDataField_PromptChange
		
		
		
		
	-- Deletes Exist
	DELETE	t01
	FROM
			_PromptDataField_PromptChange				t01
		JOIN
			_PromptDataField_PromptChange_Unidentified	t02
					ON	
							t01.OrgId			= t02.OrgId
						AND
							t01.PromptId		= t02.PromptId
						AND 
							t01.DataFieldId	= t02.DataFieldId
		
	
END





DECLARE @PromptTypeUpdateCount		int
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptId_NewPromptType_Update') AND type = (N'U')) 		SET 	@PromptTypeUpdateCount		= ( SELECT COUNT(1)		FROM _PromptId_NewPromptType_Update )




DECLARE @DataFieldUpdateCount		int
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataFieldId_FieldType_Update') AND type = (N'U'))		SET 	@DataFieldUpdateCount		= ( SELECT COUNT(1)		FROM _DataFieldId_FieldType_Update )

				



IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Prompt_DataField_NewPromptType_Statistics') AND type = (N'U'))    DROP TABLE _Prompt_DataField_NewPromptType_Statistics
CREATE TABLE _Prompt_DataField_NewPromptType_Statistics
	(
		DeliveryEmail										varchar(100)
		, inputFileName										varchar(100)
		, serverName										varchar(25)
		, originalCount										int
		, nullCount											int
		, orgPromptDataFieldCombinationBad					int
		, DuplicatePrompt									int
		, DuplicateDataField								int
		, PromptDataFieldExist								int
		, PromptDataFieldUnidentified						int
		, PromptUpdate										int
		, DataFieldUpdate									int
		, processingStart									dateTime
		, processingComplete								dateTime

	)		

	
INSERT INTO _Prompt_DataField_NewPromptType_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, orgPromptDataFieldCombinationBad, DuplicatePrompt, DuplicateDataField, PromptDataFieldExist, PromptDataFieldUnidentified, PromptUpdate, DataFieldUpdate )
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @OrgPromptDataFieldCombinationBad, @duplicateCheckPrompt, @duplicateCheckDataField, @promptIdDataFieldExist, @PromptDataFieldUnidentified, @PromptTypeUpdateCount, @DataFieldUpdateCount






-- Results Print Out
PRINT 'Original CSV Row Count                         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@originalFileSize								,	0	)   	AS money)), 1), '.00', '')
PRINT 'NULL Values Found                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@nullCount										,	0	)   	AS money)), 1), '.00', '')
PRINT 'Org Prompt DataField Combination Bad           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@OrgPromptDataFieldCombinationBad								,	0	)		AS money)), 1), '.00', '')
PRINT 'Duplicate Prompts                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@duplicateCheckPrompt									,	0	)   	AS money)), 1), '.00', '')
PRINT 'Duplicate DataFields                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@duplicateCheckDataField									,	0	)   	AS money)), 1), '.00', '')
PRINT 'Prompt DataField Exist                         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@promptIdDataFieldExist									,	0	)   	AS money)), 1), '.00', '')
PRINT 'Records Unidentified                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@PromptDataFieldUnidentified	,	0	)		AS money)), 1), '.00', '')
PRINT 'Prompt Updates                                 :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@PromptTypeUpdateCount	,	0	)		AS money)), 1), '.00', '')
PRINT 'DataField Updates                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@DataFieldUpdateCount	,	0	)		AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_PromptDataFieldChange_AutoDelivery @answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_PromptDataFieldChange_AutoDelivery @answer = ''terminate'''




		
RETURN
END








											




--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN

	DECLARE @PromptTypeUpdateCheck		int
	SET		@PromptTypeUpdateCheck		= ( SELECT PromptUpdate			FROM _Prompt_DataField_NewPromptType_Statistics )

	DECLARE @DataFieldUpdateCheck		int
	SET		@DataFieldUpdateCheck		= ( SELECT DataFieldUpdate		FROM _Prompt_DataField_NewPromptType_Statistics )

	
	UPDATE _Prompt_DataField_NewPromptType_Statistics
	SET processingStart = GETDATE()

	
	--If statements for Cursors Here
	IF @PromptTypeUpdateCheck > 0
	BEGIN

		PRINT 'Prompt PromptType Updating ' + CAST(@PromptTypeUpdateCheck AS varchar) + ' records'


		/********************  Prompt NewPromptType Update  ********************/


		-----Cursor for Prompt PromptType Update

		DECLARE @count bigint, @PromptObjectId bigint, @NewPromptType int

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT PromptId, NewPromptType		FROM _PromptId_NewPromptType_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @PromptObjectId, @NewPromptType

		WHILE @@Fetch_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@PromptObjectId as varchar)+', '+cast(@NewPromptType as varchar)


		----******************* W A R N I N G***************************


		UPDATE Prompt		WITH (ROWLOCK)
		SET 	PromptType 	= @NewPromptType
		WHERE	objectId 	= @PromptObjectId


		----***********************************************************

		SET @count = @count + 1
		FETCH next FROM mycursor INTO @PromptObjectId, @NewPromptType

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@count as varchar)+' Records Processed'

		/**************************************************************************************/




		PRINT ''			
		PRINT 'Update Prompt PromptType Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Updates'
		
		DECLARE @successfulPromptTypeUpdates		int
		SET		@successfulPromptTypeUpdates		= ( SELECT COUNT(1)		FROM _PromptId_NewPromptType_Update	t01		JOIN Prompt t02		ON t01.OrgId = t02.organizationObjectId  AND t01.PromptId = t02.ObjectId AND t01.NewPromptType = t02.PromptType )
		
		PRINT CHAR(9) + 'Requested PromptType Updates: ' + CAST(@PromptTypeUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulPromptTypeUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END

	

	IF @DataFieldUpdateCheck > 0
	BEGIN
	
		PRINT 'DataField FieldType Updating ' + CAST(@DataFieldUpdateCheck AS varchar) + ' records'
	
		/**************************  Comment CommentText Update  **************************/

		-----Cursor for DataField FieldType Update

		DECLARE @countV2 bigint, @DataFieldObjectIdV2 bigint, @NewFieldTypeV2 int

		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT DataFieldId, NewFieldType FROM _DataFieldId_FieldType_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @DataFieldObjectIdV2, @NewFieldTypeV2

		WHILE @@Fetch_Status = 0
		BEGIN

		
		PRINT cast(@countV2 as varchar)+', '+cast(@DataFieldObjectIdV2 as varchar)+', '+cast(@NewFieldTypeV2 as varchar)


		----******************* W A R N I N G***************************


		UPDATE	DataField		WITH (ROWLOCK)
		SET		FieldType	= @NewFieldTypeV2
		WHERE	ObjectId 	= @DataFieldObjectIdV2


		----***********************************************************

		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @DataFieldObjectIdV2, @NewFieldTypeV2

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@countV2 as varchar)+' Records Processed'


		/**************************************************************************************************/



		PRINT ''	
		PRINT 'Update DataField FieldType Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Updates'
						
		
		DECLARE @successfulFieldTypeUpdate		int
		SET		@successfulFieldTypeUpdate		= ( SELECT COUNT(1)		FROM _DataFieldId_FieldType_Update	t01		JOIN DataField	t02		ON t01.DataFieldId = t02.objectId AND t01.NewFieldType = t02.FieldType )
		
		PRINT CHAR(9) + 'Requested FieldType Updates: ' + CAST(@DataFieldUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulFieldTypeUpdate as varchar)
		PRINT ''
		PRINT ''
		
		
	
	END



	
	

	UPDATE _Prompt_DataField_NewPromptType_Statistics
	SET processingComplete = GETDATE()


	GOTO PROCESSING_COMPLETE		

END


IF @answerCheck = 2
BEGIN

	PRINT 'Terminating Script'
	PRINT ''

	
GOTO CLEANUP
END





PROCESSING_COMPLETE:
IF @PromptTypeUpdateCheck > 0 OR @DataFieldUpdateCheck > 0  
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE	@DeliveryEmailV2									varchar(100)
		, @inputFileNameV2									varchar(100)
		, @serverNameV2										varchar(25)
		, @originalCountV2									int
		, @nullCountV2										int
		, @orgPromptDataFieldCombinationBadV2				int
		, @DuplicatePromptV2								int
		, @DuplicateDataFieldV2								int
		, @PromptDataFieldExistV2							int
		, @PromptDataFieldUnidentifiedV2					int
		, @PromptTypeUpdateV2								int
		, @DataFieldUpdateV2								int
		, @processingStartV2								dateTime
		, @processingCompleteV2								dateTime

		, @Minutes											varchar(3)
		, @Seconds											varchar(3)		
		, @ProcessingDurationV2								varchar(25)
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail						FROM _Prompt_DataField_NewPromptType_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName						FROM _Prompt_DataField_NewPromptType_Statistics )
SET @serverNameV2											= ( SELECT serverName							FROM _Prompt_DataField_NewPromptType_Statistics )
SET @originalCountV2										= ( SELECT originalCount						FROM _Prompt_DataField_NewPromptType_Statistics )
SET @nullCountV2											= ( SELECT nullCount							FROM _Prompt_DataField_NewPromptType_Statistics )
SET @OrgPromptDataFieldCombinationBadV2 					= ( SELECT orgPromptDataFieldCombinationBad		FROM _Prompt_DataField_NewPromptType_Statistics )
SET @duplicatePromptV2										= ( SELECT DuplicatePrompt						FROM _Prompt_DataField_NewPromptType_Statistics )
SET @duplicateDataFieldV2									= ( SELECT DuplicateDataField					FROM _Prompt_DataField_NewPromptType_Statistics )
SET @PromptDataFieldExistV2									= ( SELECT PromptDataFieldExist					FROM _Prompt_DataField_NewPromptType_Statistics )
SET @PromptDataFieldUnidentifiedV2							= ( SELECT PromptDataFieldUnidentified			FROM _Prompt_DataField_NewPromptType_Statistics )
SET @PromptTypeUpdateV2										= ( SELECT PromptUpdate							FROM _Prompt_DataField_NewPromptType_Statistics )
SET @DataFieldUpdateV2										= ( SELECT DataFieldUpdate						FROM _Prompt_DataField_NewPromptType_Statistics )




SET @ProcessingStartV2			= ( SELECT ProcessingStart				FROM _Prompt_DataField_NewPromptType_Statistics )
SET @ProcessingCompleteV2		= ( SELECT ProcessingComplete			FROM _Prompt_DataField_NewPromptType_Statistics )
		
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


IF OBJECT_ID('tempdb..##PromptDataFieldStatus_Action') IS NOT NULL	DROP TABLE ##PromptDataFieldStatus_Action
CREATE TABLE ##PromptDataFieldStatus_Action
	(
		Action								varchar(50)
		, OrgId					int
		, PromptId				int
		, NewPromptType			int
		, OldPromptType			int
		, DataFieldId			int
		, newFieldType			int
		, OldFieldType			int
	)


IF @OrgPromptDataFieldCombinationBadV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, DataFieldId )
	SELECT 	'Org Prompt DataField Combination Bad'
			, OrgId
			, PromptId
			, DataFieldId	
			
	FROM
			_PromptDataField_PromptChange_BadOrgPromptDataFieldCombination
END



--Need Dyuplicate Record




IF @duplicatePromptV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, NewPromptType, DataFieldId )
	SELECT 	'Duplicate Prompts'
			, OrgId
			, PromptId
			, NewPromptType
			, DataFieldId
			
	FROM
			_PromptDataField_PromptChange_DuplicatePrompt

END
		



IF @duplicateDataFieldV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, NewPromptType, DataFieldId )
	SELECT 	'Duplicate DataFields'
		, OrgId
		, PromptId
		, NewPromptType
		, DataFieldId
			
	FROM
			_PromptDataField_PromptChange_DuplicateDataField

END



IF @PromptDataFieldExistV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, NewPromptType, OldPromptType, DataFieldId, NewFieldType, OldFieldType  )
	SELECT  'Prompt DataField Records Exist'
			, OrgId
			, PromptId
			, NewPromptType
			, CurrentPromptType
			, DataFieldId
			, FieldType
			, CurrentFieldType
	FROM
			_PromptDataField_PromptChange_Exist

END



IF @PromptDataFieldUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, NewPromptType, DataFieldId, NewFieldType )
	SELECT 	'Unidentified'
			, OrgId
			, PromptId
			, NewPromptType
			, DataFieldId
			, FieldType
			
	FROM
			_PromptDataField_PromptChange_Unidentified

END



IF @PromptTypeUpdateV2 > 0	
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, NewPromptType, OldPromptType, DataFieldId )
	SELECT 	'PromptType Updated'
			, OrgId
			, PromptId
			, NewPromptType
			, OldPromptType
			, DataFieldId
	FROM
			_PromptId_NewPromptType_Update

END




IF @DataFieldUpdateV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, PromptId, DataFieldId, NewFieldType, OldFieldType )
	SELECT 	'FieldType Update'
			, OrgId
			, PromptId
			, DataFieldId
			, NewFieldType
			, OldFieldType
	FROM
			_DataFieldId_FieldType_Update

END
		




-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results
CREATE TABLE ##SurveyResponseAnswerStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseAnswerStatus_Results ( Item, Criteria )
SELECT 'Server Name'								, @serverNameV2
UNION ALL
SELECT 'Delivery Email'								, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'							, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'									, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Org Prompt DataField Combo Bad'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @OrgPromptDataFieldCombinationBadV2 , 0)						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicate Prompts'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicatePromptV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicate DataFields'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateDataFieldV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Prompt DataFields Exist'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PromptDataFieldExistV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Prompt DataFields Unidentified'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PromptDataFieldUnidentifiedV2 , 0)    						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'PromptType    Updates Requested'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PromptTypeUpdateV2 , 0)    										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'PromptType    Successful Updates'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulPromptTypeUpdates , 0)   							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'FieldType     Updates Requested'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @DataFieldUpdateV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'FieldType     Successful Updates'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulFieldTypeUpdate , 0)   							AS money)), 1), '.00', '')	
UNION ALL



SELECT 'Processing Complete'						, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'						, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'Prompt_PromptType_DataField_FieldType_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, OrgId
										, PromptId
										, NewPromptType
										, OldPromptType
										, DataFieldId
										, NewFieldType
										, OldFieldType
												
								FROM 
										##PromptDataFieldStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseAnswerStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Prompt PromptType DataField FieldType Update
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
--, @copy_recipients 				= 'tpeterson@InMoment.com'
, @copy_recipients 				= 'tpeterson@InMoment.com; bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Prompt PromptType DataField FieldType Update Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= ','
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'oltp'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	

END

GOTO CLEANUP



	
CLEANUP:

	PRINT 'Cleaning up temp tables'


IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange') AND type = (N'U'))										DROP TABLE _PromptDataField_PromptChange
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_BadOrgPromptDataFieldCombination') AND type = (N'U'))		DROP TABLE _PromptDataField_PromptChange_BadOrgPromptDataFieldCombination
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_DuplicatePrompt') AND type = (N'U'))						DROP TABLE _PromptDataField_PromptChange_DuplicatePrompt
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_DuplicateDataField') AND type = (N'U'))    					DROP TABLE _PromptDataField_PromptChange_DuplicateDataField

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptId_NewPromptType_Update') AND type = (N'U'))    									DROP TABLE _PromptId_NewPromptType_Update		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataFieldId_FieldType_Update') AND type = (N'U'))    									DROP TABLE _DataFieldId_FieldType_Update		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_Exist') AND type = (N'U'))  								DROP TABLE _PromptDataField_PromptChange_Exist		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_PromptDataField_PromptChange_Unidentified') AND type = (N'U'))    						DROP TABLE _PromptDataField_PromptChange_Unidentified
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Prompt_DataField_NewPromptType_Statistics') AND type = (N'U'))    						DROP TABLE _Prompt_DataField_NewPromptType_Statistics




IF OBJECT_ID('tempdb..##PromptDataField_PromptChange') IS NOT NULL			DROP TABLE ##PromptDataField_PromptChange
IF OBJECT_ID('tempdb..##PromptDataFieldStatus_Action') IS NOT NULL			DROP TABLE ##PromptDataFieldStatus_Action
IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results

	PRINT 'Cleanup is complete'



	
-- For Debugging; Table by Table Verification	
--SELECT *	FROM _PromptDataField_PromptChange
--SELECT *	FROM _PromptDataField_PromptChange_BadOrgPromptDataFieldCombination
--SELECT *	FROM _PromptDataField_PromptChange_DuplicatePrompt
--SELECT *	FROM _PromptDataField_PromptChange_DuplicateDataField
--SELECT *	FROM _PromptId_NewPromptType_Update
--SELECT *	FROM _DataFieldId_FieldType_Update
--SELECT *	FROM _PromptDataField_PromptChange_Exist
--SELECT *	FROM _PromptDataField_PromptChange_Unidentified

	
	
	
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
