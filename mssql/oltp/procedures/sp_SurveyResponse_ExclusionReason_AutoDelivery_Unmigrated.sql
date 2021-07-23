SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated]
	@deliveryEmail			varchar(100)	= NULL
	, @FileName				varchar(100)	= NULL
	
	, @answer				varchar(10)		= NULL		
	, @throttle				int				= 1

AS
	
/****************  Set Exclusion Reason Auto Deliver  ****************

	Comments
		built to help with automation and scaling.
		
		
	History
		06.13.2012	Tad Peterson
			-- created, tested with live data, successful.
			
		02.11.2013	Tad Peterson
			-- Add exclusionReasons 8-12

		06.25.2014	Tad Peterson
			-- added throttling
			
		03.12.2015	Tad Peterson & Canada Team
			-- added exclusionReasons 13-19
		
		04.05.2017 Bailey Hu
			-- Added detection/prevention of changes to migrated orgs.

			
	Execute on OLTP.
	
	sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated		
		@deliveryEmail			= 'tpeterson@InMoment.com'
		, @FileName				= NULL

		, @answer				= NULL		
		, @throttle				= 1

	
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
										


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @exclusionReasonCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Survey Response Exclusion Reason Update'
		PRINT CHAR(9) + 'Description:  Updates ExclusionReason based on a ResponseId & ExclusionReason from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides a list of exclusion reasons to the requestor.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor list of the exclusion reasons. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'ExclusionReason'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the exclusion reason list in order for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		
	RETURN
	END		






-- Sends Exclusion Reasons Answers
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Exclusion Reason Request'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



Exclusion Reason List
----------------------

	0     NONE
	1     BLOCKED_NUMBER
	2     REPEAT_LIMIT_PER_RESPONDENT
	3     OVERAGE
	4     IP_REPEAT_LIMIT_PER_RESONDENT
	5     OFFENSIVE_LANGUAGE
	6     SPEEDER
	7     DELETED
	8     LAG_TIME
	9     INVALID_ANSWER
	10    DIGITAL_FINGERPRINT_REPEAT_LIMIT_PER_RESONDENT
	11    LOYALTY_NUMBER_REPEAT_LIMIT_PER_RESONDENT
	12    FRAUD
	13    PROBABILITY_THROTTLE
	14    TIME_THROTTLE
	15    REPEAT_LIMIT_PER_RESPONDENT
	16    PERSONAL_IDENTIFYING_INFORMATION_LIMIT_PER_RESPONDENT
	17    BLANK_TOMBSTONE_LIMIT_PER_RESPONDENT
	18    EXCLUSION_PERIOD
	19    CERT_CODE_REPEAT_LIMIT_PER_RESPONDENT




File Setup & Contents Example
------------------------------

SurveyResponseId	ExclusionReason	
103090587		7
103090588		5
123456789		6





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

sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason
CREATE TABLE _surveyResponse_ExclusionReason
		(
			SurveyResponseId			bigint
			, ExclusionReason			int	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponse_ExclusionReason   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)

-- Inspect data set for changes to migrated orgs
select objectid as organizationObjectId into #tmp_ODS_ORGS from organization with (nolock) where responseBehavior = 1

IF 
	EXISTS (
		SELECT 1 
		FROM 
			_surveyResponse_ExclusionReason x
		inner join surveyResponse sr with (nolock) on x.SurveyResponseId = sr.objectId
		inner join location loc with (nolock) on sr.locationObjectId = loc.objectId
		inner join #tmp_ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
		--inner join _ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
	)
BEGIN
	PRINT 'Detected changes to a migrated org.'
	PRINT 'Cleaning up and exiting the process.'
	DROP TABLE _surveyResponse_ExclusionReason
	RETURN
END

DROP TABLE #tmp_ODS_ORGS

DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponse_ExclusionReason	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponse_ExclusionReason	WHERE SurveyResponseId IS NULL	OR	ExclusionReason IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponse_ExclusionReason
	WHERE
			SurveyResponseId	IS NULL
		OR
			ExclusionReason		IS NULL
			
END			




-- Verifies DataFieldOption is legit
DECLARE @notLegitExclusionReason		int
SET		@notLegitExclusionReason		= 
											(
												SELECT
														COUNT(1)
												FROM
														_surveyResponse_ExclusionReason		t01
														
												WHERE
														t01.ExclusionReason NOT IN ( 0, 1, 2, 3 ,4 ,5 ,6 ,7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 )
											)

--SELECT @notLegitExclusionReason



-- Non legit ExclusionReason; preserved and deleted
IF @notLegitExclusionReason > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_BadExclusionReason') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_BadExclusionReason
	SELECT
			SurveyResponseId
			, ExclusionReason
	INTO _surveyResponse_ExclusionReason_BadExclusionReason
	FROM
			_surveyResponse_ExclusionReason			t01
	WHERE
			t01.ExclusionReason NOT IN ( 1, 2, 3 ,4 ,5 ,6 ,7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 )

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponse_ExclusionReason			t01
	WHERE
			t01.ExclusionReason NOT IN ( 1, 2, 3 ,4 ,5 ,6 ,7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 )

END




DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponse_ExclusionReason		t01
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
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, t01.ExclusionReason
	INTO _surveyResponse_ExclusionReason_BadSurveyResponseId
	FROM
			_surveyResponse_ExclusionReason							t01
		LEFT JOIN
			SurveyResponse											t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponse_ExclusionReason							t01
		JOIN
			_surveyResponse_ExclusionReason_BadSurveyResponseId		t02
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
													, ExclusionReason
											FROM
													_surveyResponse_ExclusionReason		t01
											GROUP BY 
													SurveyResponseId
													, ExclusionReason
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_Duplicates
	SELECT
			SurveyResponseId
			, ExclusionReason
	INTO _surveyResponse_ExclusionReason_Duplicates		
	FROM
			_surveyResponse_ExclusionReason				t01

	GROUP BY 
			SurveyResponseId
			, ExclusionReason
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponse_ExclusionReason				t01
		JOIN
			_surveyResponse_ExclusionReason_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.ExclusionReason		= t02.ExclusionReason

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponse_ExclusionReason ( SurveyResponseId, ExclusionReason )
	SELECT
			SurveyResponseId
			, ExclusionReason
	FROM
			_surveyResponse_ExclusionReason_Duplicates			


END



-- Checks for existing records
DECLARE @surveyResponseExclusionReasonExist	int
SET		@surveyResponseExclusionReasonExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_ExclusionReason		t01
																	JOIN
																		SurveyResponse						t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.ObjectId
																					AND
																						t01.ExclusionReason		= t02.ExclusionReason
															)


--SELECT @surveyResponseExclusionReasonExist


-- Removes existing records; preserve and removes
IF @surveyResponseExclusionReasonExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Exist') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_Exist
	SELECT
			SurveyResponseId
			, t01.ExclusionReason
			
	INTO _surveyResponse_ExclusionReason_Exist
	FROM
			_surveyResponse_ExclusionReason		t01
		JOIN
			SurveyResponse						t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.ObjectId
						AND
							t01.ExclusionReason		= t02.ExclusionReason

	-- Deletes Exist
	DELETE	t01
	FROM
			_surveyResponse_ExclusionReason				t01
		JOIN
			_surveyResponse_ExclusionReason_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.ExclusionReason		= t02.ExclusionReason
					


END




DECLARE @surveyResponseExclusionReasonUpdate	int
SET		@surveyResponseExclusionReasonUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_ExclusionReason		t01
																	JOIN
																		SurveyResponse						t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.ObjectId
																					AND
																						t01.ExclusionReason		!= t02.ExclusionReason
															)


-- Seperates updating records; preserve and removes
IF @surveyResponseExclusionReasonUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Update') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_Update
	SELECT
			SurveyResponseId
			, t01.ExclusionReason
			, t02.ExclusionReason						AS ExclusionReason_Old
			
	INTO _surveyResponse_ExclusionReason_Update
	FROM
			_surveyResponse_ExclusionReason				t01
		JOIN
			SurveyResponse								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.ObjectId
						AND
							t01.ExclusionReason		!= t02.Exclusionreason

	-- Deletes Updates
	DELETE	t01
	FROM
			_surveyResponse_ExclusionReason				t01
		JOIN
			_surveyResponse_ExclusionReason_Update		t02
					ON	
							t01.SurveyResponseId		= t02.SurveyResponseId
						AND
							t01.ExclusionReason			= t02.ExclusionReason
					


END








-- Identifies any remaining rows in original file
DECLARE @surveyResponseExclusionReasonUnidentified		int
SET		@surveyResponseExclusionReasonUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponse_ExclusionReason )


IF @surveyResponseExclusionReasonUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_Unidentified
	SELECT
			*
	INTO _surveyResponse_ExclusionReason_Unidentified
	FROM
		_surveyResponse_ExclusionReason
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponse_ExclusionReason_Statistics
CREATE TABLE _surveyResponse_ExclusionReason_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitExclusionReason								int
		, notLegitSurveyResponseId								int
		, duplicateCheck										int
		, surveyResponseExclusionReasonExist					int
		, surveyResponseExclusionReasonUpdate					int
		, surveyResponseExclusionReasonUnidentified				int
		, throttle												int		
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _surveyResponse_ExclusionReason_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitExclusionReason, notLegitSurveyResponseId, duplicateCheck, surveyResponseExclusionReasonExist, surveyResponseExclusionReasonUpdate, surveyResponseExclusionReasonUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitExclusionReason, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseExclusionReasonExist , @surveyResponseExclusionReasonUpdate, @surveyResponseExclusionReasonUnidentified, @throttleCheck




-- Results Print Out
PRINT 'Survey Response Exclusion Reason Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   							AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   									AS money)), 1), '.00', '')
PRINT 'Non Legit Exclusion Reason               :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitExclusionReason						AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId						AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   								AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseExclusionReasonExist   			AS money)), 1), '.00', '')
PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseExclusionReasonUpdate   			AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseExclusionReasonUnidentified   	AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                  AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponse_ExclusionReason_AutoDelivery_Unmigrated	@answer = ''terminate'''

RETURN

END





--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _surveyResponse_ExclusionReason_Statistics )
SET		@check			=	( 
								SELECT 
										MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
								FROM 
										PutWh06.JobServerDb.dbo.ProductionDetailsCurrentAsOf
								WHERE
										--CurrentAsOf IS NOT NULL
										ReportingEnabled 	= 1
									AND
										Eligible 			= 1
							)



					


IF @answerCheck = 1
BEGIN
	
	DECLARE @SrExUpdateCheck		int
	SET		@SrExUpdateCheck		= ( SELECT surveyResponseExclusionReasonUpdate		FROM _surveyResponse_ExclusionReason_Statistics )
	


	UPDATE	_surveyResponse_ExclusionReason_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @SrExUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@SrExUpdateCheck AS varchar) + ' records'
	


		/**************  Survey Response Exclusion Reason Update  **************/

		DECLARE @count int, @SurveyResponseId bigInt, @ExclusionReason int

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, ExclusionReason FROM _surveyResponse_ExclusionReason_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseId, @ExclusionReason

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseId as varchar)+', '+cast(@ExclusionReason as varchar)


		----******************* W A R N I N G***************************


		UPDATE surveyResponse WITH (ROWLOCK)
		SET exclusionReason = @ExclusionReason
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
											PutWh06.JobServerDb.dbo.ProductionDetailsCurrentAsOf
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
												PutWh06.JobServerDb.dbo.ProductionDetailsCurrentAsOf
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
		FETCH next FROM mycursor INTO @SurveyResponseId, @ExclusionReason

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _surveyResponse_ExclusionReason_Update	t01		JOIN SurveyResponse t02	WITH (NOLOCK) 	ON t01.SurveyResponseId = t02.objectId AND t01.ExclusionReason = t02.ExclusionReason )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@SrExUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	UPDATE	_surveyResponse_ExclusionReason_Statistics
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
		, @notLegitExclusionReasonV2								int
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @surveyResponseExclusionReasonExistV2						int
		, @surveyResponseExclusionReasonUpdateV2					int
		, @surveyResponseExclusionReasonUnidentifiedV2				int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2								= ( SELECT deliveryEmail									FROM _surveyResponse_ExclusionReason_Statistics )
SET @inputFileNameV2								= ( SELECT inputFileName									FROM _surveyResponse_ExclusionReason_Statistics )
SET @serverNameV2									= ( SELECT serverName										FROM _surveyResponse_ExclusionReason_Statistics )
SET @originalCountV2								= ( SELECT originalCount									FROM _surveyResponse_ExclusionReason_Statistics )
SET @nullCountV2									= ( SELECT nullCount										FROM _surveyResponse_ExclusionReason_Statistics )
SET @notLegitExclusionReasonV2 						= ( SELECT notLegitExclusionReason							FROM _surveyResponse_ExclusionReason_Statistics )
SET @notLegitSurveyResponseIdV2						= ( SELECT notLegitSurveyResponseId							FROM _surveyResponse_ExclusionReason_Statistics )
SET @duplicateCheckV2								= ( SELECT duplicateCheck									FROM _surveyResponse_ExclusionReason_Statistics )
SET @surveyResponseExclusionReasonExistV2			= ( SELECT surveyResponseExclusionReasonExist				FROM _surveyResponse_ExclusionReason_Statistics )
SET @surveyResponseExclusionReasonUpdateV2			= ( SELECT surveyResponseExclusionReasonUpdate				FROM _surveyResponse_ExclusionReason_Statistics )
SET @surveyResponseExclusionReasonUnidentifiedV2	= ( SELECT surveyResponseExclusionReasonUnidentified		FROM _surveyResponse_ExclusionReason_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _surveyResponse_ExclusionReason_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _surveyResponse_ExclusionReason_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseExclusionReasonStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseExclusionReasonStatus_Action
CREATE TABLE ##SurveyResponseExclusionReasonStatus_Action
	(
		Action								varchar(50)
		, SurveyResponseId					bigInt
		, ExclusionReason					int
		, ExclusionReason_Old				int
	)




IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseExclusionReasonStatus_Action ( Action, SurveyResponseId, ExclusionReason )
	SELECT 	'NonLegit SurveyResponseId'
		, SurveyResponseId
		, ExclusionReason	
			
	FROM
			_surveyResponse_ExclusionReason_BadSurveyResponseId
END


IF @notLegitExclusionReasonV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseExclusionReasonStatus_Action ( Action, SurveyResponseId, ExclusionReason )
	SELECT 	'NonLegit Exclusion Reason Id'
			, SurveyResponseId
			, ExclusionReason	
			
	FROM
			_surveyResponse_ExclusionReason_BadExclusionReason
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseExclusionReasonStatus_Action ( Action, SurveyResponseId, ExclusionReason )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, ExclusionReason	
			
	FROM
			_surveyResponse_ExclusionReason_Duplicates

END
		



IF @surveyResponseExclusionReasonExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseExclusionReasonStatus_Action ( Action, SurveyResponseId, ExclusionReason )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, ExclusionReason	
			
	FROM
			_surveyResponse_ExclusionReason_Exist

END




IF @surveyResponseExclusionReasonUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseExclusionReasonStatus_Action ( Action, SurveyResponseId, ExclusionReason )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, ExclusionReason	
			
	FROM
			_surveyResponse_ExclusionReason_Unidentified

END



IF @surveyResponseExclusionReasonUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseExclusionReasonStatus_Action ( Action, SurveyResponseId, ExclusionReason, ExclusionReason_Old )
	SELECT 	'Updated'
			, SurveyResponseId
			, ExclusionReason		
			, ExclusionReason_Old
	FROM
			_surveyResponse_ExclusionReason_Update

END




		



-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseExclusionReasonStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseExclusionReasonStatus_Results
CREATE TABLE ##SurveyResponseExclusionReasonStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseExclusionReasonStatus_Results ( Item, Criteria )
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
SELECT 'NonLegit Exclusion Reason'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitExclusionReasonV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseExclusionReasonExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseExclusionReasonUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseExclusionReasonUpdateV2 , 0)   			AS money)), 1), '.00', '')	
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

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponse_ExclusionReason_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, ExclusionReason									
										, ExclusionReason_Old
												
								FROM 
										##SurveyResponseExclusionReasonStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseExclusionReasonStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Survey Response Exclusion Reason Update
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'bahu@mshare.net;iwong@inmoment.com;trafuse@inmoment.com;zbelghali@inmoment.com;bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Survey Response Exclusion Reason Completed'
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

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason') AND type = (N'U'))    						DROP TABLE _surveyResponse_ExclusionReason
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_BadExclusionReason') AND type = (N'U'))    	DROP TABLE _surveyResponse_ExclusionReason_BadExclusionReason
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_BadSurveyResponseId') AND type = (N'U'))    	DROP TABLE _surveyResponse_ExclusionReason_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Duplicates') AND type = (N'U'))    			DROP TABLE _surveyResponse_ExclusionReason_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Exist') AND type = (N'U'))    				DROP TABLE _surveyResponse_ExclusionReason_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Update') AND type = (N'U'))    				DROP TABLE _surveyResponse_ExclusionReason_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Unidentified') AND type = (N'U'))    			DROP TABLE _surveyResponse_ExclusionReason_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_ExclusionReason_Statistics') AND type = (N'U'))    			DROP TABLE _surveyResponse_ExclusionReason_Statistics
	
	
	
	IF OBJECT_ID('tempdb..##SurveyResponseExclusionReasonStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseExclusionReasonStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseExclusionReasonStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseExclusionReasonStatus_Results

	
	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
