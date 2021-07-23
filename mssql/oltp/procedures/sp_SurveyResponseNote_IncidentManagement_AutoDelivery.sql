SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_SurveyResponseNote_IncidentManagement_AutoDelivery
CREATE Procedure [dbo].[sp_SurveyResponseNote_IncidentManagement_AutoDelivery]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		

AS
	
/****************  Set Exclusion Reason Auto Deliver  ****************

	Note Tested Yet! --Tested With live data 5/23/2012; successful.

	Execute on OLTP.
	
	sp_SurveyResponseNote_IncidentManagement_AutoDelivery		
		@deliveryEmail			= 'tpeterson@mshare.net'
		, @FileName				= NULL

		, @answer				= NULL		

	
********************************************************************/

SET NOCOUNT ON

DECLARE @answerCheck							int
SET		@answerCheck							= CASE	WHEN @answer IS NULL 		THEN 0
														WHEN @answer = 'EXECUTE'	THEN 1
													ELSE 2
													END


DECLARE @deliveryEmailCheck						int
SET		@deliveryEmailCheck						= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
														WHEN LEN(@deliveryEmail) = 0	THEN 0
														WHEN LEN(@deliveryEmail) > 0	THEN 1
													END
									

DECLARE @FileNameCheck							int
SET		@FileNameCheck							= CASE	WHEN LEN(@FileName) IS NULL 	THEN 0
														WHEN LEN(@FileName) = 0			THEN 0
														WHEN LEN(@FileName) > 0			THEN 1
													END
										
										


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @StateTypeCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Survey Response Note Incident Management Update'
		PRINT CHAR(9) + 'Description:  Updates StateType based on a ResponseId & StateType value from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides a list of StateTypes to the requestor.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor list of the stateType and their values. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'StateType'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the exclusion reason list in order for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponseNote_IncidentManagement_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		
	RETURN
	END		






-- Sends StateType Answers
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Incident Management StateType Request'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



StateType  List
----------------------

	0     Open
	1     In Progress
	2     Closed



File Setup & Contents Example
------------------------------

SurveyResponseId	StateType
103090587		2
103090588		2
123456789		1





Notes & Comments
-----------------
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponseNote_IncidentManagement_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_SurveyResponseNote_IncidentManagement_AutoDelivery
	@DeliveryEmail	= ''tpeterson@mshare.net''
	, @FileName		= ''FastTrackIncidentManagement.csv''
		



		
'		
;

	
RETURN	
END		
	
	
	
	
	
	
	
	
	
/*******************************************************************  Upload & Processing Portion  *******************************************************************/

-- Upload and Process Statistics
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 1	


BEGIN

SET NOCOUNT ON 

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType
CREATE TABLE _surveyResponseNote_StateType
		(
			SurveyResponseId			bigint
			, StateType					int	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponseNote_StateType   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponseNote_StateType	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponseNote_StateType	WHERE SurveyResponseId IS NULL	OR	StateType IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponseNote_StateType
	WHERE
			SurveyResponseId	IS NULL
		OR
			StateType			IS NULL
			
END			




-- Verifies StateType is legit
DECLARE @notLegitStateType		int
SET		@notLegitStateType		= 
											(
												SELECT
														COUNT(1)
												FROM
														_surveyResponseNote_StateType		t01
														
												WHERE
														t01.StateType NOT IN ( 0, 1, 2 )
											)

--SELECT @notLegitStateType



-- Non legit StateType; preserved and deleted
IF @notLegitStateType > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_BadStateType') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_BadStateType
	SELECT
			SurveyResponseId
			, StateType
	INTO _surveyResponseNote_StateType_BadStateType
	FROM
			_surveyResponseNote_StateType			t01
	WHERE
			t01.StateType NOT IN ( 0, 1, 2 )

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseNote_StateType			t01
	WHERE
			t01.StateType NOT IN ( 0, 1, 2 )

END




DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseNote_StateType		t01
												LEFT JOIN
													SurveyResponseNote					t02	WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.SurveyResponseObjectId
											WHERE
													t02.SurveyResponseObjectId IS NULL		
										)

--SELECT @notLegitSurveyResponseId


-- Non legit SurveyResponseIds; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, t01.StateType
	INTO _surveyResponseNote_StateType_BadSurveyResponseId
	FROM
			_surveyResponseNote_StateType							t01
		LEFT JOIN
			SurveyResponseNote										t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.SurveyResponseObjectId
	WHERE
			t02.SurveyResponseObjectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseNote_StateType							t01
		JOIN
			_surveyResponseNote_StateType_BadSurveyResponseId		t02
					ON t01.SurveyResponseId = t02.SurveyResponseId

END



-- Checks for Duplicates
DECLARE @duplicateCheck		int
SET		@duplicateCheck		= 
								(
									SELECT
											COUNT(1)
									FROM
										(		

											SELECT
													SurveyResponseId
													, StateType
											FROM
													_surveyResponseNote_StateType		t01
											GROUP BY 
													SurveyResponseId
													, StateType
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_Duplicates
	SELECT
			SurveyResponseId
			, StateType
	INTO _surveyResponseNote_StateType_Duplicates		
	FROM
			_surveyResponseNote_StateType				t01

	GROUP BY 
			SurveyResponseId
			, StateType
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponseNote_StateType				t01
		JOIN
			_surveyResponseNote_StateType_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.StateType		= t02.StateType

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponseNote_StateType ( SurveyResponseId, StateType )
	SELECT
			SurveyResponseId
			, StateType
	FROM
			_surveyResponseNote_StateType_Duplicates			


END



-- Checks for existing records
DECLARE @surveyResponseStateTypeExist	int
SET		@surveyResponseStateTypeExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseNote_StateType		t01
																	JOIN
																		SurveyResponseNote					t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.StateType			= t02.StateType
															)


--SELECT @surveyResponseStateTypeExist


-- Removes existing records; preserve and removes
IF @surveyResponseStateTypeExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Exist') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_Exist
	SELECT
			SurveyResponseId
			, t01.StateType
			, t02.objectId 				AS SurveyResponseNoteObjectId
			
	INTO _surveyResponseNote_StateType_Exist
	FROM
			_surveyResponseNote_StateType		t01
		JOIN
			SurveyResponseNote					t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.StateType			= t02.StateType

	-- Deletes Exist
	DELETE	t01
	FROM
			_surveyResponseNote_StateType			t01
		JOIN
			_surveyResponseNote_StateType_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.StateType			= t02.StateType
					


END




DECLARE @surveyResponseStateTypeUpdate	int
SET		@surveyResponseStateTypeUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseNote_StateType		t01
																	JOIN
																		SurveyResponseNote					t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.StateType			!= t02.StateType
															)


-- Seperates updating records; preserve and removes
IF @surveyResponseStateTypeUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Update') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_Update
	SELECT
			SurveyResponseId
			, t01.StateType
			, t02.StateType						AS StateType_Old
			, t02.objectId						AS SurveyResponseNoteObjectId

			
	INTO _surveyResponseNote_StateType_Update
	FROM
			_surveyResponseNote_StateType				t01
		JOIN
			SurveyResponseNote							t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.StateType			!= t02.StateType

	-- Deletes Updates
	DELETE	t01
	FROM
			_surveyResponseNote_StateType				t01
		JOIN
			_surveyResponseNote_StateType_Update		t02
					ON	
							t01.SurveyResponseId		= t02.SurveyResponseId
						AND
							t01.StateType				= t02.StateType
					


END








-- Identifies any remaining rows in original file
DECLARE @surveyResponseStateTypeUnidentified		int
SET		@surveyResponseStateTypeUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponseNote_StateType )


IF @surveyResponseStateTypeUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_Unidentified
	SELECT
			*
	INTO _surveyResponseNote_StateType_Unidentified
	FROM
		_surveyResponseNote_StateType
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponseNote_StateType_Statistics
CREATE TABLE _surveyResponseNote_StateType_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitStateType										int
		, notLegitSurveyResponseId								int
		, duplicateCheck										int
		, surveyResponseStateTypeExist							int
		, surveyResponseStateTypeUpdate							int
		, surveyResponseStateTypeUnidentified					int
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _surveyResponseNote_StateType_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitStateType, notLegitSurveyResponseId, duplicateCheck, surveyResponseStateTypeExist, surveyResponseStateTypeUpdate, surveyResponseStateTypeUnidentified )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitStateType, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseStateTypeExist , @surveyResponseStateTypeUpdate, @surveyResponseStateTypeUnidentified




-- Results Print Out
PRINT 'Survey Response Exclusion Reason Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   					AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   							AS money)), 1), '.00', '')
PRINT 'Non Legit StateType                      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitStateType						AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId				AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   						AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseStateTypeExist   		AS money)), 1), '.00', '')
PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseStateTypeUpdate   		AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseStateTypeUnidentified   	AS money)), 1), '.00', '')

PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseNote_IncidentManagement_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponseNote_IncidentManagement_AutoDelivery	@answer = ''terminate'''

RETURN

END





--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN
	
	DECLARE @SrExUpdateCheck		int
	SET		@SrExUpdateCheck		= ( SELECT surveyResponseStateTypeUpdate		FROM _surveyResponseNote_StateType_Statistics )
	


	UPDATE	_surveyResponseNote_StateType_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @SrExUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@SrExUpdateCheck AS varchar) + ' records'
	


		/**************  Survey Response Exclusion Reason Update  **************/

		DECLARE @count int, @SurveyResponseNoteObjectId bigInt, @StateType int

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseNoteObjectId, StateType 	FROM _surveyResponseNote_StateType_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseNoteObjectId, @StateType

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseNoteObjectId as varchar)+', '+cast(@StateType as varchar)


		----******************* W A R N I N G***************************


		UPDATE SurveyResponseNote WITH (ROWLOCK)
		SET StateType = @StateType
		WHERE objectId = @SurveyResponseNoteObjectId


		----***********************************************************

		SET @count = @count+1
		FETCH next FROM mycursor INTO @SurveyResponseNoteObjectId, @StateType

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _surveyResponseNote_StateType_Update	t01		JOIN SurveyResponseNote t02	WITH (NOLOCK) 	ON t01.SurveyResponseNoteObjectId = t02.ObjectId AND t01.StateType = t02.StateType )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@SrExUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	UPDATE	_surveyResponseNote_StateType_Statistics
	SET		processingComplete = GETDATE()
	
	
	GOTO PROCESSING_COMPLETE		

END




IF @answerCheck = 2
BEGIN

	PRINT 'Terminating Script'
	PRINT ''

	
GOTO CLEANUP
END



PROCESSING_COMPLETE:
IF @SrExUpdateCheck > 0 
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitStateTypeV2										int
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @surveyResponseStateTypeExistV2							int
		, @surveyResponseStateTypeUpdateV2							int
		, @surveyResponseStateTypeUnidentifiedV2					int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2								= ( SELECT deliveryEmail									FROM _surveyResponseNote_StateType_Statistics )
SET @inputFileNameV2								= ( SELECT inputFileName									FROM _surveyResponseNote_StateType_Statistics )
SET @serverNameV2									= ( SELECT serverName										FROM _surveyResponseNote_StateType_Statistics )
SET @originalCountV2								= ( SELECT originalCount									FROM _surveyResponseNote_StateType_Statistics )
SET @nullCountV2									= ( SELECT nullCount										FROM _surveyResponseNote_StateType_Statistics )
SET @notLegitStateTypeV2 							= ( SELECT notLegitStateType								FROM _surveyResponseNote_StateType_Statistics )
SET @notLegitSurveyResponseIdV2						= ( SELECT notLegitSurveyResponseId							FROM _surveyResponseNote_StateType_Statistics )
SET @duplicateCheckV2								= ( SELECT duplicateCheck									FROM _surveyResponseNote_StateType_Statistics )
SET @surveyResponseStateTypeExistV2					= ( SELECT surveyResponseStateTypeExist						FROM _surveyResponseNote_StateType_Statistics )
SET @surveyResponseStateTypeUpdateV2				= ( SELECT surveyResponseStateTypeUpdate					FROM _surveyResponseNote_StateType_Statistics )
SET @surveyResponseStateTypeUnidentifiedV2			= ( SELECT surveyResponseStateTypeUnidentified				FROM _surveyResponseNote_StateType_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _surveyResponseNote_StateType_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _surveyResponseNote_StateType_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseStateTypeStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseStateTypeStatus_Action
CREATE TABLE ##SurveyResponseStateTypeStatus_Action
	(
		Action						varchar(50)
		, SurveyResponseId			bigInt
		, StateType					int
		, StateType_Old				int
		, SurveyResponseNoteId		bigInt
	)




IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseStateTypeStatus_Action ( Action, SurveyResponseId, StateType )
	SELECT 	'NonLegit SurveyResponseId'
		, SurveyResponseId
		, StateType	
			
	FROM
			_surveyResponseNote_StateType_BadSurveyResponseId
END


IF @notLegitStateTypeV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseStateTypeStatus_Action ( Action, SurveyResponseId, StateType )
	SELECT 	'NonLegit StateType Id'
			, SurveyResponseId
			, StateType	
			
	FROM
			_surveyResponseNote_StateType_BadStateType
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseStateTypeStatus_Action ( Action, SurveyResponseId, StateType )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, StateType	
			
	FROM
			_surveyResponseNote_StateType_Duplicates

END
		



IF @surveyResponseStateTypeExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseStateTypeStatus_Action ( Action, SurveyResponseId, StateType, SurveyResponseNoteId )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, StateType
		, SurveyResponseNoteObjectId
			
	FROM
			_surveyResponseNote_StateType_Exist

END




IF @surveyResponseStateTypeUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseStateTypeStatus_Action ( Action, SurveyResponseId, StateType )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, StateType	
			
	FROM
			_surveyResponseNote_StateType_Unidentified

END



IF @surveyResponseStateTypeUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseStateTypeStatus_Action ( Action, SurveyResponseId, StateType, StateType_Old, SurveyResponseNoteId )
	SELECT 	'Updated'
			, SurveyResponseId
			, StateType		
			, StateType_Old
			, SurveyResponseNoteObjectId
	FROM
			_surveyResponseNote_StateType_Update

END




		



-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseStateTypeStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseStateTypeStatus_Results
CREATE TABLE ##SurveyResponseStateTypeStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseStateTypeStatus_Results ( Item, Criteria )
SELECT 'Server Name'						, @serverNameV2
UNION ALL
SELECT 'Delivery Email'						, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'					, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit StateType'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitStateTypeV2 , 0)									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseStateTypeExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseStateTypeUnidentifiedV2 , 0)    	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseStateTypeUpdateV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponse_StateType_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, StateType									
										, StateType_Old
										, SurveyResponseNoteId
												
								FROM 
										##SurveyResponseStateTypeStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseStateTypeStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Survey Response Note Incident Management Update
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
--, @copy_recipients 				= 'tpeterson@mshare.net'
, @copy_recipients 				= 'tpeterson@mshare.net; bluther@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Survey Response Note Incident Management Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= ','
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	


END

GOTO CLEANUP






CLEANUP:

	PRINT 'Cleaning up temp tables'

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType') AND type = (N'U'))    						DROP TABLE _surveyResponseNote_StateType
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_BadStateType') AND type = (N'U'))    	DROP TABLE _surveyResponseNote_StateType_BadStateType
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_BadSurveyResponseId') AND type = (N'U'))    	DROP TABLE _surveyResponseNote_StateType_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Duplicates') AND type = (N'U'))    			DROP TABLE _surveyResponseNote_StateType_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Exist') AND type = (N'U'))    				DROP TABLE _surveyResponseNote_StateType_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Update') AND type = (N'U'))    				DROP TABLE _surveyResponseNote_StateType_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Unidentified') AND type = (N'U'))    			DROP TABLE _surveyResponseNote_StateType_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseNote_StateType_Statistics') AND type = (N'U'))    			DROP TABLE _surveyResponseNote_StateType_Statistics
	
	
	
	IF OBJECT_ID('tempdb..##SurveyResponseStateTypeStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseStateTypeStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseStateTypeStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseStateTypeStatus_Results

	
	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
