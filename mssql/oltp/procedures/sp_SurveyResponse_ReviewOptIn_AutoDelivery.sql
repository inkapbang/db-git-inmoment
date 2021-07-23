SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_SurveyResponse_ReviewOptIn_AutoDelivery
CREATE Procedure [dbo].[sp_SurveyResponse_ReviewOptIn_AutoDelivery]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		

AS
	
/****************  Set Review Opt In Auto Deliver  ****************

	Tested With live data 6/13/2012; successful.

	Execute on OLTP.
	
	sp_SurveyResponse_ReviewOptIn_AutoDelivery		
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
										
										


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @ReviewOptInCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Survey Response Review Opt In Update'
		PRINT CHAR(9) + 'Description:  Updates ReviewOptIn based on a ResponseId & ReviewOptIn from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides a list of review opt in to the requestor.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor list of the review opt in. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'ReviewOptIn'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the review opt in list in order for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponse_ReviewOptIn_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail  = ''Their Email Here'''
		
	RETURN
	END		






-- Sends Review Opt In Answers
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Review Opt In Request'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



Review Opt In List
----------------------

	0     FALSE
	1     TRUE





File Setup & Contents Example
------------------------------

SurveyResponseId	ReviewOptIn	
103090587		1
103090588		0
123456789		1





Notes & Comments
-----------------
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponse_ReviewOptIn_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_SurveyResponse_ReviewOptIn_AutoDelivery
	@DeliveryEmail	= ''tpeterson@mshare.net''
	, @FileName		= ''HertzReviewOptInBackfill.csv''
		



		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn
CREATE TABLE _surveyResponse_ReviewOptIn
		(
			SurveyResponseId			bigint
			, ReviewOptIn				int	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponse_ReviewOptIn   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponse_ReviewOptIn	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponse_ReviewOptIn	WHERE SurveyResponseId IS NULL	OR	ReviewOptIn IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponse_ReviewOptIn
	WHERE
			SurveyResponseId	IS NULL
		OR
			ReviewOptIn			IS NULL
			
END			




-- Verifies DataFieldOption is legit
DECLARE @notLegitReviewOptIn		int
SET		@notLegitReviewOptIn		= 
											(
												SELECT
														COUNT(1)
												FROM
														_surveyResponse_ReviewOptIn		t01
														
												WHERE
														t01.ReviewOptIn NOT IN ( 0, 1 )
											)

--SELECT @notLegitReviewOptIn



-- Non legit ReviewOptIn; preserved and deleted
IF @notLegitReviewOptIn > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_BadReviewOptIn') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_BadReviewOptIn
	SELECT
			SurveyResponseId
			, ReviewOptIn
	INTO _surveyResponse_ReviewOptIn_BadReviewOptIn
	FROM
			_surveyResponse_ReviewOptIn			t01
	WHERE
			t01.ReviewOptIn NOT IN ( 0, 1 )

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponse_ReviewOptIn			t01
	WHERE
			t01.ReviewOptIn NOT IN ( 0, 1 )

END




DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponse_ReviewOptIn							t01
												LEFT JOIN
													SurveyResponse										t02	WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitSurveyResponseId


-- Non legit SurveyResponseIds; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, t01.ReviewOptIn
	INTO _surveyResponse_ReviewOptIn_BadSurveyResponseId
	FROM
			_surveyResponse_ReviewOptIn								t01
		LEFT JOIN
			SurveyResponse											t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponse_ReviewOptIn							t01
		JOIN
			_surveyResponse_ReviewOptIn_BadSurveyResponseId		t02
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
													, ReviewOptIn
											FROM
													_surveyResponse_ReviewOptIn		t01
											GROUP BY 
													SurveyResponseId
													, ReviewOptIn
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_Duplicates
	SELECT
			SurveyResponseId
			, ReviewOptIn
	INTO _surveyResponse_ReviewOptIn_Duplicates		
	FROM
			_surveyResponse_ReviewOptIn				t01

	GROUP BY 
			SurveyResponseId
			, ReviewOptIn
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponse_ReviewOptIn				t01
		JOIN
			_surveyResponse_ReviewOptIn_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.ReviewOptIn			= t02.ReviewOptIn

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponse_ReviewOptIn ( SurveyResponseId, ReviewOptIn )
	SELECT
			SurveyResponseId
			, ReviewOptIn
	FROM
			_surveyResponse_ReviewOptIn_Duplicates			


END



-- Checks for existing records
DECLARE @surveyResponseReviewOptInExist	int
SET		@surveyResponseReviewOptInExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_ReviewOptIn				t01
																	JOIN
																		SurveyResponse							t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.ObjectId
																					AND
																						t01.ReviewOptIn			= t02.ReviewOptIn
															)


--SELECT @surveyResponseReviewOptInExist


-- Removes existing records; preserve and removes
IF @surveyResponseReviewOptInExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Exist') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_Exist
	SELECT
			SurveyResponseId
			, t01.ReviewOptIn
			
	INTO _surveyResponse_ReviewOptIn_Exist
	FROM
			_surveyResponse_ReviewOptIn				t01
		JOIN
			SurveyResponse							t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.ObjectId
						AND
							t01.ReviewOptIn			= t02.ReviewOptIn

	-- Deletes Exist
	DELETE	t01
	FROM
			_surveyResponse_ReviewOptIn				t01
		JOIN
			_surveyResponse_ReviewOptIn_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.ReviewOptIn			= t02.ReviewOptIn
					


END




DECLARE @surveyResponseReviewOptInUpdate	int
SET		@surveyResponseReviewOptInUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_ReviewOptIn				t01
																	JOIN
																		SurveyResponse							t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.ObjectId
																					AND
																						t01.ReviewOptIn			!= ISNULL(CAST( t02.reviewOptIn as int ), 77777777)		--allows NULLS to be set to zero
															)


-- Seperates updating records; preserve and removes
IF @surveyResponseReviewOptInUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Update') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_Update
	SELECT
			SurveyResponseId
			, t01.ReviewOptIn
			, t02.ReviewOptIn						AS ReviewOptIn_Old
			
	INTO _surveyResponse_ReviewOptIn_Update
	FROM
			_surveyResponse_ReviewOptIn				t01
		JOIN
			SurveyResponse							t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.ObjectId
						AND
							t01.ReviewOptIn			!= ISNULL(CAST( t02.reviewOptIn as int ), 77777777)		--allows NULLS to be set to zero

	-- Deletes Updates
	DELETE	t01
	FROM
			_surveyResponse_ReviewOptIn				t01
		JOIN
			_surveyResponse_ReviewOptIn_Update		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.ReviewOptIn			= t02.ReviewOptIn
					


END








-- Identifies any remaining rows in original file
DECLARE @surveyResponseReviewOptInUnidentified		int
SET		@surveyResponseReviewOptInUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponse_ReviewOptIn )


IF @surveyResponseReviewOptInUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_Unidentified
	SELECT
			*
	INTO _surveyResponse_ReviewOptIn_Unidentified
	FROM
		_surveyResponse_ReviewOptIn
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponse_ReviewOptIn_Statistics
CREATE TABLE _surveyResponse_ReviewOptIn_Statistics
	(
		DeliveryEmail										varchar(100)
		, inputFileName										varchar(100)
		, serverName										varchar(25)
		, originalCount										int
		, nullCount											int
		, notLegitReviewOptIn								int
		, notLegitSurveyResponseId							int
		, duplicateCheck									int
		, surveyResponseReviewOptInExist					int
		, surveyResponseReviewOptInUpdate					int
		, surveyResponseReviewOptInUnidentified				int
		, processingStart									dateTime
		, processingComplete								dateTime

	)		

INSERT INTO _surveyResponse_ReviewOptIn_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitReviewOptIn, notLegitSurveyResponseId, duplicateCheck, surveyResponseReviewOptInExist, surveyResponseReviewOptInUpdate, surveyResponseReviewOptInUnidentified )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitReviewOptIn, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseReviewOptInExist , @surveyResponseReviewOptInUpdate, @surveyResponseReviewOptInUnidentified




-- Results Print Out
PRINT 'Survey Response Review Opt In Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   						AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   								AS money)), 1), '.00', '')
PRINT 'Non Legit ReviewOptIn                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitReviewOptIn						AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId					AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   							AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseReviewOptInExist   			AS money)), 1), '.00', '')
PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseReviewOptInUpdate   			AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseReviewOptInUnidentified   	AS money)), 1), '.00', '')

PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponse_ReviewOptIn_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponse_ReviewOptIn_AutoDelivery	@answer = ''terminate'''

RETURN

END





--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN
	
	DECLARE @SrExUpdateCheck		int
	SET		@SrExUpdateCheck		= ( SELECT surveyResponseReviewOptInUpdate		FROM _surveyResponse_ReviewOptIn_Statistics )
	


	UPDATE	_surveyResponse_ReviewOptIn_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @SrExUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@SrExUpdateCheck AS varchar) + ' records'
	


		/**************  Survey Response Review Opt In Update  **************/

		DECLARE @count int, @SurveyResponseId bigInt, @ReviewOptIn bit

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, ReviewOptIn FROM _surveyResponse_ReviewOptIn_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseId, @ReviewOptIn

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseId as varchar)+', '+cast(@ReviewOptIn as varchar)


		----******************* W A R N I N G***************************


		UPDATE surveyResponse WITH (ROWLOCK)
		SET ReviewOptIn = @ReviewOptIn
		WHERE objectId = @SurveyResponseId


		----***********************************************************

		SET @count = @count+1
		FETCH next FROM mycursor INTO @SurveyResponseId, @ReviewOptIn

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _surveyResponse_ReviewOptIn_Update	t01		JOIN SurveyResponse t02	WITH (NOLOCK) 	ON t01.SurveyResponseId = t02.objectId AND t01.ReviewOptIn = t02.ReviewOptIn )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@SrExUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	UPDATE	_surveyResponse_ReviewOptIn_Statistics
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



DECLARE  @deliveryEmailV2										varchar(100)			
		, @inputFileNameV2										varchar(100)
		, @serverNameV2											varchar(25)
		, @originalCountV2										int
		, @nullCountV2											int
		, @notLegitReviewOptInV2								int
		, @notLegitSurveyResponseIdV2							int
		, @duplicateCheckV2										int
		, @surveyResponseReviewOptInExistV2						int
		, @surveyResponseReviewOptInUpdateV2					int
		, @surveyResponseReviewOptInUnidentifiedV2				int
		, @ProcessingStartV2									dateTime
		, @ProcessingCompleteV2									dateTime
		, @ProcessingDurationV2									varchar(25)


		, @Minutes												varchar(3)
		, @Seconds												varchar(3)		
				
		

SET @deliveryEmailV2								= ( SELECT deliveryEmail									FROM _surveyResponse_ReviewOptIn_Statistics )
SET @inputFileNameV2								= ( SELECT inputFileName									FROM _surveyResponse_ReviewOptIn_Statistics )
SET @serverNameV2									= ( SELECT serverName										FROM _surveyResponse_ReviewOptIn_Statistics )
SET @originalCountV2								= ( SELECT originalCount									FROM _surveyResponse_ReviewOptIn_Statistics )
SET @nullCountV2									= ( SELECT nullCount										FROM _surveyResponse_ReviewOptIn_Statistics )
SET @notLegitReviewOptInV2 							= ( SELECT notLegitReviewOptIn								FROM _surveyResponse_ReviewOptIn_Statistics )
SET @notLegitSurveyResponseIdV2						= ( SELECT notLegitSurveyResponseId							FROM _surveyResponse_ReviewOptIn_Statistics )
SET @duplicateCheckV2								= ( SELECT duplicateCheck									FROM _surveyResponse_ReviewOptIn_Statistics )
SET @surveyResponseReviewOptInExistV2				= ( SELECT surveyResponseReviewOptInExist					FROM _surveyResponse_ReviewOptIn_Statistics )
SET @surveyResponseReviewOptInUpdateV2				= ( SELECT surveyResponseReviewOptInUpdate					FROM _surveyResponse_ReviewOptIn_Statistics )
SET @surveyResponseReviewOptInUnidentifiedV2		= ( SELECT surveyResponseReviewOptInUnidentified			FROM _surveyResponse_ReviewOptIn_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _surveyResponse_ReviewOptIn_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _surveyResponse_ReviewOptIn_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseReviewOptInStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseReviewOptInStatus_Action
CREATE TABLE ##SurveyResponseReviewOptInStatus_Action
	(
		Action							varchar(50)
		, SurveyResponseId				bigInt
		, ReviewOptIn					int
		, ReviewOptIn_Old				int
	)




IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseReviewOptInStatus_Action ( Action, SurveyResponseId, ReviewOptIn )
	SELECT 	'NonLegit SurveyResponseId'
		, SurveyResponseId
		, ReviewOptIn	
			
	FROM
			_surveyResponse_ReviewOptIn_BadSurveyResponseId
END


IF @notLegitReviewOptInV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseReviewOptInStatus_Action ( Action, SurveyResponseId, ReviewOptIn )
	SELECT 	'NonLegit Review Opt In Id'
			, SurveyResponseId
			, ReviewOptIn	
			
	FROM
			_surveyResponse_ReviewOptIn_BadReviewOptIn
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseReviewOptInStatus_Action ( Action, SurveyResponseId, ReviewOptIn )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, ReviewOptIn	
			
	FROM
			_surveyResponse_ReviewOptIn_Duplicates

END
		



IF @surveyResponseReviewOptInExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseReviewOptInStatus_Action ( Action, SurveyResponseId, ReviewOptIn )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, ReviewOptIn	
			
	FROM
			_surveyResponse_ReviewOptIn_Exist

END




IF @surveyResponseReviewOptInUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseReviewOptInStatus_Action ( Action, SurveyResponseId, ReviewOptIn )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, ReviewOptIn	
			
	FROM
			_surveyResponse_ReviewOptIn_Unidentified

END



IF @surveyResponseReviewOptInUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseReviewOptInStatus_Action ( Action, SurveyResponseId, ReviewOptIn, ReviewOptIn_Old )
	SELECT 	'Updated'
			, SurveyResponseId
			, ReviewOptIn		
			, ReviewOptIn_Old
	FROM
			_surveyResponse_ReviewOptIn_Update

END




		



-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseReviewOptInStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseReviewOptInStatus_Results
CREATE TABLE ##SurveyResponseReviewOptInStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseReviewOptInStatus_Results ( Item, Criteria )
SELECT 'Server Name'						, @serverNameV2
UNION ALL
SELECT 'Delivery Email'						, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'					, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit ReviewOptIn'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitReviewOptInV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseReviewOptInExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseReviewOptInUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseReviewOptInUpdateV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponse_ReviewOptIn_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, ReviewOptIn									
										, ReviewOptIn_Old
												
								FROM 
										##SurveyResponseReviewOptInStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseReviewOptInStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Survey Response Review Opt In Update
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
, @subject						= 'Survey Response Review Opt In Completed'
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

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn') AND type = (N'U'))    						DROP TABLE _surveyResponse_ReviewOptIn
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_BadReviewOptIn') AND type = (N'U'))    		DROP TABLE _surveyResponse_ReviewOptIn_BadReviewOptIn
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_BadSurveyResponseId') AND type = (N'U'))    	DROP TABLE _surveyResponse_ReviewOptIn_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Duplicates') AND type = (N'U'))    			DROP TABLE _surveyResponse_ReviewOptIn_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Exist') AND type = (N'U'))    				DROP TABLE _surveyResponse_ReviewOptIn_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Update') AND type = (N'U'))    				DROP TABLE _surveyResponse_ReviewOptIn_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Unidentified') AND type = (N'U'))    			DROP TABLE _surveyResponse_ReviewOptIn_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ReviewOptIn_Statistics') AND type = (N'U'))    			DROP TABLE _surveyResponse_ReviewOptIn_Statistics
	
	
	
	IF OBJECT_ID('tempdb..##SurveyResponseReviewOptInStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseReviewOptInStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseReviewOptInStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseReviewOptInStatus_Results

	
	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
