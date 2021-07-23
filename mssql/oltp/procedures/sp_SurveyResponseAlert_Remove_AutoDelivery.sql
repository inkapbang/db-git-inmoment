SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_SurveyResponseAlert_Remove_AutoDelivery]
	@deliveryEmail	varchar(100)	= NULL
	, @FileName		varchar(100)	= NULL
	, @answer		varchar(10)		= NULL		
	, @throttle		int				= 1
		
AS

/************************ Survey Response Alert Delete  ************************

	Matt Mimnaugh initial requested this type of activity
	
	Executed against OLTP only

	History
		8.9.2013	Tad Peterson
			-- created & tested; live data processed succesfully
			
		7.22.2014	Tad Peterson
			-- added support for non use of TriggerDataFieldObjectId
			
		7.25.2014	Tad Peterson
			-- added throttling
			
			
				
********************************************************************************/

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

DECLARE @ThrottleCheck				int
SET		@ThrottleCheck				= CASE	WHEN @throttle IS NULL			THEN 1
											WHEN @throttle = 0 				THEN 0
											ELSE 1
											END
														
 
-- These are used for throttling														
DECLARE @message					nvarchar(200)
DECLARE @check						int
										



--SELECT 	@deliveryEmailCheck, @FileNameCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									


-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@FileNameCheck			= 0	
			
	BEGIN
	
		PRINT 'Survey Response Alert Delete'
		PRINT CHAR(9) + 'Description:  Deletes rows of data from survey response alert via a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'Accessing survey response details in the app, it removes the red alert.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''
		PRINT ''		
		PRINT CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'File name'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'None'
		PRINT CHAR(13) + 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseObjectId' + CHAR(13) + CHAR(9) + 'TriggerDataFieldObjectId' + CHAR(13) + CHAR(9) + 'OrgId'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT CHAR(9) + 'sp_SurveyResponseAlert_Remove_AutoDelivery ''Their Email Here'''
		
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
, @subject			= 'Survey Response Alert Removal Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseObjectId	TriggerDataFieldObjectId	OrgId
103090587               46627					661
125369874                                       1224


Note: TriggerDataFieldObjectId = data field that is causing the trigger/alert
      If a prompt is logic and does not use a datafield trigger, then leave
	  column empty.  The column must be present for file to load properly.

      This process has throttling which allows for execution at any time of day.
	  The max file size must be less than 5 MB.






Return Email
-------------

sp_SurveyResponseAlert_Remove_AutoDelivery
	@deliveryEmail	= ''your email address here''
	, @FileName		= ''file name here''
		

		
		
-- Example Below --

sp_SurveyResponseAlert_Remove_AutoDelivery
	@deliveryEmail	= ''tpeterson@InMoment.com''
	, @FileName		= ''surveyResponseAlertRemoval.csv''
		




Notes & Comments
-----------------
		
	File name can not have any spaces.  File should be in CSV format.
	Please make sure your file is attached to return email.
	

		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal
CREATE TABLE _surveyResponseAlert_Removal
		(
			SurveyResponseObjectId			bigint
			, TriggerDataFieldObjectId		int	
			, OrgId							int
		)

		
DECLARE @FileNameBulkDeletestatement	nvarchar(2000)
SET		@FileNameBulkDeletestatement	= 'BULK INSERT _surveyResponseAlert_Removal   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

--SELECT @FileNameBulkDeletestatement

EXECUTE (@FileNameBulkDeletestatement)


--SELECT TOP 25 *		FROM _surveyResponseAlert_Removal
		
		
		
				
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponseAlert_Removal	)
			

--SELECT @originalFileSize

DECLARE @nullCount			int
SET		@nullCount			= 
								( 
									SELECT 
											COUNT(1) 	
									FROM 
											_surveyResponseAlert_Removal	
									WHERE 
											SurveyResponseObjectId IS NULL	
										--OR	
										--	TriggerDataFieldObjectId IS NULL	
										OR  
											OrgId IS NULL 
								)


--SELECT @nullCount

-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponseAlert_Removal
	WHERE
			SurveyResponseObjectId IS NULL
		--OR
		--	TriggerDataFieldObjectId IS NULL
		OR
			OrgId IS NULL
			
END			


-- Verifies Org is legit
DECLARE @notLegitOrg	int
SET		@notLegitOrg	= 
							( 
								SELECT
										COUNT(1)
								FROM
										_surveyResponseAlert_Removal	t01
									LEFT JOIN
										Organization							t02
												ON t01.OrgId = t02.objectId
								WHERE
										t02.objectId IS NULL		
							)

--SELECT @notLegitOrg			

-- Non legit orgid; preserved and deleted
IF @notLegitOrg > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_BadOrgId') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_BadOrgId
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId
	INTO _surveyResponseAlert_Removal_BadOrgId
	FROM
			_surveyResponseAlert_Removal	t01
		LEFT JOIN
			Organization							t02
					ON t01.OrgId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM	
			_surveyResponseAlert_Removal	t01
		LEFT JOIN
			Organization							t02
					ON t01.OrgId = t02.objectId
	WHERE
			t02.objectId IS NULL		

END


--SELECT @originalFileSize, REPLACE(CONVERT(varchar(20), (CAST(COUNT(1) AS money)), 1), '.00', '')	FROM	_surveyResponseAlert_Removal



-- Verifies TriggerDataField is legit
DECLARE @notLegitTriggerDataField	int
SET		@notLegitTriggerDataField	= 
										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAlert_Removal	t01
												LEFT JOIN
													DataField						t02
														ON t01.TriggerDataFieldObjectId = t02.objectId
											WHERE
													t01.TriggerDataFieldObjectId IS NOT NULL
												AND
													t02.objectId IS NULL		
										)

--SELECT @notLegitTriggerDataField

-- Non legit dataField; preserved and deleted
IF @notLegitTriggerDataField > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_BadDataField') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_BadDataField
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId
	INTO _surveyResponseAlert_Removal_BadDataField
	FROM
			_surveyResponseAlert_Removal	t01
		LEFT JOIN
			DataField						t02
					ON t01.TriggerDataFieldObjectId = t02.objectId
	WHERE
			t01.TriggerDataFieldObjectId IS NOT NULL
		AND
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseAlert_Removal	t01
		LEFT JOIN
			DataField						t02
					ON t01.TriggerDataFieldObjectId = t02.objectId
	WHERE
			t01.TriggerDataFieldObjectId IS NOT NULL
		AND
			t02.objectId IS NULL		

END




--SELECT @originalFileSize, REPLACE(CONVERT(varchar(20), (CAST(COUNT(1) AS money)), 1), '.00', '')	FROM	_surveyResponseAlert_Removal



DECLARE @notLegitSurveyResponseObjectId	bigint
SET		@notLegitSurveyResponseObjectId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAlert_Removal	t01
												LEFT JOIN
													SurveyResponse							t02		WITH (NOLOCK)
															ON t01.SurveyResponseObjectId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)


-- Non legit dataField; preserved and deleted
IF @notLegitSurveyResponseObjectId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_BadSurveyResponseObjectId') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_BadSurveyResponseObjectId
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId
	INTO _surveyResponseAlert_Removal_BadSurveyResponseObjectId
	FROM
			_surveyResponseAlert_Removal	t01
		LEFT JOIN
			SurveyResponse							t02		WITH (NOLOCK)
					ON t01.SurveyResponseObjectId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseAlert_Removal	t01
		LEFT JOIN
			SurveyResponse							t02		WITH (NOLOCK)
					ON t01.SurveyResponseObjectId = t02.objectId
	WHERE
			t02.objectId IS NULL		

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
													, OrgId
													
											FROM
													_surveyResponseAlert_Removal	t01

											GROUP BY 
													SurveyResponseObjectId
													, TriggerDataFieldObjectId
													, OrgId	
											HAVING	COUNT(1) > 1
										) AS t101
								)

-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_Duplicates
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId
	INTO _surveyResponseAlert_Removal_Duplicates		
	FROM
			_surveyResponseAlert_Removal	t01

	GROUP BY 
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId	
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponseAlert_Removal				t01
		JOIN
			_surveyResponseAlert_Removal_Duplicates	t02
						ON	t01.SurveyResponseObjectId			= t02.SurveyResponseObjectId
						AND
							t01.TriggerDataFieldObjectId	= t02.TriggerDataFieldObjectId
						AND
							t01.OrgId						= t02.OrgId
		
	-- Puts single version back in original file
	INSERT INTO _surveyResponseAlert_Removal ( SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId )
	SELECT
			SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId	
	FROM
			_surveyResponseAlert_Removal_Duplicates			


END


--SELECT * FROM _surveyResponseAlert_Removal_Duplicates



-- Proper Alert Id
DECLARE @distinctOrgId		int
SET		@distinctOrgId		= ( SELECT COUNT(DISTINCT OrgId) 		FROM _surveyResponseAlert_Removal )

DECLARE	@alertOrgId			int
SET		@alertOrgId			= ( SELECT COUNT(1)	FROM Alert	WHERE organizationObjectId IN ( SELECT DISTINCT OrgId 		FROM _surveyResponseAlert_Removal )	)



IF @distinctOrgId = @alertOrgId
BEGIN
		IF OBJECT_ID('tempdb..##TempRemoval') IS NOT NULL			DROP TABLE ##TempRemoval
		SELECT
				t01.SurveyResponseObjectId
				, t01.TriggerDataFieldObjectId
				, t01.OrgId
				, t02.ObjectId						AS alertObjectId
		INTO ##TempRemoval
		FROM
				_surveyResponseAlert_Removal		t01
			JOIN
				Alert										t02
						ON t01.OrgId = t02.organizationObjectId 

		DROP TABLE _surveyResponseAlert_Removal
		
		SELECT
				SurveyResponseObjectId
				, TriggerDataFieldObjectId
				, OrgId
				, alertObjectId
		INTO _surveyResponseAlert_Removal
		FROM 
				##TempRemoval
				
				
		--Cleanup temp table		
		IF OBJECT_ID('tempdb..##TempRemoval') IS NOT NULL			DROP TABLE ##TempRemoval

--SELECT DISTINCT alertObjectId		FROM _surveyResponseAlert_Removal
		
		
END

	
IF @distinctOrgId != @alertOrgId
BEGIN
		PRINT 'There is more than one alert listed in the Alert Table for one of the OrgIds listed in this Removal.'
		PRINT 'Exiting the script.'
RETURN		
END


	

DECLARE @surveyResponseAlertsDeletes		int
SET		@surveyResponseAlertsDeletes		= 

											(
												SELECT
														COUNT(1)
												FROM
														_surveyResponseAlert_Removal		t01
													JOIN
														SurveyResponseAlert					t02  WITH (NOLOCK)
															ON	
																	t01.SurveyResponseObjectId		= t02.surveyResponseObjectId
																--AND
																--	t01.TriggerDataFieldObjectId	= t02.TriggerDataFieldObjectId
																AND
																	t01.alertObjectId				= t02.alertObjectId	
											)


IF @surveyResponseAlertsDeletes > 0
BEGIN
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Deletes') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_Deletes
		SELECT
				t02.objectId						AS SurveyResponseAlertObjectId
				, t01.SurveyResponseObjectId
				, t01.TriggerDataFieldObjectId
				, t01.OrgId
				, t01.AlertObjectId
		INTO _surveyResponseAlert_Removal_Deletes
		FROM
				_surveyResponseAlert_Removal				t01
			JOIN
				SurveyResponseAlert							t02  WITH (NOLOCK)
					ON	
							t01.SurveyResponseObjectId		= t02.surveyResponseObjectId
						--AND
						--	t01.TriggerDataFieldObjectId	= t02.TriggerDataFieldObjectId
						AND
							t01.alertObjectId				= t02.alertObjectId	

		-- Delete Step
		DELETE	t01
		FROM
				_surveyResponseAlert_Removal				t01
			JOIN
				_surveyResponseAlert_Removal_Deletes		t02
					ON	
							t01.SurveyResponseObjectId		= t02.surveyResponseObjectId
						--AND
						--	t01.TriggerDataFieldObjectId	= t02.TriggerDataFieldObjectId
						AND
							t01.alertObjectId				= t02.alertObjectId	

END



DECLARE @surveyResponseAlertsUnidentified		int
SET		@surveyResponseAlertsUnidentified		=	( 
														SELECT
																COUNT(1)
														FROM
																_surveyResponseAlert_Removal				t01
													)




IF @surveyResponseAlertsUnidentified > 0
BEGIN
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_Unidentified
		SELECT
				t01.SurveyResponseObjectId
				, t01.TriggerDataFieldObjectId
				, t01.OrgId
				, t01.AlertObjectId
		INTO _surveyResponseAlert_Removal_Unidentified
		FROM
				_surveyResponseAlert_Removal				t01

				
		-- Delete Step
		DELETE	t01
		FROM
				_surveyResponseAlert_Removal				t01
			JOIN
				_surveyResponseAlert_Removal_Unidentified	t02
							ON	t01.SurveyResponseObjectId			= t02.SurveyResponseObjectId
							AND
								t01.TriggerDataFieldObjectId	= t02.TriggerDataFieldObjectId
							AND
								t01.OrgId						= t02.OrgId
							AND
								t01.alertObjectId				= t02.alertObjectId	

END







-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal





IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_Statistics
CREATE TABLE _surveyResponseAlert_Removal_Statistics
	(
		DeliveryEmail						varchar(100)
		, inputFileName						varchar(100)
		, surverName						varchar(25)
		, originalCount						int
		, nullCount							int
		, notLegitOrg						int
		, notLegitTriggerDataField			int
		, notLegitSurveyResponseObjectId	int
		, duplicateCheck					int
		, unidentifiedRecords				int
		, surveyResponseAlertsDeletes		int
		, throttle							int				
		, processingStart					dateTime
		, processingComplete				dateTime

	)		

INSERT INTO _surveyResponseAlert_Removal_Statistics ( DeliveryEmail,inputFileName, surverName, originalCount, nullCount, notLegitOrg, notLegitTriggerDataField, notLegitSurveyResponseObjectId, duplicateCheck, unidentifiedRecords, surveyResponseAlertsDeletes, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitOrg, @notLegitTriggerDataField, @notLegitSurveyResponseObjectId, @duplicateCheck, @surveyResponseAlertsUnidentified, @surveyResponseAlertsDeletes, @throttleCheck

-- Testing
--SELECT *	FROM _surveyResponseAlert_Removal_Statistics
--SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitOrg, @notLegitTriggerDataField, @notLegitSurveyResponseObjectId, @duplicateCheck, @surveyResponseAlertsDeletes, @throttleCheck 



-- Results Print Out
PRINT 'Original CSV Row Count                         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   		AS money)), 1), '.00', '')
PRINT 'NULL Values Found                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   				AS money)), 1), '.00', '')
PRINT 'Non Legit OrgIds                               :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitOrg   				AS money)), 1), '.00', '')
PRINT 'Non Legit DataFields                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitTriggerDataField   AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseObjectId   AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                         :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   					AS money)), 1), '.00', '')
PRINT 'Unidentified Records / Alert Does Not Exist    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseAlertsUnidentified	AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                      AS money)), 1), '.00', '')
PRINT ''
PRINT 'Final Row Count for Delete :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseAlertsDeletes   		AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAlert_Remove_AutoDelivery 	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAlert_Remove_AutoDelivery 	@answer = ''terminate'''



RETURN
		

END












--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _surveyResponseAlert_Removal_Statistics )
SET		@check			=	( 
								SELECT 
										MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
								FROM 
										PutWh06.JobServerDb.dbo.ProductionDetailsCurrentAsOf
								WHERE
										CurrentAsOf IS NOT NULL
							)



IF @answerCheck = 1
BEGIN


	DECLARE @SrAlertDeleteCheck		int
	SET		@SrAlertDeleteCheck		= ( SELECT surveyResponseAlertsDeletes		FROM _surveyResponseAlert_Removal_Statistics )
	


	UPDATE _surveyResponseAlert_Removal_Statistics
	SET processingStart = GETDATE()
	
	
	IF @SrAlertDeleteCheck > 0
	BEGIN
		
		PRINT 'Deleting ' + CAST(@SrAlertDeleteCheck AS varchar) + ' records'
	
	
	
		/**************  Survey Response Alert Delete   **************/
	
		DECLARE @count bigint, @sraoid bigint, @sroid bigint, @tdfoid varchar(25), @aoid bigint

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseAlertObjectId, SurveyResponseObjectId, TriggerDataFieldObjectId, AlertObjectId	FROM _surveyResponseAlert_Removal_Deletes

		OPEN mycursor
		FETCH next FROM mycursor INTO @sraoid, @sroid, @tdfoid, @aoid

		WHILE @@Fetch_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@sraoid as varchar)+', '+cast(@sroid as varchar)+', '+cast(@tdfoid as varchar)+', '+cast(@aoid as varchar)


		----******************* W A R N I N G ***************************
		
			DELETE	t10
			FROM	SurveyResponseAlert		t10
			WHERE	objectId = @sraoid
			

		----*************************************************************

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
											CurrentAsOf IS NOT NULL
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
												CurrentAsOf IS NOT NULL
									)	
			END
		END


		-- Remainder of Cursor
		SET @count = @count + 1
		FETCH next FROM mycursor INTO @sraoid, @sroid, @tdfoid, @aoid

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@count as varchar)+' Records Processed'
	

	
		DECLARE @successfulDeletesV2		int
		SET		@successfulDeletesV2		= @SrAlertDeleteCheck - ( SELECT COUNT(1)		FROM _surveyResponseAlert_Removal_Deletes	t01		JOIN SurveyResponseAlert t02	WITH (NOLOCK) 	ON t01.SurveyResponseAlertObjectId = t02.objectId  )

		
		PRINT CHAR(9) + 'Requested Deletes: ' + CAST(@SrAlertDeleteCheck AS varchar) + ' Successful: ' + CAST(@successfulDeletesV2 as varchar)
		PRINT ''
		PRINT ''

		DECLARE	@failedDeletesV2			int
		SET		@failedDeletesV2			= ( SELECT COUNT(1)		FROM SurveyResponseAlert	WHERE objectId IN ( SELECT SurveyResponseAlertObjectId	FROM _surveyResponseAlert_Removal_Deletes )  )


		
	-- Builds delete failures table
	IF @failedDeletesV2 > 0
	BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_FailedDeletes') AND type = (N'U'))    DROP TABLE _surveyResponseAlert_Removal_FailedDeletes
	SELECT
			ObjectId					AS SurveyResponseAlertObjectId
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, AlertObjectId
			
	INTO 	_surveyResponseAlert_Removal_FailedDeletes
			
	FROM

			SurveyResponseAlert	
	WHERE 
			objectId IN 
							( 
								SELECT 
										SurveyResponseAlertObjectId	
								FROM 
										_surveyResponseAlert_Removal_Deletes
							)
	

	DELETE t10
	FROM
			_surveyResponseAlert_Removal_Deletes		t10
		JOIN
			_surveyResponseAlert_Removal_FailedDeletes	t20
				ON t10.SurveyResponseAlertObjectId = t20.SurveyResponseAlertObjectId
				
	
	END

	
	

	END
	
	UPDATE _surveyResponseAlert_Removal_Statistics
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
IF @SrAlertDeleteCheck > 0
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
		, @surveyResponseAlertsUnidentifiedV2	int
		, @surveyResponseAlertsDeletesV2		int
		, @FinalRowCountV2						int
		, @ProcessingStartV2					dateTime
		, @ProcessingCompleteV2					dateTime
		, @ProcessingDurationV2					varchar(25)


		, @Minutes								varchar(3)
		, @Seconds								varchar(3)



SET @deliveryEmailV2						= ( SELECT deliveryEmail					FROM _surveyResponseAlert_Removal_Statistics )
SET @FileNameV2								= ( SELECT inputFileName					FROM _surveyResponseAlert_Removal_Statistics )
SET @serverNameV2							= ( SELECT surverName						FROM _surveyResponseAlert_Removal_Statistics )
SET @originalFileSizeV2						= ( SELECT originalCount					FROM _surveyResponseAlert_Removal_Statistics )
SET @nullCountV2							= ( SELECT nullCount						FROM _surveyResponseAlert_Removal_Statistics )
SET @notLegitOrgV2							= ( SELECT notLegitOrg						FROM _surveyResponseAlert_Removal_Statistics )
SET @notLegitTriggerDataFieldV2 			= ( SELECT notLegitTriggerDataField			FROM _surveyResponseAlert_Removal_Statistics )
SET @notLegitSurveyResponseObjectIdV2		= ( SELECT notLegitSurveyResponseObjectId	FROM _surveyResponseAlert_Removal_Statistics )
SET @duplicateCheckV2						= ( SELECT duplicateCheck					FROM _surveyResponseAlert_Removal_Statistics )
SET @surveyResponseAlertsUnidentifiedV2		= ( SELECT unidentifiedRecords				FROM _surveyResponseAlert_Removal_Statistics )
SET @surveyResponseAlertsDeletesV2			= ( SELECT surveyResponseAlertsDeletes		FROM _surveyResponseAlert_Removal_Statistics )
SET @ProcessingStartV2						= ( SELECT ProcessingStart					FROM _surveyResponseAlert_Removal_Statistics )
SET @ProcessingCompleteV2					= ( SELECT ProcessingComplete				FROM _surveyResponseAlert_Removal_Statistics )
		
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
		, OrgId							int
		, AlertObjectId					int
	)


		
IF @notLegitOrgV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId	)
	SELECT 	'NonLegit OrgId'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId		
			
	FROM
			_surveyResponseAlert_Removal_BadOrgId

END


IF @notLegitTriggerDataFieldV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId	)
	SELECT 	'NonLegit TriggerDataField'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId		
			
	FROM
			_surveyResponseAlert_Removal_BadDataField

END
		

IF @notLegitSurveyResponseObjectIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId	)
	SELECT 	'NonLegit SurveyResponseObjectId'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId		
			
	FROM
			_surveyResponseAlert_Removal_BadSurveyResponseObjectId

END
		
		
IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId	)
	SELECT 	'Duplicate'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId		
			
	FROM
			_surveyResponseAlert_Removal_Duplicates

END


		
IF @surveyResponseAlertsUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId	)
	SELECT 	'Unidentified'
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId		
			
	FROM
			_surveyResponseAlert_Removal_Unidentified

END		
		
		
IF @surveyResponseAlertsDeletesV2 > 0
BEGIN		
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseAlertObjectId, SurveyResponseObjectId, TriggerDataFieldObjectId, OrgId, AlertObjectId	)
	SELECT 	'Deleted'
			, SurveyResponseAlertObjectId
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, OrgId		
			, AlertObjectId
	FROM
			_surveyResponseAlert_Removal_Deletes
		
END
		
		
IF @failedDeletesV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAlertStatus_Action ( Action, SurveyResponseAlertObjectId, SurveyResponseObjectId, TriggerDataFieldObjectId, AlertObjectId	)
	SELECT 	'Failed Delete'
			, SurveyResponseAlertObjectId
			, SurveyResponseObjectId
			, TriggerDataFieldObjectId
			, AlertObjectId
	FROM
			_surveyResponseAlert_Removal_FailedDeletes


END		
		
		
		

-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseAlertStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAlertStatus_Results
CREATE TABLE ##SurveyResponseAlertStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseAlertStatus_Results ( Item, Criteria )
SELECT 'Server Name'						, @serverNameV2
UNION ALL
SELECT 'Delivery Email'						, @deliveryEmailV2
UNION ALL
SELECT 'Input File Name'					, @FileNameV2
UNION ALL
SELECT 'CSV File Rows'						, REPLACE(CONVERT(varchar(20), (CAST( @originalFileSizeV2    			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( @nullCountV2    					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit OrgIds'					, REPLACE(CONVERT(varchar(20), (CAST( @notLegitOrgV2    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit TriggerDataField'			, REPLACE(CONVERT(varchar(20), (CAST( @notLegitTriggerDataFieldV2	    AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( @notLegitOrgV2    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( @duplicateCheckV2    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records / Alert Does Not Exist'				, REPLACE(CONVERT(varchar(20), (CAST( @surveyResponseAlertsUnidentifiedV2 AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Failed Deletes'						, REPLACE(CONVERT(varchar(20), (CAST( @failedDeletesV2   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Requested Deletes'					, REPLACE(CONVERT(varchar(20), (CAST( @surveyResponseAlertsDeletesV2   	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Deletes'					, REPLACE(CONVERT(varchar(20), (CAST( @successfulDeletesV2   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		


DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponseAlert_Remove_Completed.csv' ) 

		
		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseAlertObjectId
										, SurveyResponseObjectId
										, TriggerDataFieldObjectId
										, OrgId
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
Survey Response Alert Removal
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2+ @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'tpeterson@InMoment.com; bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Survey Response Alert Removal'
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


-- Testing
/*
SELECT * FROM _surveyResponseAlert_Removal
SELECT * FROM _surveyResponseAlert_Removal_BadOrgId
SELECT * FROM _surveyResponseAlert_Removal_BadDataField
SELECT * FROM _surveyResponseAlert_Removal_BadSurveyResponseObjectId
SELECT * FROM _surveyResponseAlert_Removal_Duplicates
SELECT * FROM _surveyResponseAlert_Removal_Deletes
SELECT * FROM _surveyResponseAlert_Removal_Statistics
SELECT * FROM _surveyResponseAlert_Removal_Unidentified
SELECT * FROM _surveyResponseAlert_Removal_FailedDeletes

*/


	PRINT 'Cleaning up temp tables'
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal') AND type = (N'U'))    					DROP TABLE _surveyResponseAlert_Removal
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_BadOrgId') AND type = (N'U'))    		DROP TABLE _surveyResponseAlert_Removal_BadOrgId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_BadDataField') AND type = (N'U'))    	DROP TABLE _surveyResponseAlert_Removal_BadDataField
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_BadSurveyResponseObjectId') AND type = (N'U')) DROP TABLE _surveyResponseAlert_Removal_BadSurveyResponseObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Duplicates') AND type = (N'U'))    		DROP TABLE _surveyResponseAlert_Removal_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Deletes') AND type = (N'U'))    			DROP TABLE _surveyResponseAlert_Removal_Deletes
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Statistics') AND type = (N'U'))    		DROP TABLE _surveyResponseAlert_Removal_Statistics
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_Unidentified') AND type = (N'U'))		DROP TABLE _surveyResponseAlert_Removal_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAlert_Removal_FailedDeletes') AND type = (N'U'))    			DROP TABLE _surveyResponseAlert_Removal_FailedDeletes
	
	IF OBJECT_ID('tempdb..##TempRemoval') IS NOT NULL			DROP TABLE ##TempRemoval


	PRINT 'Cleanup is complete'
	


	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
