SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_SurveyResponseAlert_BackFill_AutoDelivery
CREATE Procedure [dbo].[sp_SurveyResponseAlert_BackFill_AutoDelivery]
		@deliveryEmail	varchar(100)	= NULL
		, @FileName		varchar(100)	= NULL
		, @answer		varchar(10)		= NULL		


		
AS

/************************ Survey Response Alert Backfill  ************************

	Matt Mimnaugh initial requested this type of activity

	Inserts rows of data from a provided file into survey
	response alert so when accessing survey response details 
	in the app, it turns the "alerted" item red.

	
	Executed against OLTP only

	History
		8.9.2013	Tad Peterson
			-- created & tested; live data processed succesfully
	
				
**********************************************************************************/

SET NOCOUNT ON

DECLARE @answerCheck				int
SET		@answerCheck				= CASE	WHEN @answer IS NULL 			THEN 0
											WHEN @answer = 'EXECUTE'		THEN 1
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


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									



-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@FileNameCheck			= 0	
			
	BEGIN
	
		PRINT 'Survey Response Alert Backfill'
		PRINT CHAR(9) + 'Description:  Inserts rows of data from a provided file into survey response alert.'
		PRINT CHAR(9) + CHAR(9) + 'Accessing survey response details in the app, it turns the "alerted" item red.'
		PRINT CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'File name'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'None'
		PRINT CHAR(13) + 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseObjectId' + CHAR(13) + CHAR(9) + 'TriggerDataFieldObjectId' + CHAR(13) + CHAR(9) + 'OrganizationObjectId'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT CHAR(9) + 'sp_SurveyResponseAlert_BackFill_AutoDelivery ''Their Email Here'''
		
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
, @reply_to			= 'dba@mshare.net'
, @subject			= 'Survey Response Alert Backfill Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseId	TriggerDataFieldId	OrganizationId
103090587         46627				661



Note: TriggerDataFieldObjectId = data field that is causing the trigger/alert









Return Email
-------------

sp_SurveyResponseAlert_BackFill_AutoDelivery
	@deliveryEmail	= ''your email address here''
	, @FileName		= ''file name here''
		

		
		
-- Example Below --

sp_SurveyResponseAlert_BackFill_AutoDelivery
	@deliveryEmail	= ''tpeterson@mshare.net''
	, @FileName		= ''surveyResponseAlertBackfill.csv''
		




Notes & Comments
-----------------
		
	File name can not have any spaces.  File should be in CSV format.
	Please make sure your file is attached to return email.
	

		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill
CREATE TABLE _surveyResponseAlert_Backfill
		(
			SurveyResponseObjectId				bigint
			, TriggerDataFieldObjectId		int	
			, OrganizationObjectId							int
		)

		
DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponseAlert_Backfill   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

--SELECT @FileNameBulkInsertStatement

EXECUTE (@FileNameBulkInsertStatement)


--SELECT TOP 25 *		FROM _surveyResponseAlert_Backfill
		
		
		
				
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponseAlert_Backfill	)
			

--SELECT @originalFileSize

DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponseAlert_Backfill	WHERE SurveyResponseObjectId IS NULL	OR	TriggerDataFieldObjectId IS NULL	OR  OrganizationObjectId IS NULL )


--SELECT @nullCount

-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponseAlert_Backfill
	WHERE
			SurveyResponseObjectId IS NULL
		OR
			TriggerDataFieldObjectId IS NULL
		OR
			OrganizationObjectId IS NULL
			
END			


-- Verifies Org is legit
DECLARE @notLegitOrg	int
SET		@notLegitOrg	= 
							( 
								SELECT
										COUNT(1)
								FROM
										_surveyResponseAlert_Backfill	t10
									LEFT JOIN
										Organization							t20
												ON t10.OrganizationObjectId = t20.objectId
								WHERE
										t20.objectId IS NULL		
							)

--SELECT @notLegitOrg			

-- Non legit OrganizationObjectId; preserved and deleted
IF @notLegitOrg > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_BadOrganizationObjectId') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_BadOrganizationObjectId
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId
	INTO _surveyResponseAlert_Backfill_BadOrganizationObjectId
	FROM
			_surveyResponseAlert_Backfill	t10
		LEFT JOIN
			Organization							t20
					ON t10.OrganizationObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

	-- Delete Step
	DELETE	t10
	FROM	
			_surveyResponseAlert_Backfill	t10
		LEFT JOIN
			Organization							t20
					ON t10.OrganizationObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

END


--SELECT @originalFileSize, REPLACE(CONVERT(varchar(20), (CAST(COUNT(1) AS money)), 1), '.00', '')	FROM	_surveyResponseAlert_Backfill



-- Verifies TriggerDataField is legit
DECLARE @notLegitTriggerDataField	int
SET		@notLegitTriggerDataField	= 
										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAlert_Backfill	t10
												LEFT JOIN
													DataField								t20
															ON t10.TriggerDataFieldObjectId = t20.objectId
											WHERE
													t20.objectId IS NULL		
										)

--SELECT @notLegitTriggerDataField

-- Non legit dataField; preserved and deleted
IF @notLegitTriggerDataField > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_BadDataField') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_BadDataField
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, t10.OrganizationObjectId
	INTO _surveyResponseAlert_Backfill_BadDataField
	FROM
			_surveyResponseAlert_Backfill	t10
		LEFT JOIN
			DataField								t20
					ON t10.TriggerDataFieldObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

	-- Delete Step
	DELETE	t10
	FROM	
			_surveyResponseAlert_Backfill	t10
		LEFT JOIN
			DataField								t20
					ON t10.TriggerDataFieldObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

END




--SELECT @originalFileSize, REPLACE(CONVERT(varchar(20), (CAST(COUNT(1) AS money)), 1), '.00', '')	FROM	_surveyResponseAlert_Backfill



DECLARE @notLegitSurveyResponseObjectId	bigint
SET		@notLegitSurveyResponseObjectId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAlert_Backfill	t10
												LEFT JOIN
													SurveyResponse							t20		WITH (NOLOCK)
															ON t10.SurveyResponseObjectId = t20.objectId
											WHERE
													t20.objectId IS NULL		
										)


-- Non legit dataField; preserved and deleted
IF @notLegitSurveyResponseObjectId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_BadSurveyResponseObjectId') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_BadSurveyResponseObjectId
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId
	INTO _surveyResponseAlert_Backfill_BadSurveyResponseObjectId
	FROM
			_surveyResponseAlert_Backfill	t10
		LEFT JOIN
			SurveyResponse							t20		WITH (NOLOCK)
					ON t10.SurveyResponseObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

	-- Delete Step
	DELETE	t10
	FROM
			_surveyResponseAlert_Backfill	t10
		LEFT JOIN
			SurveyResponse							t20		WITH (NOLOCK)
					ON t10.SurveyResponseObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

END


--SELECT @notLegitSurveyResponseObjectId


-- Checks for Duplicates
DECLARE @duplicateCheck		int
SET		@duplicateCheck		= 
								(
									SELECT
											COUNT(1)
									FROM
										(		

											SELECT
													SurveyResponseObjectId
													, TriggerDataFieldObjectId
													, OrganizationObjectId
													
											FROM
													_surveyResponseAlert_Backfill	t10

											GROUP BY 
													SurveyResponseObjectId
													, TriggerDataFieldObjectId
													, OrganizationObjectId	
											HAVING	COUNT(1) > 1
										) AS t101
								)

-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_Duplicates
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId
	INTO _surveyResponseAlert_Backfill_Duplicates		
	FROM
			_surveyResponseAlert_Backfill	t10

	GROUP BY 
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId	
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t10
	FROM
			_surveyResponseAlert_Backfill				t10
		JOIN
			_surveyResponseAlert_Backfill_Duplicates	t20
						ON	t10.SurveyResponseObjectId			= t20.SurveyResponseObjectId
						AND
							t10.TriggerDataFieldObjectId	= t20.TriggerDataFieldObjectId
						AND
							t10.OrganizationObjectId						= t20.OrganizationObjectId

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponseAlert_Backfill ( SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId )
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId	
	FROM
			_surveyResponseAlert_Backfill_Duplicates			


END


--SELECT * FROM _surveyResponseAlert_Backfill_Duplicates



-- Proper Alert Id
DECLARE @distinctOrganizationObjectId		int
SET		@distinctOrganizationObjectId		= ( SELECT COUNT(DISTINCT OrganizationObjectId) 		FROM _surveyResponseAlert_Backfill )

DECLARE	@alertOrganizationObjectId			int
SET		@alertOrganizationObjectId			= ( SELECT COUNT(1)	FROM Alert	WHERE organizationObjectId IN ( SELECT DISTINCT OrganizationObjectId 		FROM _surveyResponseAlert_Backfill )	)



IF @distinctOrganizationObjectId = @alertOrganizationObjectId
BEGIN
		IF OBJECT_ID('tempdb..##TempBackfill') IS NOT NULL			DROP TABLE ##TempBackfill
		SELECT
				t10.SurveyResponseObjectId
				, t10.TriggerDataFieldObjectId
				, t10.OrganizationObjectId
				, t20.ObjectId						AS alertObjectId
		INTO ##TempBackfill
		FROM
				_surveyResponseAlert_Backfill		t10
			JOIN
				Alert										t20
						ON t10.OrganizationObjectId = t20.organizationObjectId 

		DROP TABLE _surveyResponseAlert_Backfill
		
		SELECT
				SurveyResponseObjectId
				, TriggerDataFieldObjectId
				, OrganizationObjectId
				, alertObjectId
		INTO _surveyResponseAlert_Backfill
		FROM 
				##TempBackfill
				
				
		--Cleanup temp table		
		IF OBJECT_ID('tempdb..##TempBackfill') IS NOT NULL			DROP TABLE ##TempBackfill

--SELECT DISTINCT alertObjectId		FROM _surveyResponseAlert_Backfill
		
		
END

	
IF @distinctOrganizationObjectId != @alertOrganizationObjectId
BEGIN
		PRINT 'There is more than one alert listed in the Alert Table for one of the OrganizationObjectIds listed in this backfill.'
		PRINT 'Exiting the script.'
RETURN		
END


	

DECLARE @surveyResponseAlertsExist		int
SET		@surveyResponseAlertsExist		= 

											(
												SELECT
														COUNT(1)
												FROM
														_surveyResponseAlert_Backfill				t10
													JOIN
														SurveyResponseAlert							t20  WITH (NOLOCK)
																ON	
																		t10.SurveyResponseObjectId		= t20.surveyResponseObjectId
																	AND
																		t10.TriggerDataFieldObjectId	= t20.TriggerDataFieldObjectId
																	AND
																		t10.alertObjectId				= t20.alertObjectId	
											)


IF @surveyResponseAlertsExist > 0
BEGIN
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_AlertsExist') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_AlertsExist
		SELECT
				t10.SurveyResponseObjectId
				, t10.TriggerDataFieldObjectId
				, t10.OrganizationObjectId
				, t10.AlertObjectId
		INTO _surveyResponseAlert_Backfill_AlertsExist
		FROM
				_surveyResponseAlert_Backfill				t10
			JOIN
				SurveyResponseAlert							t20  WITH (NOLOCK)
							ON	t10.SurveyResponseObjectId		= t20.surveyResponseObjectId
							AND
								t10.TriggerDataFieldObjectId	= t20.TriggerDataFieldObjectId
							AND
								t10.alertObjectId				= t20.alertObjectId	

		-- Delete Step
		DELETE	t10
		FROM
				_surveyResponseAlert_Backfill				t10
			JOIN
				_surveyResponseAlert_Backfill_AlertsExist	t20
							ON	t10.SurveyResponseObjectId			= t20.SurveyResponseObjectId
							AND
								t10.TriggerDataFieldObjectId	= t20.TriggerDataFieldObjectId
							AND
								t10.OrganizationObjectId						= t20.OrganizationObjectId
							AND
								t10.alertObjectId				= t20.alertObjectId	

END




DECLARE @FinalRowCount			int
SET		@FinalRowCount			= ( SELECT COUNT(1)		FROM _surveyResponseAlert_Backfill )


IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_Statistics
CREATE TABLE _surveyResponseAlert_Backfill_Statistics
	(
		DeliveryEmail					varchar(100)
		, inputFileName					varchar(100)
		, surverName					varchar(25)
		, originalCount					int
		, nullCount						int
		, notLegitOrg					int
		, notLegitTriggerDataField		int
		, notLegitSurveyResponseObjectId		int
		, duplicateCheck				int
		, surveyResponseAlertsExist		int
		, finalInsert					int
		, processingStart				dateTime
		, processingComplete			dateTime

	)		

INSERT INTO _surveyResponseAlert_Backfill_Statistics ( DeliveryEmail,inputFileName, surverName, originalCount, nullCount, notLegitOrg, notLegitTriggerDataField, notLegitSurveyResponseObjectId, duplicateCheck, surveyResponseAlertsExist, finalInsert )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitOrg, @notLegitTriggerDataField, @notLegitSurveyResponseObjectId, @duplicateCheck, @surveyResponseAlertsExist, @FinalRowCount




-- Results Print Out
PRINT 'Original CSV Row Count     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   		AS money)), 1), '.00', '')
PRINT 'NULL Values Found          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   				AS money)), 1), '.00', '')
PRINT 'Non Legit OrgIds           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitOrg   				AS money)), 1), '.00', '')
PRINT 'Non Legit DataFields       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitTriggerDataField   AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseObjectId   AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   			AS money)), 1), '.00', '')
PRINT 'Alerts Already Exist       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseAlertsExist  AS money)), 1), '.00', '')
PRINT ''
PRINT 'Final Row Count for Insert :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@FinalRowCount   			AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAlert_BackFill_AutoDelivery 	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponseAlert_BackFill_AutoDelivery 	@answer = ''terminate'''



RETURN
		

END














--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON

IF @answerCheck = 1
BEGIN

	DECLARE @SrAlertInsertCheck		int
	SET		@SrAlertInsertCheck		= ( SELECT finalInsert		FROM _surveyResponseAlert_Backfill_Statistics )


	UPDATE _surveyResponseAlert_Backfill_Statistics
	SET processingStart = GETDATE()
	
	
	IF @SrAlertInsertCheck > 0
	BEGIN

		PRINT 'Inserting ' + CAST(@SrAlertInsertCheck AS varchar) + ' records'
	
	
		-----Cursor for Survey Response Alert Insert

		DECLARE @count bigint, @sroid bigint, @tdfoid bigint, @aoid bigint

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseObjectId, TriggerDataFieldObjectId, AlertObjectId	FROM _surveyResponseAlert_Backfill

		OPEN mycursor
		FETCH next FROM mycursor INTO @sroid, @tdfoid, @aoid

		WHILE @@Fetch_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@sroid as varchar)+', '+cast(@tdfoid as varchar)+', '+cast(@aoid as varchar)


		----******************* W A R N I N G***************************


		INSERT INTO SurveyResponseAlert ( SurveyResponseObjectId, TriggerDataFieldObjectId, AlertObjectId )
		SELECT @sroid, @tdfoid, @aoid


		----***********************************************************

		SET @count = @count + 1
		FETCH next FROM mycursor INTO @sroid, @tdfoid, @aoid

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@count as varchar)+' Records Processed'
	


		DECLARE @successfulInsertV2		int
		SET		@successfulInsertV2		= ( SELECT COUNT(1)		FROM _surveyResponseAlert_Backfill	t10		JOIN SurveyResponseAlert t20	WITH (NOLOCK) 	ON t10.SurveyResponseObjectId = t20.SurveyResponseObjectId AND t10.TriggerDataFieldObjectId = t20.triggerDataFieldObjectId AND t10.alertObjectId = t20.alertObjectId )

		


		DECLARE	@failedInsertV2			int
		SET		@failedInsertV2			= 
		
											(
												SELECT
														COUNT(1)
														
												FROM
														SurveyResponseAlert				t10
													RIGHT JOIN
														_surveyResponseAlert_Backfill	t20
															ON 
																	t10.surveyResponseObjectId		= t20.surveyResponseObjectId 
																AND 
																	t10.triggerDataFieldObjectId	= t20.triggerDataFieldObjectId
																AND
																	t10.alertObjectId				= t20.alertObjectId

												WHERE
														t10.objectId IS NULL
											)
		



		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@SrAlertInsertCheck AS varchar) + ' Successful: ' + CAST(@successfulInsertV2 as varchar)
		PRINT ''
		PRINT ''

		
		UPDATE _surveyResponseAlert_Backfill_Statistics
		SET processingComplete = GETDATE()


		
		-- Builds Inserts failures table
		IF @failedInsertV2 > 0
		BEGIN
			IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_FailedInserts') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_FailedInserts
			SELECT
					t20.SurveyResponseObjectId
					, t20.TriggerDataFieldObjectId 
					, t20.OrganizationObjectId
					, t20.AlertObjectId

			INTO	_surveyResponseAlert_Backfill_FailedInserts
					
			FROM
					SurveyResponseAlert				t10
				RIGHT JOIN
					_surveyResponseAlert_Backfill	t20
						ON 
								t10.surveyResponseObjectId		= t20.surveyResponseObjectId 
							AND 
								t10.triggerDataFieldObjectId	= t20.triggerDataFieldObjectId
							AND
								t10.alertObjectId				= t20.alertObjectId

			WHERE
					t10.objectId IS NULL
			

			
			-- Removes any failed inserts from original file
			DELETE t10
			FROM
					_surveyResponseAlert_Backfill					t10
				JOIN
					_surveyResponseAlert_Backfill_FailedInserts		t20
						ON 
								t10.surveyResponseObjectId		= t20.surveyResponseObjectId 
							AND 
								t10.triggerDataFieldObjectId	= t20.triggerDataFieldObjectId
							AND
								t10.alertObjectId				= t20.alertObjectId
					
		
		END




		IF @successfulInsertV2 > 0 
		BEGIN
			IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_SuccessfulInserts') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_SuccessfulInserts
			SELECT
					t10.objectId 					AS SurveyResponseAlertObjectId
					, t20.SurveyResponseObjectId
					, t20.TriggerDataFieldObjectId 
					, t20.OrganizationObjectId
					, t20.AlertObjectId

			INTO	_surveyResponseAlert_Backfill_SuccessfulInserts
					
			FROM
					SurveyResponseAlert				t10
				JOIN
					_surveyResponseAlert_Backfill	t20
						ON 
								t10.surveyResponseObjectId		= t20.surveyResponseObjectId 
							AND 
								t10.triggerDataFieldObjectId	= t20.triggerDataFieldObjectId
							AND
								t10.alertObjectId				= t20.alertObjectId

			
		
		END

	


	END
	
	
	
	
	GOTO PROCESSING_COMPLETE

END	



IF @answerCheck = 2
BEGIN
	PRINT 'Terminating Script'
	PRINT ''
	
GOTO CLEANUP
END	







PROCESSING_COMPLETE:
IF @SrAlertInsertCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'


DECLARE  @deliveryEmailV2						varchar(100)			
		, @FileNameV2							varchar(100)
		, @serverNameV2							varchar(25)
		, @originalFileSizeV2					int
		, @nullCountV2							int
		, @notLegitOrgV2						int
		, @notLegitTriggerDataFieldV2			int
		, @notLegitSurveyResponseObjectIdV2		int
		, @duplicateCheckV2						int
		, @surveyResponseAlertsExistV2			int
		, @FinalRowCountV2						int
		, @ProcessingStartV2					dateTime
		, @ProcessingCompleteV2					dateTime
		, @ProcessingDurationV2					varchar(25)


		, @Minutes								varchar(3)
		, @Seconds								varchar(3)



SET @deliveryEmailV2					= ( SELECT deliveryEmail					FROM _surveyResponseAlert_Backfill_Statistics )
SET @FileNameV2							= ( SELECT inputFileName					FROM _surveyResponseAlert_Backfill_Statistics )
SET @serverNameV2						= ( SELECT surverName						FROM _surveyResponseAlert_Backfill_Statistics )
SET @originalFileSizeV2					= ( SELECT originalCount					FROM _surveyResponseAlert_Backfill_Statistics )
SET @nullCountV2						= ( SELECT nullCount						FROM _surveyResponseAlert_Backfill_Statistics )
SET @notLegitOrgV2						= ( SELECT notLegitOrg						FROM _surveyResponseAlert_Backfill_Statistics )
SET @notLegitTriggerDataFieldV2 		= ( SELECT notLegitTriggerDataField			FROM _surveyResponseAlert_Backfill_Statistics )
SET @notLegitSurveyResponseObjectIdV2	= ( SELECT notLegitSurveyResponseObjectId	FROM _surveyResponseAlert_Backfill_Statistics )
SET @duplicateCheckV2					= ( SELECT duplicateCheck					FROM _surveyResponseAlert_Backfill_Statistics )
SET @surveyResponseAlertsExistV2		= ( SELECT surveyResponseAlertsExist		FROM _surveyResponseAlert_Backfill_Statistics )
SET @FinalRowCountV2					= ( SELECT finalInsert						FROM _surveyResponseAlert_Backfill_Statistics )
SET @ProcessingStartV2					= ( SELECT ProcessingStart					FROM _surveyResponseAlert_Backfill_Statistics )
SET @ProcessingCompleteV2				= ( SELECT ProcessingComplete				FROM _surveyResponseAlert_Backfill_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseAlertStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseAlertStatus_Action
CREATE TABLE ##SurveyResponseAlertStatus_Action
	(
		Action							varchar(50)
		, SurveyResponseAlertObjectId	int
		, SurveyResponseObjectId		bigInt
		, TriggerDataFieldObjectId		int
		, OrganizationObjectId			int
		, alertObjectId					int
	)

	
		
IF @notLegitOrgV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId	)
	SELECT 	'NonLegit OrganizationObjectId'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId		
			
	FROM
			_surveyResponseAlert_Backfill_BadOrganizationObjectId

END


IF @notLegitTriggerDataFieldV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId	)
	SELECT 	'NonLegit TriggerDataField'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId		
			
	FROM
			_surveyResponseAlert_Backfill_BadDataField

END
		

IF @notLegitSurveyResponseObjectIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId	)
	SELECT 	'NonLegit SurveyResponseObjectId'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId		
			
	FROM
			_surveyResponseAlert_Backfill_BadSurveyResponseObjectId

END
		
		
IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId	)
	SELECT 	'Duplicate'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId		
			
	FROM
			_surveyResponseAlert_Backfill_Duplicates

END
		
		
IF @surveyResponseAlertsExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId, AlertObjectId	)
	SELECT 	'Alert Already Exist'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId
			, AlertObjectId
			
	FROM
			_surveyResponseAlert_Backfill_AlertsExist

END
		
		
IF @failedInsertV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId, AlertObjectId	)
	SELECT 	'Failed Insert'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId
			, AlertObjectId
			
	FROM
			_surveyResponseAlert_Backfill_FailedInserts

END
		
		
IF @successfulInsertV2 > 0
BEGIN		
	INSERT INTO ##SurveyResponseAlertStatus_Action  ( Action, SurveyResponseAlertObjectId, SurveyResponseObjectId, TriggerDataFieldObjectId, OrganizationObjectId, AlertObjectId	)
	SELECT 	'Inserted'
			, SurveyResponseAlertObjectId
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrganizationObjectId		
			, alertObjectId
	FROM
			_surveyResponseAlert_Backfill_SuccessfulInserts

END		
		
		
		
		

-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseAlertStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAlertStatus_Results
CREATE TABLE ##SurveyResponseAlertStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseAlertStatus_Results ( Item, Criteria )
SELECT 'Server Name'				, @serverNameV2
UNION ALL
SELECT 'Delivery Email'				, @deliveryEmailV2
UNION ALL
SELECT 'Input File Name'			, @FileNameV2
UNION ALL
SELECT 'CSV File Rows'				, REPLACE(CONVERT(varchar(20), (CAST( @originalFileSizeV2    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'					, REPLACE(CONVERT(varchar(20), (CAST( @nullCountV2    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit Organizations'		, REPLACE(CONVERT(varchar(20), (CAST( @notLegitOrgV2    			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit TriggerDataField'	, REPLACE(CONVERT(varchar(20), (CAST( @notLegitTriggerDataFieldV2	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'	, REPLACE(CONVERT(varchar(20), (CAST( @notLegitOrgV2    			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'					, REPLACE(CONVERT(varchar(20), (CAST( @duplicateCheckV2    			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Alerts Already Exist'		, REPLACE(CONVERT(varchar(20), (CAST( @surveyResponseAlertsExistV2  AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Requested Inserts'			, REPLACE(CONVERT(varchar(20), (CAST( @FinalRowCountV2   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Inserts'			, REPLACE(CONVERT(varchar(20), (CAST( @successfulInsertV2   		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Failed Inserts'				, REPLACE(CONVERT(varchar(20), (CAST( @failedInsertV2   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'		, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'		, @ProcessingDurationV2
		


DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponseAlert_Insert_Completed.csv' ) 




		
		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseAlertObjectId
										, SurveyResponseObjectId
										, TriggerDataFieldObjectId
										, OrganizationObjectId
										, AlertObjectId
												
								FROM 
										##SurveyResponseAlertStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseAlertStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Survey Response Alert Insert
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'tpeterson@mshare.net; bluther@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Survey Response Alert Insert'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
--, @execute_query_database		= 'Mindshare071613'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	

END


GOTO CLEANUP


CLEANUP:

	PRINT 'Cleaning up temp tables'
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill') AND type = (N'U'))    						DROP TABLE _surveyResponseAlert_Backfill
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_BadOrganizationObjectId') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Backfill_BadOrganizationObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_BadDataField') AND type = (N'U'))    			DROP TABLE _surveyResponseAlert_Backfill_BadDataField
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_BadSurveyResponseObjectId') AND type = (N'U'))  DROP TABLE _surveyResponseAlert_Backfill_BadSurveyResponseObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_Duplicates') AND type = (N'U'))    				DROP TABLE _surveyResponseAlert_Backfill_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_AlertsExist') AND type = (N'U'))    			DROP TABLE _surveyResponseAlert_Backfill_AlertsExist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_Statistics') AND type = (N'U'))    				DROP TABLE _surveyResponseAlert_Backfill_Statistics
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_FailedInserts') AND type = (N'U'))    			DROP TABLE _surveyResponseAlert_Backfill_FailedInserts
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Backfill_SuccessfulInserts') AND type = (N'U'))    		DROP TABLE _surveyResponseAlert_Backfill_SuccessfulInserts

	
	IF OBJECT_ID('tempdb..##TempBackfill') IS NOT NULL			DROP TABLE ##TempBackfill

	PRINT 'Cleanup is complete'
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
