SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		
		, @throttle				int				= 1

AS
	
/****************  BackFill Options Auto Deliver  ****************

	Tested With live data 5/23/2012; successful.
	
	History
		06.25.2014	Tad Peterson
			-- added throttling
		
		04.05.2017 Bailey Hu
			-- Added detection/prevention of changes to migrated orgs.
		

	Execute on OLTP.
	
	sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated		
		@deliveryEmail			= 'tpeterson@InMoment.com'
		, @FileName				= NULL

		, @answer				= NULL		
		, @throttle				= 1

	
*****************************************************************/

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

										
--SELECT 	@deliveryEmailCheck, @FileNameCheck, @dataFieldObjectId01Check, @dataFieldObjectId02Check, @dataFieldObjectId03Check, @dataFieldObjectId04Check, @dataFieldObjectId05Check, @answerCheck, @ThrottleCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'SurveyResponseAnswer DataField Update'
		PRINT CHAR(9) + 'Description:  Updates a DataFieldId_Old to a DataFieldId_New from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides an explanation to the requestor regarding how the file should be built .'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                                 -   Lists description, any optional criteria, and file setup '
		PRINT CHAR(9) + 'Delivery email address                                -   Sends requestor explanation of file setup. '
		PRINT CHAR(9) + 'Delivery email address & File name                    -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'DataFieldId_Old' + CHAR(13) + CHAR(9) + 'DataFieldId_New'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a spreadsheet with answers for them to create the file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		PRINT '' 
		
	RETURN
	END		


-- Sends explanation to requestor
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
	AND
		@answerCheck = 0

BEGIN


	PRINT 'Emailed form to ' + @deliveryEmail
	

	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'New DataFieldId File Setup Explanation'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseId	DataFieldId_Old		DataFieldId_New
103090587		22340			      59820
103090588		22340			      59820






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

sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		


	
-- Example Below --

sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew
CREATE TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew
		(
			SurveyResponseId			bigint
			, DataFieldId_Old			int	
			, DataFieldId_New			int
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _SurveyResponseAnswer_DataFieldOld_DataFieldNew   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)



-- Inspect data set for changes to migrated orgs
select objectid as organizationObjectId into #tmp_ODS_ORGS from organization with (nolock) where responseBehavior = 1

IF 
	EXISTS (
		SELECT 1 
		FROM 
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew x
		inner join surveyResponse sr with (nolock) on x.SurveyResponseId = sr.objectId
		inner join location loc with (nolock) on sr.locationObjectId = loc.objectId
		inner join #tmp_ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
		--inner join _ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
	)
BEGIN
	PRINT 'Detected changes to a migrated org.'
	PRINT 'Cleaning up and exiting the process.'
	DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew
	RETURN
END

DROP TABLE #tmp_ODS_ORGS

DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew	WHERE SurveyResponseId IS NULL	OR	DataFieldId_Old IS NULL	OR  DataFieldId_New IS NULL )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew
	WHERE
			SurveyResponseId	IS NULL
		OR
			DataFieldId_Old		IS NULL
		OR
			DataFieldId_New		IS NULL
			
END			




-- Verifies DataField_New is legit
DECLARE @notLegitDataField_New		int
SET		@notLegitDataField_New		= 
														(
															SELECT
																	COUNT(1)
															FROM
																	_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
																LEFT JOIN
																	DataField											t02
																			ON t01.DataFieldId_New = t02.ObjectId 
															WHERE
																	t02.objectId IS NULL		
														)

--SELECT @notLegitDataField_New



-- Non legit DataFieldId_Old & dataFieldOption pairs; preserved and deleted
IF @notLegitDataField_New > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Bad') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Bad
	SELECT
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
	INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Bad
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
		LEFT JOIN
			DataField											t02
					ON t01.DataFieldId_New = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
		LEFT JOIN
			DataField											t02
					ON t01.DataFieldId_New = t02.objectId
	WHERE
			t02.objectId IS NULL		

END




DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
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
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
	INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_BadSurveyResponseId
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
		LEFT JOIN
			SurveyResponse										t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
		LEFT JOIN
			SurveyResponse										t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

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
													, DataFieldId_Old
													, DataFieldId_New
											FROM
													_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
											GROUP BY 
													SurveyResponseId
													, DataFieldId_Old
													, DataFieldId_New
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates
	SELECT
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
	INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates		
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew				t01

	GROUP BY 
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew				t01
		JOIN
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.DataFieldId_Old			= t02.DataFieldId_Old
							AND
								t01.DataFieldId_New	= t02.DataFieldId_New

		
	-- Puts single version back in original file
	INSERT INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew ( SurveyResponseId, DataFieldId_Old, DataFieldId_New )
	SELECT
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates			


END



-- Checks for existing records
DECLARE @surveyResponseDataFieldNewExist	int
SET		@surveyResponseDataFieldNewExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId_New		= t02.DataFieldObjectId
															)


--SELECT @surveyResponseDataFieldNewExist


-- Removes existing records; preserve and removes
IF @surveyResponseDataFieldNewExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist
	SELECT
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId_New		= t02.DataFieldObjectId

	-- Deletes Exist
	DELETE	t01
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew				t01
		JOIN
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId_Old		= t02.DataFieldId_Old
						AND
							t01.DataFieldId_New		= t02.DataFieldId_New
					


END




DECLARE @surveyResponseDataFieldOldDataFieldNewUpdate	int
SET		@surveyResponseDataFieldOldDataFieldNewUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId_Old		= t02.DataFieldObjectId
															)


-- Seperates updating records; preserve and removes
IF @surveyResponseDataFieldOldDataFieldNewUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update
	SELECT
			SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New
			, t02.objectId					AS SurveyResponseAnswerId
			
	INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId_Old		= t02.DataFieldObjectId

	-- Deletes Updates
	DELETE	t01
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew				t01
		JOIN
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId_Old			= t02.DataFieldId_Old
					


END







-- Identifies any remaining rows in original file
DECLARE @surveyResponseDataFieldOldDataFieldNewUnidentified		int
SET		@surveyResponseDataFieldOldDataFieldNewUnidentified		= ( SELECT COUNT(1)	FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew )


IF @surveyResponseDataFieldOldDataFieldNewUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Unidentified') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Unidentified
	SELECT
			*
	INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Unidentified
	FROM
		_SurveyResponseAnswer_DataFieldOld_DataFieldNew
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics
CREATE TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, surverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitDataFieldNew_Bad								int
		, notLegitSurveyResponseId								int
		, duplicateCheck										int
		, surveyResponseDataFieldOldDataFieldNewExist			int
		, surveyResponseDataFieldOldDataFieldNewUpdate			int
		, surveyResponseDataFieldOldDataFieldNewUnidentified	int
		, throttle												int
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics ( DeliveryEmail, inputFileName, surverName, originalCount, nullCount, notLegitDataFieldNew_Bad, notLegitSurveyResponseId, duplicateCheck, surveyResponseDataFieldOldDataFieldNewExist, surveyResponseDataFieldOldDataFieldNewUpdate,  surveyResponseDataFieldOldDataFieldNewUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitDataField_New, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseDataFieldNewExist , @surveyResponseDataFieldOldDataFieldNewUpdate, @surveyResponseDataFieldOldDataFieldNewUnidentified, @throttleCheck




-- Results Print Out
PRINT 'SurveyResponseAnswer DataFieldOld DataFieldNew Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   									AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   											AS money)), 1), '.00', '')
PRINT 'Non Legit DataFields New                 :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitDataField_New					                AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId								AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   										AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldNewExist   			            AS money)), 1), '.00', '')
PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldOldDataFieldNewUpdate   		AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldOldDataFieldNewUnidentified   	AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                          AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponseAnswer_DataFieldOld_DataFieldNew_AutoDelivery_Unmigrated	@answer = ''terminate'''

RETURN

END







/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
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
	
	DECLARE @sraUpdateCheck		int
	SET		@sraUpdateCheck		= ( SELECT surveyResponseDataFieldOldDataFieldNewUpdate		FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
	

	UPDATE	_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @sraUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@sraUpdateCheck AS varchar) + ' records'
	
		/********************  SurveyResponseAnswer DataField DataField Update  ********************/

		-----Cursor for SRA Update

		DECLARE @count bigint, @SurveyResponseAnswerId bigint, @DataFieldId_New bigint

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseAnswerId, DataFieldId_New FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseAnswerId, @DataFieldId_New

		WHILE @@Fetch_Status = 0
		BEGIN


			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseAnswerId as varchar)+', '+cast(@DataFieldId_New as varchar)


		----******************* W A R N I N G***************************


		UPDATE SurveyResponseAnswer	WITH (ROWLOCK)
		SET dataFieldObjectId = @DataFieldId_New
		WHERE objectId = @SurveyResponseAnswerId


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
		SET @count = @count + 1
		FETCH next FROM mycursor INTO @SurveyResponseAnswerId, @DataFieldId_New

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update	t01		JOIN SurveyResponseAnswer t02	ON t01.surveyResponseAnswerId = t02.objectId AND t01.DataFieldId_New = t02.dataFieldObjectId )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@sraUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END
	
	
	
	


	UPDATE	_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics
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
IF @sraUpdateCheck > 0 
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitDataField_NewV2									int
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @surveyResponseDataFieldNewExistV2						int
		, @surveyResponseDataFieldOldDataFieldNewUpdateV2			int
		, @surveyResponseDataFieldOldDataFieldNewUnidentifiedV2		int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @serverNameV2											= ( SELECT surverName												FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @notLegitDataField_NewV2 								= ( SELECT notLegitDataFieldNew_Bad									FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @notLegitSurveyResponseIdV2								= ( SELECT notLegitSurveyResponseId									FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @duplicateCheckV2										= ( SELECT duplicateCheck											FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @surveyResponseDataFieldNewExistV2						= ( SELECT surveyResponseDataFieldOldDataFieldNewExist				FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @surveyResponseDataFieldOldDataFieldNewUpdateV2			= ( SELECT surveyResponseDataFieldOldDataFieldNewUpdate				FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @surveyResponseDataFieldOldDataFieldNewUnidentifiedV2	= ( SELECT surveyResponseDataFieldOldDataFieldNewUnidentified		FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )


SET @ProcessingStartV2			= ( SELECT ProcessingStart				FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
SET @ProcessingCompleteV2		= ( SELECT ProcessingComplete			FROM _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Action') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Action
CREATE TABLE ##SurveyResponseAnswerStatus_Action
	(
		Action								varchar(50)
		, SurveyResponseId					bigInt
		, DataFieldId_Old					int
		, DataFieldId_New					nvarchar(2000)
		, SurveyResponseAnswerId			bigInt
	)




IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId_Old, DataFieldId_New )
	SELECT 	'NonLegit SurveyResponseId'
		, SurveyResponseId
		, DataFieldId_Old
		, DataFieldId_New		
			
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_BadSurveyResponseId
END


IF @notLegitDataField_NewV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId_Old, DataFieldId_New )
	SELECT 	'NonLegit DataField New'
			, SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New	
			
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Bad
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId_Old, DataFieldId_New )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New	
			
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates

END
		



IF @surveyResponseDataFieldNewExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId_Old, DataFieldId_New, SurveyResponseAnswerId )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, DataFieldId_Old
		, DataFieldId_New		
		, SurveyResponseAnswerId
			
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist

END




IF @surveyResponseDataFieldOldDataFieldNewUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId_Old, DataFieldId_New )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New	
			
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Unidentified

END



IF @surveyResponseDataFieldOldDataFieldNewUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId_Old, DataFieldId_New, SurveyResponseAnswerId )
	SELECT 	'Updated'
			, SurveyResponseId
			, DataFieldId_Old
			, DataFieldId_New		
			, SurveyResponseAnswerId
	FROM
			_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update

END



		



-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results
CREATE TABLE ##SurveyResponseAnswerStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseAnswerStatus_Results ( Item, Criteria )
SELECT 'Server Name'						, @serverNameV2
UNION ALL
SELECT 'Delivery Email'						, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'					, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   												AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    													AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit DataFieldId New'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitDataField_NewV2 , 0)											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldNewExistV2 , 0)								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldOldDataFieldNewUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldOldDataFieldNewUpdateV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponseAnswer_DataFieldIdOld_DataFieldIdNew_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, DataFieldId_Old
										, DataFieldId_New		
										, SurveyResponseAnswerId
												
								FROM 
										##SurveyResponseAnswerStatus_Action

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
Survey Response Answer DataFieldId_Old DataFieldId_New Update
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'tpeterson@InMoment.com; bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'SurveyResponseAnswer DataFieldIdOld DataFieldIdNew Completed'
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
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew') AND type = (N'U'))						DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Bad') AND type = (N'U'))				DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Bad
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates') AND type = (N'U'))				DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist') AND type = (N'U'))					DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update') AND type = (N'U'))					DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Unidentified') AND type = (N'U'))			DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics') AND type = (N'U'))				DROP TABLE _SurveyResponseAnswer_DataFieldOld_DataFieldNew_Statistics

	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Action') IS NOT NULL		DROP TABLE ##SurveyResponseAnswerStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results




	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
