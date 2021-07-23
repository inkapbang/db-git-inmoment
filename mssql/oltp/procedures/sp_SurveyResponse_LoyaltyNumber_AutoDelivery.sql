SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.sp_SurveyResponse_LoyaltyNumber_AutoDelivery
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		
		, @throttle				int		= 1

AS
	
/****************  Set Loyalty Number Auto Deliver  ****************

	Tested With live data 4/1/2013; successful.

	Execute on OLTP.
	
	sp_SurveyResponse_LoyaltyNumber_AutoDelivery		
		@deliveryEmail			= 'tpeterson@mshare.net'
		, @FileName				= NULL

		, @answer				= NULL	

	
	Histoy	
		10.06.2014	Tad Peterson
			-- added throttling
	
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
										
										
DECLARE @ThrottleCheck							int
SET		@ThrottleCheck							= CASE	WHEN @throttle IS NULL			THEN 1
														WHEN @throttle = 0 				THEN 0
													ELSE 1
													END
													

-- These are used for throttling														
DECLARE @message								nvarchar(200)
DECLARE @check									int
										

										
										
										

--SELECT 	@deliveryEmailCheck, @FileNameCheck, @LoyaltyNumberCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Survey Response Loyalty Number Update'
		PRINT CHAR(9) + 'Description:  Updates LoyaltyNumber based on a ResponseId & LoyaltyNumber from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''		
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor list of the Loyalty Numbers. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'LoyaltyNumber'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the Loyalty Number list in order for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponse_LoyaltyNumber_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		
	RETURN
	END		






-- Sends Loyalty Numbers Answers
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Loyalty Number Request'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseId     LoyaltyNumber	
239654650            486007892540
245615237            437008687139
247830761            444008771628





Notes & Comments
-----------------

	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	File restictions require the size to be 5 MB or less.  
	Row count does not matter as this process is throttled.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponse_LoyaltyNumber_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_SurveyResponse_LoyaltyNumber_AutoDelivery
	@DeliveryEmail	= ''tpeterson@InMoment.com''
	, @FileName		= ''TacoBuenoBackfill.csv''
		



		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber
CREATE TABLE _surveyResponse_LoyaltyNumber
		(
			SurveyResponseId			bigint
			, LoyaltyNumber				varchar(40)	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponse_LoyaltyNumber   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponse_LoyaltyNumber	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponse_LoyaltyNumber	WHERE SurveyResponseId IS NULL	OR	LoyaltyNumber IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponse_LoyaltyNumber
	WHERE
			SurveyResponseId	IS NULL
		OR
			LoyaltyNumber		IS NULL
			
END			





DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponse_LoyaltyNumber		t01
												LEFT JOIN
													SurveyResponse						t02	WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitSurveyResponseId


-- Non legit SurveyResponseIds; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, t01.LoyaltyNumber
	INTO _surveyResponse_LoyaltyNumber_BadSurveyResponseId
	FROM
			_surveyResponse_LoyaltyNumber							t01
		LEFT JOIN
			SurveyResponse											t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponse_LoyaltyNumber							t01
		JOIN
			_surveyResponse_LoyaltyNumber_BadSurveyResponseId		t02
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
													, LoyaltyNumber
											FROM
													_surveyResponse_LoyaltyNumber		t01
											GROUP BY 
													SurveyResponseId
													, LoyaltyNumber
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber_Duplicates
	SELECT
			SurveyResponseId
			, LoyaltyNumber
	INTO _surveyResponse_LoyaltyNumber_Duplicates		
	FROM
			_surveyResponse_LoyaltyNumber				t01

	GROUP BY 
			SurveyResponseId
			, LoyaltyNumber
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponse_LoyaltyNumber				t01
		JOIN
			_surveyResponse_LoyaltyNumber_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.LoyaltyNumber		= t02.LoyaltyNumber

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponse_LoyaltyNumber ( SurveyResponseId, LoyaltyNumber )
	SELECT
			SurveyResponseId
			, LoyaltyNumber
	FROM
			_surveyResponse_LoyaltyNumber_Duplicates			


END



-- Checks for existing records
DECLARE @surveyResponseLoyaltyNumberExist	int
SET		@surveyResponseLoyaltyNumberExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_LoyaltyNumber		t01
																	JOIN
																		SurveyResponse						t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.ObjectId
																					AND
																						t01.LoyaltyNumber		= t02.LoyaltyNumber
															)


--SELECT @surveyResponseLoyaltyNumberExist


-- Removes existing records; preserve and removes
IF @surveyResponseLoyaltyNumberExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Exist') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber_Exist
	SELECT
			SurveyResponseId
			, t01.LoyaltyNumber
			
	INTO _surveyResponse_LoyaltyNumber_Exist
	FROM
			_surveyResponse_LoyaltyNumber		t01
		JOIN
			SurveyResponse						t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.ObjectId
						AND
							t01.LoyaltyNumber		= t02.LoyaltyNumber

	-- Deletes Exist
	DELETE	t01
	FROM
			_surveyResponse_LoyaltyNumber				t01
		JOIN
			_surveyResponse_LoyaltyNumber_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.LoyaltyNumber		= t02.LoyaltyNumber
					


END




DECLARE @surveyResponseLoyaltyNumberUpdate	int
SET		@surveyResponseLoyaltyNumberUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_LoyaltyNumber		t01
																	JOIN
																		SurveyResponse						t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.ObjectId
																					AND
																						(
																								t01.LoyaltyNumber		!= t02.LoyaltyNumber
																							OR
																								t02.LoyaltyNumber IS NULL
																						)
															)


-- Seperates updating records; preserve and removes
IF @surveyResponseLoyaltyNumberUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Update') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber_Update
	SELECT
			SurveyResponseId
			, t01.LoyaltyNumber
			, t02.LoyaltyNumber						AS LoyaltyNumber_Old
			
	INTO _surveyResponse_LoyaltyNumber_Update
	FROM
			_surveyResponse_LoyaltyNumber				t01
		JOIN
			SurveyResponse								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.ObjectId
						AND
							(
									t01.LoyaltyNumber		!= t02.LoyaltyNumber
								OR
									t02.LoyaltyNumber IS NULL
							)
							

	-- Deletes Updates
	DELETE	t01
	FROM
			_surveyResponse_LoyaltyNumber				t01
		JOIN
			_surveyResponse_LoyaltyNumber_Update		t02
					ON	
							t01.SurveyResponseId		= t02.SurveyResponseId
						AND
							t01.LoyaltyNumber			= t02.LoyaltyNumber
					


END








-- Identifies any remaining rows in original file
DECLARE @surveyResponseLoyaltyNumberUnidentified		int
SET		@surveyResponseLoyaltyNumberUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponse_LoyaltyNumber )


IF @surveyResponseLoyaltyNumberUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber_Unidentified
	SELECT
			*
	INTO _surveyResponse_LoyaltyNumber_Unidentified
	FROM
		_surveyResponse_LoyaltyNumber
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponse_LoyaltyNumber_Statistics
CREATE TABLE _surveyResponse_LoyaltyNumber_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitSurveyResponseId								int
		, duplicateCheck										int
		, surveyResponseLoyaltyNumberExist						int
		, surveyResponseLoyaltyNumberUpdate						int
		, surveyResponseLoyaltyNumberUnidentified				int
		, throttle												int						
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _surveyResponse_LoyaltyNumber_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitSurveyResponseId, duplicateCheck, surveyResponseLoyaltyNumberExist, surveyResponseLoyaltyNumberUpdate, surveyResponseLoyaltyNumberUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseLoyaltyNumberExist, @surveyResponseLoyaltyNumberUpdate, @surveyResponseLoyaltyNumberUnidentified, @throttleCheck




-- Results Print Out
PRINT 'Survey Response Loyalty Number Statistics'
PRINT ''
PRINT 'Original CSV Row Count        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   							AS money)), 1), '.00', '')
PRINT 'NULL Values Found             :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   									AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId						AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   								AS money)), 1), '.00', '')
PRINT 'Records Already Exist         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseLoyaltyNumberExist   			AS money)), 1), '.00', '')
PRINT 'Records Needing Update        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseLoyaltyNumberUpdate   			AS money)), 1), '.00', '')
PRINT 'Records Unidentified          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseLoyaltyNumberUnidentified   	AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                          AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponse_LoyaltyNumber_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponse_LoyaltyNumber_AutoDelivery	@answer = ''terminate'''

RETURN

END





--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON

-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _surveyResponse_LoyaltyNumber_Statistics )
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



					



IF @answerCheck = 1
BEGIN
	
	DECLARE @SrExUpdateCheck		int
	SET		@SrExUpdateCheck		= ( SELECT surveyResponseLoyaltyNumberUpdate		FROM _surveyResponse_LoyaltyNumber_Statistics )
	


	UPDATE	_surveyResponse_LoyaltyNumber_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @SrExUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@SrExUpdateCheck AS varchar) + ' records'
	


		/**************  Survey Response Loyalty Number Update  **************/

		DECLARE @count int, @SurveyResponseId int, @LoyaltyNumber varchar(40)

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, LoyaltyNumber FROM _surveyResponse_LoyaltyNumber_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseId, @LoyaltyNumber

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseId as varchar)+', '+cast(@LoyaltyNumber as varchar)


		----******************* W A R N I N G***************************


		UPDATE surveyResponse WITH (ROWLOCK)
		SET LoyaltyNumber = @LoyaltyNumber
		WHERE objectId = @SurveyResponseId


		----***********************************************************

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


		-- Remainder Of Cursor
		SET @count = @count+1
		FETCH next FROM mycursor INTO @SurveyResponseId, @LoyaltyNumber

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _surveyResponse_LoyaltyNumber_Update	t01		JOIN SurveyResponse t02	WITH (NOLOCK) 	ON t01.SurveyResponseId = t02.objectId AND t01.LoyaltyNumber = t02.LoyaltyNumber )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@SrExUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	UPDATE	_surveyResponse_LoyaltyNumber_Statistics
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
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @surveyResponseLoyaltyNumberExistV2						int
		, @surveyResponseLoyaltyNumberUpdateV2						int
		, @surveyResponseLoyaltyNumberUnidentifiedV2				int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2								= ( SELECT deliveryEmail									FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @inputFileNameV2								= ( SELECT inputFileName									FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @serverNameV2									= ( SELECT serverName										FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @originalCountV2								= ( SELECT originalCount									FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @nullCountV2									= ( SELECT nullCount										FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @notLegitSurveyResponseIdV2						= ( SELECT notLegitSurveyResponseId							FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @duplicateCheckV2								= ( SELECT duplicateCheck									FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @surveyResponseLoyaltyNumberExistV2				= ( SELECT surveyResponseLoyaltyNumberExist					FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @surveyResponseLoyaltyNumberUpdateV2			= ( SELECT surveyResponseLoyaltyNumberUpdate				FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @surveyResponseLoyaltyNumberUnidentifiedV2		= ( SELECT surveyResponseLoyaltyNumberUnidentified			FROM _surveyResponse_LoyaltyNumber_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _surveyResponse_LoyaltyNumber_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _surveyResponse_LoyaltyNumber_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseLoyaltyNumberStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseLoyaltyNumberStatus_Action
CREATE TABLE ##SurveyResponseLoyaltyNumberStatus_Action
	(
		Action							varchar(50)
		, SurveyResponseId				bigInt
		, LoyaltyNumber					varchar(40)
		, LoyaltyNumber_Old				varchar(40)
	)




IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLoyaltyNumberStatus_Action ( Action, SurveyResponseId, LoyaltyNumber )
	SELECT 	'NonLegit SurveyResponseId'
			, SurveyResponseId
			, LoyaltyNumber	
			
	FROM
			_surveyResponse_LoyaltyNumber_BadSurveyResponseId
END



IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLoyaltyNumberStatus_Action ( Action, SurveyResponseId, LoyaltyNumber )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, LoyaltyNumber	
			
	FROM
			_surveyResponse_LoyaltyNumber_Duplicates

END
		



IF @surveyResponseLoyaltyNumberExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLoyaltyNumberStatus_Action ( Action, SurveyResponseId, LoyaltyNumber )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, LoyaltyNumber	
			
	FROM
			_surveyResponse_LoyaltyNumber_Exist

END




IF @surveyResponseLoyaltyNumberUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLoyaltyNumberStatus_Action ( Action, SurveyResponseId, LoyaltyNumber )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, LoyaltyNumber	
			
	FROM
			_surveyResponse_LoyaltyNumber_Unidentified

END



IF @surveyResponseLoyaltyNumberUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseLoyaltyNumberStatus_Action ( Action, SurveyResponseId, LoyaltyNumber, LoyaltyNumber_Old )
	SELECT 	'Updated'
			, SurveyResponseId
			, LoyaltyNumber		
			, LoyaltyNumber_Old
	FROM
			_surveyResponse_LoyaltyNumber_Update

END




		



-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseLoyaltyNumberStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseLoyaltyNumberStatus_Results
CREATE TABLE ##SurveyResponseLoyaltyNumberStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseLoyaltyNumberStatus_Results ( Item, Criteria )
SELECT 'Server Name'						, @serverNameV2
UNION ALL
SELECT 'Delivery Email'						, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'					, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseLoyaltyNumberExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseLoyaltyNumberUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseLoyaltyNumberUpdateV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponse_LoyaltyNumber_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, LoyaltyNumber									
										, LoyaltyNumber_Old
												
								FROM 
										##SurveyResponseLoyaltyNumberStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseLoyaltyNumberStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Survey Response Loyalty Number Update
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
, @subject						= 'SurveyResponse LoyaltyNumber Completed'
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

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber') AND type = (N'U'))    						DROP TABLE _surveyResponse_LoyaltyNumber
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_BadLoyaltyNumber') AND type = (N'U'))    	DROP TABLE _surveyResponse_LoyaltyNumber_BadLoyaltyNumber
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_BadSurveyResponseId') AND type = (N'U'))    	DROP TABLE _surveyResponse_LoyaltyNumber_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Duplicates') AND type = (N'U'))    			DROP TABLE _surveyResponse_LoyaltyNumber_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Exist') AND type = (N'U'))    				DROP TABLE _surveyResponse_LoyaltyNumber_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Update') AND type = (N'U'))    				DROP TABLE _surveyResponse_LoyaltyNumber_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Unidentified') AND type = (N'U'))    			DROP TABLE _surveyResponse_LoyaltyNumber_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_LoyaltyNumber_Statistics') AND type = (N'U'))    			DROP TABLE _surveyResponse_LoyaltyNumber_Statistics
	
	
	
	IF OBJECT_ID('tempdb..##SurveyResponseLoyaltyNumberStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseLoyaltyNumberStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseLoyaltyNumberStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseLoyaltyNumberStatus_Results

	
	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
