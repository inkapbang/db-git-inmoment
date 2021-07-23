SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_DataField_ReportLabelChange_AutoDelivery]
		@deliveryEmail	varchar(100)	= NULL
		, @FileName		varchar(100)	= NULL
		
		, @answer		varchar(10)		= NULL		

		
AS


/************** DataField Report Label Change  **************

	Comments

		Updates LocalizedStringValue.value
		from a provided file for a listed localeKey
		
		Executed against OLTP only

		Note: Executing these SP without any parameters will
		print out requirements.
		
		sp_DataField_ReportLabelChange_AutoDelivery
			@DeliveryEmail	= ''''
			, @FileName		= ''''
	


	History
		00.00.0000	Tad Peterson
			-- created 

		00.00.0000	Tad Peterson
			-- added textValue and NumericValue

		09.09.2014	Tad Peterson
			-- added comment type support

		10.04.2016  TAR
			-- altered heavily to provide new process
	
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
	
		PRINT 'DataField Report Label change'
		PRINT CHAR(9) + 'Description: '
		PRINT CHAR(9) + CHAR(9) + 'Changes LocalizedStringValue.value for a DataField '
		PRINT CHAR(9) + CHAR(9) + 'based on a localeKey. '
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
		PRINT CHAR(9) + 'DataField ID'
		PRINT CHAR(9) + 'ReportLabel'
		PRINT CHAR(9) + 'LocaleKey'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a form to fill out, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_DataField_ReportLabelChange_AutoDelivery'
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
, @subject			= 'DataField Report Label Change Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.


File Setup & Contents Example
------------------------------

OrgId		DataFieldId		ReportLabel		LocaleKey
876		72643		Satisfaction		en_US
678		72644		Service		en_US


Notes & Comments
-----------------
	
	*Notice*
	1. Please be aware of proper file setup (order) to ensure successful processing.
	2. Change your original spreadsheet to NOT have ANY commas.  ie. general formatting for numbers.
	3. File should be in CSV format.
	4. Please make sure your file is attached to return email.





Return Email
-------------

sp_DataField_ReportLabelChange_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''file name here''
		

		
		
-- Example Below --

sp_DataField_ReportLabelChange_AutoDelivery
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange') AND type = (N'U'))    DROP TABLE _DataField_ReportLabelChange
CREATE TABLE _DataField_ReportLabelChange
		(
			OrgId				bigint
			, DataFieldId		int	
			, ReportLabel		nvarchar(max)
			, LocaleKey			varchar(25)	
		)


DECLARE @FileNameBulkInsertStatement	nvarchar(max)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _DataField_ReportLabelChange   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

--SELECT @FileNameBulkInsertStatement

EXECUTE (@FileNameBulkInsertStatement)


--testing
--select * from _DataField_ReportLabelChange


			
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _DataField_ReportLabelChange	)
			

--SELECT @originalFileSize

DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _DataField_ReportLabelChange	WHERE OrgId IS NULL	OR	DataFieldId IS NULL	OR  ReportLabel IS NULL	OR LocaleKey IS NULL )


--SELECT @nullCount

-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _DataField_ReportLabelChange
	WHERE
			OrgId 			IS NULL
		OR
			DataFieldId 		IS NULL
		OR
			ReportLabel 	IS NULL
		OR
			LocaleKey 	IS NULL
			
END			






-- Verifies Org, Prompt and DataField combination are legit
DECLARE @OrgDataFieldCombinationBad	int
SET		@OrgDataFieldCombinationBad	= 
												(
													SELECT
															COUNT(1)
													FROM
															_DataField_ReportLabelChange	t01
														LEFT JOIN
															(
																SELECT
																		t101.objectId		AS OrgId
																		, t103.objectId		AS DataFieldId
																FROM
																		organization		t101
																	JOIN
																		dataField			t103
																				ON t103.organizationobjectId = t101.objectid
															) AS t100
																	ON t01.OrgId = t100.OrgId AND t01.DataFieldId = t100.DataFieldId
														
													WHERE
															t100.OrgId IS NULL		
												)


										
										
										
										
-- Non legit Org, Prompt and DataField combination; preserved and deleted
IF @OrgDataFieldCombinationBad > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_BadOrgDataFieldCombination') AND type = (N'U'))    DROP TABLE _DataField_ReportLabelChange_BadOrgDataFieldCombination	
	SELECT
			t01.OrgId
			, t01.DataFieldId						
	INTO _DataField_ReportLabelChange_BadOrgDataFieldCombination	
	FROM
			_DataField_ReportLabelChange	t01
		LEFT JOIN
			(
				SELECT
						t101.objectId		AS OrgId
						, t103.objectId		AS DataFieldId
				FROM
						organization		t101
					JOIN
						dataField			t103
								ON t101.objectId = t103.organizationObjectId
			) AS t100
					ON t01.OrgId = t100.OrgId AND t01.DataFieldId = t100.DataFieldId
		
	WHERE
			t100.OrgId IS NULL		
	
	
	

	-- Delete Step
	DELETE	t01
	FROM	
			_DataField_ReportLabelChange					t01
		JOIN
			_DataField_ReportLabelChange_BadOrgDataFieldCombination		t02
					ON t01.OrgId = t02.OrgId AND t01.DataFieldId = t02.DataFieldId

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
																_DataField_ReportLabelChange	t01

														GROUP BY 
																DataFieldId
														HAVING	COUNT(1) > 1
													) AS t101
													
											)



IF @duplicateCheckDataField	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_DuplicateDataField') AND type = (N'U'))    DROP TABLE _DataField_ReportLabelChange_DuplicateDataField
	SELECT
			t01.OrgId
			, t01.DataFieldId
	INTO _DataField_ReportLabelChange_DuplicateDataField		
	FROM
			_DataField_ReportLabelChange	t01
		JOIN
			(
				SELECT
					DataFieldId
						
				FROM
						_DataField_ReportLabelChange	t101

				GROUP BY 
						DataFieldId
				HAVING	COUNT(1) > 1
			) AS t100
					ON t01.DataFieldId = t100.DataFieldId

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_DataField_ReportLabelChange						t01
		JOIN
			_DataField_ReportLabelChange_DuplicateDataField	t02
						ON	
							t01.OrgId			= t02.OrgId
						AND
							t01.DataFieldId		= t02.DataFieldId	
							
							
END




--DataField List and Preserve
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataFieldId_FieldType_Update') AND type = (N'U'))    DROP TABLE _DataFieldId_FieldType_Update		
SELECT
		OrgId
		, DataFieldId
		, ReportLabel
		, t01.LocaleKey
		, t03.LocalizedStringObjectId

INTO	_DataFieldId_FieldType_Update	
		
FROM
		_DataField_ReportLabelChange				t01
	JOIN
		DataField									t02
				ON t01.DataFieldId = t02.objectId
	JOIN
		LocalizedStringValue				t03
				ON
					t01.LocaleKey		= t03.LocaleKey
				AND
					t02.LabelObjectId	= t03.LocalizedStringObjectId



		
	-- Deletes from original table
	DELETE	t01
	FROM
			_DataField_ReportLabelChange		t01
		JOIN
			_DataFieldId_FieldType_Update		t02
					ON 
							t01.OrgId 			= t02.OrgId
						AND
							t01.DataFieldId		= t02.DataFieldId








--Checks for existing records
DECLARE @promptIdDataFieldExist	int
SET 	@promptIdDataFieldExist	= 
									(
										SELECT
												COUNT(1)
										FROM
												_DataField_ReportLabelChange		t01
											JOIN
												DataField							t03
														ON 
															t01.DataFieldId 	= t03.objectId
											JOIN
												LocalizedStringValue				t02
														ON
															t01.LocaleKey		= t02.LocaleKey
														AND
															t03.LabelObjectId	= t02.LocalizedStringObjectId
														AND 
															t02.value			= t01.ReportLabel
									
									)






IF @promptIdDataFieldExist > 0
BEGIN

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_Exist') AND type = (N'U'))    DROP TABLE _DataField_ReportLabelChange_Exist		
SELECT
		t01.OrgId
		, t01.DataFieldId
		, t01.ReportLabel
		
INTO 	_DataField_ReportLabelChange_Exist	
		
FROM
		_DataField_ReportLabelChange		t01
	JOIN
		DataField							t03
				ON 
					t01. DataFieldId 	= t03.objectId
	JOIN
		LocalizedStringValue				t02
				ON
					t01.LocaleKey		= t02.LocaleKey
				AND
					t03.LabelObjectId	= t02.LocalizedStringObjectId
				AND 
					t02.value			= t01.ReportLabel
				



	-- Deletes from origianl table
	DELETE	t01
	FROM
			_DataField_ReportLabelChange		t01
		JOIN
			_DataField_ReportLabelChange_Exist	t02
				ON
					t01.OrgId			= t02.OrgId
				AND
					t01.DataFieldId		= t02.DataFieldId



END






-- Identifies any remaining rows in original file
DECLARE @DataFieldUnidentified		int
SET		@DataFieldUnidentified		= ( SELECT COUNT(1)	FROM _DataField_ReportLabelChange )


IF @DataFieldUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_Unidentified') AND type = (N'U'))    DROP TABLE _DataField_ReportLabelChange_Unidentified
	SELECT
			*
	INTO _DataField_ReportLabelChange_Unidentified
	FROM
		_DataField_ReportLabelChange
		
		
		
		
	-- Deletes Exist
	DELETE	t01
	FROM
			_DataField_ReportLabelChange				t01
		JOIN
			_DataField_ReportLabelChange_Unidentified	t02
					ON	
							t01.OrgId			= t02.OrgId
						AND 
							t01.DataFieldId	= t02.DataFieldId
		
	
END




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
		, orgDataFieldCombinationBad						int
		, DuplicateDataField								int
		, DataFieldExist									int
		, DataFieldUnidentified								int
		, DataFieldUpdate									int
		, processingStart									dateTime
		, processingComplete								dateTime

	)		

	
INSERT INTO _Prompt_DataField_NewPromptType_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, orgDataFieldCombinationBad, DuplicateDataField, DataFieldExist, DataFieldUnidentified, DataFieldUpdate )
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @OrgDataFieldCombinationBad, @duplicateCheckDataField, @promptIdDataFieldExist, @DataFieldUnidentified, @DataFieldUpdateCount






-- Results Print Out
PRINT 'Original CSV Row Count                         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@originalFileSize								,	0	)   	AS money)), 1), '.00', '')
PRINT 'NULL Values Found                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@nullCount										,	0	)   	AS money)), 1), '.00', '')
PRINT 'Org Prompt DataField Combination Bad           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@OrgDataFieldCombinationBad								,	0	)		AS money)), 1), '.00', '')
PRINT 'Duplicate DataFields                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@duplicateCheckDataField									,	0	)   	AS money)), 1), '.00', '')
PRINT 'Prompt DataField Exist                         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@promptIdDataFieldExist									,	0	)   	AS money)), 1), '.00', '')
PRINT 'Records Unidentified                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@DataFieldUnidentified	,	0	)		AS money)), 1), '.00', '')
PRINT 'DataField Updates                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		ISNULL(	@DataFieldUpdateCount	,	0	)		AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_DataField_ReportLabelChange_AutoDelivery @answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_DataField_ReportLabelChange_AutoDelivery @answer = ''terminate'''




		
RETURN
END








											




--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN


	DECLARE @DataFieldUpdateCheck		int
	SET		@DataFieldUpdateCheck		= ( SELECT DataFieldUpdate		FROM _Prompt_DataField_NewPromptType_Statistics )

	
	UPDATE _Prompt_DataField_NewPromptType_Statistics
	SET processingStart = GETDATE()

	
	--If statements for Cursors Here
	IF @DataFieldUpdateCheck > 0
	BEGIN
	
		PRINT 'DataField FieldType Updating ' + CAST(@DataFieldUpdateCheck AS varchar) + ' records'
	
		/**************************  Comment CommentText Update  **************************/

		-----Cursor for DataField ReportLabel Update

		DECLARE @countV2 bigint, @DataFieldObjectIdV2 bigint, @LocalizedStringObjectIdV2 bigint
			, @LocaleKeyV2 varchar(25), @ReportLabelV2 nvarchar(max)

		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT DataFieldId, ReportLabel, LocaleKey, LocalizedStringObjectId  FROM _DataFieldId_FieldType_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @DataFieldObjectIdV2, @ReportLabelV2, @LocaleKeyV2, @LocalizedStringObjectIdV2

		WHILE @@Fetch_Status = 0
		BEGIN

		
		PRINT cast(@countV2 as varchar)+', '+cast(@DataFieldObjectIdV2 as varchar)+', '+cast(@LocaleKeyV2 as varchar)+', '+cast(@LocalizedStringObjectIdV2 as varchar)


		----******************* W A R N I N G***************************


		UPDATE	LocalizedStringValue		WITH (ROWLOCK)
		SET		Value						= @ReportLabelV2
		WHERE		LocalizedStringObjectId 	= @LocalizedStringObjectIdV2
		AND		LocaleKey					= @LocaleKeyV2


		----***********************************************************

		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @DataFieldObjectIdV2, @ReportLabelV2, @LocaleKeyV2, @LocalizedStringObjectIdV2

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@countV2 as varchar)+' Records Processed'


		/**************************************************************************************************/



		PRINT ''	
		PRINT 'Update DataField ReportLabel Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Updates'
						
		
		DECLARE @successfulFieldTypeUpdate		int
		SET		@successfulFieldTypeUpdate		= ( SELECT COUNT(1)		FROM _DataFieldId_FieldType_Update	t01		JOIN DataField	t02		ON t01.DataFieldId = t02.objectId )
		
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
IF @DataFieldUpdateCheck > 0  
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE	@DeliveryEmailV2									varchar(100)
		, @inputFileNameV2									varchar(100)
		, @serverNameV2										varchar(25)
		, @originalCountV2									int
		, @nullCountV2										int
		, @orgDataFieldCombinationBadV2						int
		, @DuplicateDataFieldV2								int
		, @PromptDataFieldExistV2							int
		, @PromptDataFieldUnidentifiedV2					int
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
SET @OrgDataFieldCombinationBadV2 							= ( SELECT orgDataFieldCombinationBad			FROM _Prompt_DataField_NewPromptType_Statistics )
SET @duplicateDataFieldV2									= ( SELECT DuplicateDataField					FROM _Prompt_DataField_NewPromptType_Statistics )
SET @PromptDataFieldExistV2									= ( SELECT DataFieldExist					FROM _Prompt_DataField_NewPromptType_Statistics )
SET @PromptDataFieldUnidentifiedV2							= ( SELECT DataFieldUnidentified			FROM _Prompt_DataField_NewPromptType_Statistics )
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
		, DataFieldId			int
		, ReportLabel			nvarchar(max)
	)


IF @OrgDataFieldCombinationBadV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, DataFieldId )
	SELECT 	'Org Prompt DataField Combination Bad'
			, OrgId
			, DataFieldId	
			
	FROM
			_DataField_ReportLabelChange_BadOrgDataFieldCombination
END



--Need Dyuplicate Record




IF @duplicateDataFieldV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, DataFieldId )
	SELECT 	'Duplicate DataFields'
		, OrgId
		, DataFieldId
			
	FROM
			_DataField_ReportLabelChange_DuplicateDataField

END



IF @PromptDataFieldExistV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, DataFieldId, ReportLabel )
	SELECT  'Prompt DataField Records Exist'
			, OrgId
			, DataFieldId
			, ReportLabel
	FROM
			_DataField_ReportLabelChange_Exist

END



IF @PromptDataFieldUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, DataFieldId )
	SELECT 	'Unidentified'
			, OrgId
			, DataFieldId
			
	FROM
			_DataField_ReportLabelChange_Unidentified

END



IF @DataFieldUpdateV2 > 0
BEGIN
	INSERT INTO ##PromptDataFieldStatus_Action ( Action, OrgId, DataFieldId )
	SELECT 	'FieldType Update'
			, OrgId
			, DataFieldId
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
SELECT 'Org DataField Combo Bad'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @OrgDataFieldCombinationBadV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicate DataFields'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateDataFieldV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'DataFields Exist'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PromptDataFieldExistV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'DataFields Unidentified'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PromptDataFieldUnidentifiedV2 , 0)    						AS money)), 1), '.00', '')	
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
										, DataFieldId
												
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
DataField ReportLabel Update
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
, @subject						= 'DataField ReportLabel Update Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= ','
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'OLTP'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	

END

GOTO CLEANUP



	
CLEANUP:

	PRINT 'Cleaning up temp tables'


IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange') AND type = (N'U'))										DROP TABLE _DataField_ReportLabelChange
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_BadOrgDataFieldCombination') AND type = (N'U'))		DROP TABLE _DataField_ReportLabelChange_BadOrgDataFieldCombination
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_DuplicateDataField') AND type = (N'U'))    					DROP TABLE _DataField_ReportLabelChange_DuplicateDataField

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataFieldId_FieldType_Update') AND type = (N'U'))    									DROP TABLE _DataFieldId_FieldType_Update		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_Exist') AND type = (N'U'))  								DROP TABLE _DataField_ReportLabelChange_Exist		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DataField_ReportLabelChange_Unidentified') AND type = (N'U'))    						DROP TABLE _DataField_ReportLabelChange_Unidentified
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Prompt_DataField_NewPromptType_Statistics') AND type = (N'U'))    						DROP TABLE _Prompt_DataField_NewPromptType_Statistics




IF OBJECT_ID('tempdb..##PromptDataField_PromptChange') IS NOT NULL			DROP TABLE ##PromptDataField_PromptChange
IF OBJECT_ID('tempdb..##PromptDataFieldStatus_Action') IS NOT NULL			DROP TABLE ##PromptDataFieldStatus_Action
IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results

	PRINT 'Cleanup is complete'



--*/		

	
-- For Debugging; Table by Table Verification	
--SELECT *	FROM _DataField_ReportLabelChange
--SELECT *	FROM _DataField_ReportLabelChange_BadOrgPromptDataFieldCombination
--SELECT *	FROM _DataField_ReportLabelChange_DuplicatePrompt
--SELECT *	FROM _DataField_ReportLabelChange_DuplicateDataField
--SELECT *	FROM _PromptId_NewPromptType_Update
--SELECT *	FROM _DataFieldId_FieldType_Update
--SELECT *	FROM _DataField_ReportLabelChange_Exist
--SELECT *	FROM _DataField_ReportLabelChange_Unidentified

	
	
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
