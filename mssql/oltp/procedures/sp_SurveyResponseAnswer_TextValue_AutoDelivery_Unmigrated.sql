SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated]
		@deliveryEmail	varchar(100)	= NULL
		, @FileName		varchar(100)	= NULL
		
		, @answer		varchar(10)		= NULL		
		, @throttle				int		= 1
		
AS

/************** Survey Response Answer Modify TextValue  **************

	Updates TextValue from a provided file into survey
	response answer.
	
	Executed against OLTP only

	Note: Executing these SP without any parameters will
	print out requirements.
	
	sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated	
		@deliveryEmail	= ''''
		, @FileName		= ''''

	History
		3.30.2013	Tad Peterson
			-- to allow update of a present dataField that is NULL
			-- see update prep section.
		
		10.03.2014	Tad Peterson
			-- added throttling
			
		10.06.2014	Tad Peterson	
			-- added non-legit systemField validation
		
		04.05.2017 Bailey Hu
			-- Added detection/prevention of changes to migrated orgs.
			
		
*******************************************************************/

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
										
										
DECLARE @ThrottleCheck							int
SET		@ThrottleCheck							= CASE	WHEN @throttle IS NULL			THEN 1
														WHEN @throttle = 0 				THEN 0
													ELSE 1
													END
													

-- These are used for throttling														
DECLARE @message								nvarchar(200)
DECLARE @check									int
										
										

										
IF @answerCheck > 0
GOTO PROCESSING									
										
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@FileNameCheck			= 0	
			
	BEGIN
	
		PRINT 'Survey Response Answer DataField TextValue Update/Insert'
		PRINT CHAR(9) + 'Description:  Updates the TextValue in SurveyResponseAnswer based on a specified DataFieldId, from a provided file.'
		PRINT CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'File name'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'None'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''		
		PRINT ''
		PRINT CHAR(13) + 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'DataFieldId' + CHAR(13) + CHAR(9) + 'TextValue'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated'
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
, @subject			= 'Survey Response Answer TextValue Update Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseId     DataFieldId     TextValue
103090587            46627           001
103090588            15261           Very Pleased




Notes & Comments
-----------------
	1. Please be aware of proper file setup (order) to ensure successful processing.
	2. TextValue column is a varchar which means the character(s) will be exactly how they look in the file.
	3. Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	4. File should be in CSV format.
	5. File restictions require the size to be 5 MB or less.  
	6. Row count does not matter as this process is throttled.
	7. Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated
		@deliveryEmail	= ''your email address here''
		, @FileName		= ''file name here''
		

		
		
-- Example Below --

sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated
		@deliveryEmail	= ''tpeterson@InMoment.com''
		, @FileName		= ''20120514LawnCareDataUpdateRoute.csv''
		

		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue
CREATE TABLE _surveyResponseAnswer_DataField_TextValue
		(
			SurveyResponseId			bigint
			, DataFieldId			int	
			, TextValue					nvarchar(2000)
		)


DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponseAnswer_DataField_TextValue   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)


-- Inspect data set for changes to migrated orgs
select objectid as organizationObjectId into #tmp_ODS_ORGS from organization with (nolock) where responseBehavior = 1

IF 
	EXISTS (
		SELECT 1 
		FROM 
			_surveyResponseAnswer_DataField_TextValue x
		inner join surveyResponse sr with (nolock) on x.SurveyResponseId = sr.objectId
		inner join location loc with (nolock) on sr.locationObjectId = loc.objectId
		inner join #tmp_ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
		--inner join _ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
	)
BEGIN
	PRINT 'Detected changes to a migrated org.'
	PRINT 'Cleaning up and exiting the process.'
	DROP TABLE _surveyResponseAnswer_DataField_TextValue
	RETURN
END

DROP TABLE #tmp_ODS_ORGS

			
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponseAnswer_DataField_TextValue	)
			

--SELECT @originalFileSize

DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponseAnswer_DataField_TextValue	WHERE SurveyResponseId IS NULL	OR	DataFieldId IS NULL	OR  TextValue IS NULL )


--SELECT @nullCount

-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponseAnswer_DataField_TextValue
	WHERE
			SurveyResponseId IS NULL
		OR
			DataFieldId IS NULL
		OR
			TextValue IS NULL
			
END			






-- Verifies DataField is legit
DECLARE @notLegitDataField	int
SET		@notLegitDataField	= 
										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAnswer_DataField_TextValue	t01
												LEFT JOIN
													DataField									t02
															ON t01.DataFieldId = t02.objectId AND t02.systemField = 0 
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitDataField

-- Non legit dataField; preserved and deleted
IF @notLegitDataField > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_BadDataField') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_BadDataField
	SELECT
			SurveyResponseId
			, DataFieldId
			, TextValue
	INTO _surveyResponseAnswer_DataField_TextValue_BadDataField
	FROM
			_surveyResponseAnswer_DataField_TextValue	t01
		LEFT JOIN
			DataField									t02
				ON t01.DataFieldId = t02.objectId AND t02.systemField = 0 
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM	
			_surveyResponseAnswer_DataField_TextValue	t01
		LEFT JOIN
			DataField									t02
				ON t01.DataFieldId = t02.objectId AND t02.systemField = 0 
	WHERE
			t02.objectId IS NULL		

END




--SELECT @originalFileSize, REPLACE(CONVERT(varchar(20), (CAST(COUNT(1) AS money)), 1), '.00', '')	FROM	_surveyResponseAnswer_DataField_TextValue



DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAnswer_DataField_TextValue	t01
												LEFT JOIN
													SurveyResponse							t02		WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)


-- Non survey Response Id; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, DataFieldId
			, TextValue
	INTO _surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId
	FROM
			_surveyResponseAnswer_DataField_TextValue	t01
		LEFT JOIN
			SurveyResponse							t02		WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_TextValue	t01
		JOIN
			_surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId		t02
					ON t01.SurveyResponseId = t02.SurveyResponseId

END


--SELECT @notLegitSurveyResponseId


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
													, DataFieldId
													, TextValue
													
											FROM
													_surveyResponseAnswer_DataField_TextValue	t01

											GROUP BY 
													SurveyResponseId
													, DataFieldId
													, TextValue	
											HAVING	COUNT(1) > 1
										) AS t101
								)

-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_Duplicates
	SELECT
			SurveyResponseId
			, DataFieldId
			, TextValue
	INTO _surveyResponseAnswer_DataField_TextValue_Duplicates		
	FROM
			_surveyResponseAnswer_DataField_TextValue	t01

	GROUP BY 
			SurveyResponseId
			, DataFieldId
			, TextValue	
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_TextValue				t01
		JOIN
			_surveyResponseAnswer_DataField_TextValue_Duplicates	t02
						ON	t01.SurveyResponseId			= t02.SurveyResponseId
						AND
							t01.DataFieldId	= t02.DataFieldId
						AND
							t01.TextValue						= t02.TextValue
		
	-- Puts single version back in original file
	INSERT INTO _surveyResponseAnswer_DataField_TextValue ( SurveyResponseId, DataFieldId, TextValue )
	SELECT
			SurveyResponseId
			, DataFieldId
			, TextValue	
	FROM
			_surveyResponseAnswer_DataField_TextValue_Duplicates			


END


--SELECT * FROM _surveyResponseAnswer_DataField_TextValue_Duplicates






-- Checks for existing records
DECLARE @surveyResponseDataFieldTextValueExist	int
SET		@surveyResponseDataFieldTextValueExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseAnswer_DataField_TextValue		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																					AND
																						t01.TextValue			= t02.TextValue
															)


--SELECT @surveyResponseDataFieldTextValueExist


-- Removes existing records; preserve and removes
IF @surveyResponseDataFieldTextValueExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Exist') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_Exist
	SELECT
			SurveyResponseId
			, DataFieldId
			, t01.TextValue
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _surveyResponseAnswer_DataField_TextValue_Exist
	FROM
			_surveyResponseAnswer_DataField_TextValue		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
						AND
							t01.TextValue			= t02.TextValue

	-- Deletes Exist
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_TextValue				t01
		JOIN
			_surveyResponseAnswer_DataField_TextValue_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.TextValue			= t02.TextValue
					


END



-- Checks for Updateing records
DECLARE @surveyResponseDataFieldTextValueUpdate	int
SET		@surveyResponseDataFieldTextValueUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseAnswer_DataField_TextValue		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																					AND
																						--Added the OR IS NULL to capture Will Fraziers promptChange fix
																						(
																								t01.TextValue			!= t02.TextValue
																							OR
																								t02.TextValue IS NULL
																						)
															)


--SELECT @surveyResponseDataFieldTextValueUpdate


-- Removes Updating records; preserve and removes
IF @surveyResponseDataFieldTextValueUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Update') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_Update
	SELECT
			SurveyResponseId
			, DataFieldId
			, t01.TextValue
			, t02.objectId			AS SurveyResponseAnswerId
			, t02.TextValue			AS TextValue_Old
			
	INTO _surveyResponseAnswer_DataField_TextValue_Update
	FROM
			_surveyResponseAnswer_DataField_TextValue		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
						AND
							--Added the OR IS NULL to capture Will Fraziers promptChange fix
							(
									t01.TextValue	!= t02.TextValue
								OR
									t02.TextValue IS NULL
							)
							
							

	-- Deletes Update
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_TextValue				t01
		JOIN
			_surveyResponseAnswer_DataField_TextValue_Update		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.TextValue			= t02.TextValue
					


END





-- Checks for Inserting records
DECLARE @surveyResponseDataFieldTextValueInsert	int
SET		@surveyResponseDataFieldTextValueInsert	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseAnswer_DataField_TextValue		t01
																	LEFT JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																						
															)


--SELECT @surveyResponseDataFieldTextValueInsert


-- Removes Inserting records; preserve and removes
IF @surveyResponseDataFieldTextValueInsert > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Insert') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_Insert
	SELECT
			SurveyResponseId
			, DataFieldId
			, t01.TextValue
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _surveyResponseAnswer_DataField_TextValue_Insert
	FROM
			_surveyResponseAnswer_DataField_TextValue		t01
		LEFT JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId

	-- Deletes Insert
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_TextValue				t01
		JOIN
			_surveyResponseAnswer_DataField_TextValue_Insert		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.TextValue			= t02.TextValue
					


END





-- Identifies any remaining rows in original file
DECLARE @surveyResponseDataFieldTextValueUnidentified		int
SET		@surveyResponseDataFieldTextValueUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponseAnswer_DataField_TextValue )


IF @surveyResponseDataFieldTextValueUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_Unidentified
	SELECT
			*
	INTO _surveyResponseAnswer_DataField_TextValue_Unidentified
	FROM
		_surveyResponseAnswer_DataField_TextValue
	
END






IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_Statistics
CREATE TABLE _surveyResponseAnswer_DataField_TextValue_Statistics
	(
		DeliveryEmail										varchar(100)
		, inputFileName										varchar(100)
		, serverName										varchar(25)
		, originalCount										int
		, nullCount											int
		, notLegitDataField									int
		, notLegitSurveyResponseId							int
		, duplicateCheck									int
		, surveyResponseDataFieldTextValueExist				int
		, surveyResponseDataFieldTextValueUpdate			int
		, surveyResponseDataFieldTextValueInsert			int
		, surveyResponseDataFieldTextValueUnidentified		int
		, throttle											int				
		, processingStart									dateTime
		, processingComplete								dateTime

	)		

INSERT INTO _surveyResponseAnswer_DataField_TextValue_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitDataField, notLegitSurveyResponseId, duplicateCheck, surveyResponseDataFieldTextValueExist, surveyResponseDataFieldTextValueUpdate, surveyResponseDataFieldTextValueInsert, surveyResponseDataFieldTextValueUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitDataField, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseDataFieldTextValueExist , @surveyResponseDataFieldTextValueUpdate, @surveyResponseDataFieldTextValueInsert, @surveyResponseDataFieldTextValueUnidentified, @throttleCheck




-- Results Print Out
PRINT 'Original CSV Row Count     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   		AS money)), 1), '.00', '')
PRINT 'NULL Values Found          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   				AS money)), 1), '.00', '')
PRINT 'Non Legit DataFields       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitDataField			AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId   AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   			AS money)), 1), '.00', '')
PRINT 'Records Already Exist      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldTextValueExist   		AS money)), 1), '.00', '')
PRINT 'Records Needing Update     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldTextValueUpdate   		AS money)), 1), '.00', '')
PRINT 'Records Needing Insert     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldTextValueInsert   		AS money)), 1), '.00', '')
PRINT 'Records Unidentified       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldTextValueUnidentified   AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                  :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                          AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated @answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponseAnswer_TextValue_AutoDelivery_Unmigrated @answer = ''terminate'''




		
RETURN
END



--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
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



					



IF @answerCheck = 1
BEGIN

	DECLARE @sraUpdateCheck		int
	SET		@sraUpdateCheck		= ( SELECT surveyResponseDataFieldTextValueUpdate			FROM _surveyResponseAnswer_DataField_TextValue_Statistics )

	DECLARE @sraInsertCheck		int
	SET		@sraInsertCheck		= ( SELECT surveyResponseDataFieldTextValueInsert		FROM _surveyResponseAnswer_DataField_TextValue_Statistics )

	
	
	UPDATE _surveyResponseAnswer_DataField_TextValue_Statistics
	SET processingStart = GETDATE()

	
	--If statements for Cursors Here
	IF @sraUpdateCheck > 0
	BEGIN

		PRINT 'Updating ' + CAST(@sraUpdateCheck AS varchar) + ' records'


		/********************  SurveyResponseAnswer TextValue Update  ********************/


		-----Cursor for Survey Response Answer Update

		DECLARE @count bigint, @sraoid bigint, @textValue nvarchar(2000)

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseAnswerId, TextValue		FROM _surveyResponseAnswer_DataField_TextValue_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @sraoid, @textValue

		WHILE @@Fetch_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@sraoid as varchar)+', '+cast(@textValue as varchar)


		----******************* W A R N I N G***************************


		UPDATE SurveyResponseAnswer		WITH (ROWLOCK)
		SET 	TextValue 	= @textValue
		WHERE	objectId 	= @sraoid


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
		FETCH next FROM mycursor INTO @sraoid, @textValue

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@count as varchar)+' Records Processed'

		/**************************************************************************************/




		PRINT ''			
		PRINT 'Update Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Updates'
		
		DECLARE @successfulUpdates		int
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _surveyResponseAnswer_DataField_TextValue_Update	t01		JOIN SurveyResponseAnswer t02	ON t01.surveyResponseAnswerId = t02.objectId AND t01.dataFieldId = t02.DataFieldObjectId AND t01.TextValue = t02.textValue )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@sraUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	IF @sraInsertCheck > 0
	BEGIN
	
		PRINT 'Inserting ' + CAST(@sraInsertCheck AS varchar) + ' records'
	
		/********************  SurveyResponseAnswer DataField TextValue Insert  ********************/

		-----Cursor for SRA Insert

		DECLARE @countV2 bigint, @SurveyResponseIdV2 bigint, @DataFieldIdV2 bigint, @TextValueV2 nvarchar(2000), @newSequence bigint

		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, DataFieldId, TextValue FROM _surveyResponseAnswer_DataField_TextValue_Insert

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @DataFieldIdV2, @TextValueV2

		WHILE @@Fetch_Status = 0
		BEGIN

		SET @newSequence =	( SELECT max(sequence) + 1	FROM surveyResponseAnswer WHERE surveyResponseObjectId = @SurveyResponseIdV2 )
			  
		PRINT cast(@countV2 as varchar)+', '+cast(@SurveyResponseIdV2 as varchar)+', '+cast(@DataFieldIdV2 as varchar)+', '+cast(@TextValueV2 as varchar)+', '+cast(@newSequence as varchar)


		----******************* W A R N I N G***************************


		INSERT INTO surveyResponseAnswer (surveyResponseObjectId, DataFieldObjectId, TextValue, sequence)
		SELECT @SurveyResponseIdV2, @DataFieldIdV2, @TextValueV2, @newSequence


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
		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @DataFieldIdV2, @TextValueV2

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@countV2 as varchar)+' Records Processed'


		/**************************************************************************************************/



		PRINT ''	
		PRINT 'Insert Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Inserts'
		
		
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_InsertCompleted') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_InsertCompleted
		SELECT
				SurveyResponseId
				, DataFieldId
				, t01.TextValue
				, t02.objectId			AS SurveyResponseAnswerId
		INTO _surveyResponseAnswer_DataField_TextValue_InsertCompleted
		FROM 
				_surveyResponseAnswer_DataField_TextValue_Insert				t01		
			JOIN 
				SurveyResponseAnswer											t02	WITH (NOLOCK)
						ON 
							t01.surveyResponseId	= t02.SurveyResponseObjectId 
						AND 
							t01.dataFieldId			= t02.DataFieldObjectId 
						AND 
							t01.TextValue			= t02.TextValue 
		
		
		-- Deletes Successful Inserts
		DELETE FROM t01
		FROM
				_surveyResponseAnswer_DataField_TextValue_Insert				t01
			JOIN
				_surveyResponseAnswer_DataField_TextValue_InsertCompleted		t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.DataFieldId			= t02.DataFieldId
							AND
								t01.TextValue			= t02.TextValue
		
		
		
		DECLARE @successfulInsert		int
		SET		@successfulInsert		= ( SELECT COUNT(1)		FROM _surveyResponseAnswer_DataField_TextValue_InsertCompleted )
		
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@sraInsertCheck AS varchar) + ' Successful: ' + CAST(@successfulInsert as varchar)
		PRINT ''
		PRINT ''
		
		
	
	END

	
	
	

	UPDATE _surveyResponseAnswer_DataField_TextValue_Statistics
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
IF @sraUpdateCheck > 0 OR @sraInsertCheck > 0 
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitDataFieldV2										int
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @surveyResponseDataFieldTextValueExistV2					int
		, @surveyResponseDataFieldTextValueUpdateV2					int
		, @surveyResponseDataFieldTextValueInsertV2					int
		, @surveyResponseDataFieldTextValueUnidentifiedV2			int
		, @surveyResponseDataFieldTextValueInsertFailedV2			int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @serverNameV2											= ( SELECT serverName												FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @notLegitDataFieldV2 									= ( SELECT notLegitDataField										FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @notLegitSurveyResponseIdV2								= ( SELECT notLegitSurveyResponseId									FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @duplicateCheckV2										= ( SELECT duplicateCheck											FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @surveyResponseDataFieldTextValueExistV2				= ( SELECT surveyResponseDataFieldTextValueExist					FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @surveyResponseDataFieldTextValueUpdateV2				= ( SELECT surveyResponseDataFieldTextValueUpdate					FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @surveyResponseDataFieldTextValueInsertV2				= ( SELECT surveyResponseDataFieldTextValueInsert					FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @surveyResponseDataFieldTextValueUnidentifiedV2			= ( SELECT surveyResponseDataFieldTextValueUnidentified				FROM _surveyResponseAnswer_DataField_TextValue_Statistics )


IF @sraInsertCheck > 0
BEGIN
	SET @surveyResponseDataFieldTextValueInsertFailedV2			= ( SELECT COUNT(1)													FROM _surveyResponseAnswer_DataField_TextValue_Insert )
END


SET @ProcessingStartV2			= ( SELECT ProcessingStart				FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
SET @ProcessingCompleteV2		= ( SELECT ProcessingComplete			FROM _surveyResponseAnswer_DataField_TextValue_Statistics )
		
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
		, DataFieldId						int
		, TextValue							nvarchar(2000)
		, SurveyResponseAnswerId			bigInt
		, TextValue_Old						nvarchar(2000)
	)


IF @surveyResponseDataFieldTextValueInsertFailedV2 > 0
BEGIN	
	INSERT INTO ##SurveyResponseAnswerStatus_Action	( Action, SurveyResponseId, DataFieldId, TextValue )
	SELECT 	'Insert Failed'
			, SurveyResponseId
			, DataFieldId
			, TextValue		
			
	FROM
			_surveyResponseAnswer_DataField_TextValue_Insert

END


IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue )
	SELECT 	'NonLegit SurveyResponseId'
		, SurveyResponseId
		, DataFieldId
		, TextValue		
			
	FROM
			_surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId
END


IF @notLegitDataFieldV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue )
	SELECT 	'NonLegit DataField'
			, SurveyResponseId
			, DataFieldId
			, TextValue	
			
	FROM
			_surveyResponseAnswer_DataField_TextValue_BadDataField
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, DataFieldId
			, TextValue	
			
	FROM
			_surveyResponseAnswer_DataField_TextValue_Duplicates

END
		



IF @surveyResponseDataFieldTextValueExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue, SurveyResponseAnswerId )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, DataFieldId
		, TextValue		
		, SurveyResponseAnswerId
			
	FROM
			_surveyResponseAnswer_DataField_TextValue_Exist

END




IF @surveyResponseDataFieldTextValueUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, DataFieldId
			, TextValue	
			
	FROM
			_surveyResponseAnswer_DataField_TextValue_Unidentified

END



IF @surveyResponseDataFieldTextValueUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue, SurveyResponseAnswerId, TextValue_Old )
	SELECT 	'Updated'
			, SurveyResponseId
			, DataFieldId
			, TextValue		
			, SurveyResponseAnswerId
			, TextValue_Old
	FROM
			_surveyResponseAnswer_DataField_TextValue_Update

END




IF @surveyResponseDataFieldTextValueInsertV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, TextValue, SurveyResponseAnswerId )
	SELECT 	'Inserted'
			, SurveyResponseId
			, DataFieldId
			, TextValue		
			, SurveyResponseAnswerId
	FROM
			_surveyResponseAnswer_DataField_TextValue_InsertCompleted

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
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit DataField'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitDataFieldV2 , 0)										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldTextValueExistV2 , 0)					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldTextValueUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldTextValueUpdateV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldTextValueInsertV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Insert'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulInsert , 0)   										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Failed Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldTextValueInsertFailedV2 , 0)   		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponseAnswer_DataFieldId_TextValue_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, DataFieldId
										, TextValue		
										, SurveyResponseAnswerId
										, TextValue_Old
												
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
Survey Response Answer DataFieldId TextValue Backfill
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'tpeterson@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'SurveyResponseAnswer DataField TextValue Completed'
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
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue') AND type = (N'U'))						DROP TABLE _surveyResponseAnswer_DataField_TextValue
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_BadDataField') AND type = (N'U'))			DROP TABLE _surveyResponseAnswer_DataField_TextValue_BadDataField
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_TextValue_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Duplicates') AND type = (N'U'))				DROP TABLE _surveyResponseAnswer_DataField_TextValue_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Exist') AND type = (N'U'))					DROP TABLE _surveyResponseAnswer_DataField_TextValue_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Update') AND type = (N'U'))					DROP TABLE _surveyResponseAnswer_DataField_TextValue_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Insert') AND type = (N'U'))					DROP TABLE _surveyResponseAnswer_DataField_TextValue_Insert
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Unidentified') AND type = (N'U'))			DROP TABLE _surveyResponseAnswer_DataField_TextValue_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_Statistics') AND type = (N'U'))				DROP TABLE _surveyResponseAnswer_DataField_TextValue_Statistics
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_TextValue_InsertCompleted') AND type = (N'U'))		DROP TABLE _surveyResponseAnswer_DataField_TextValue_InsertCompleted

	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Action') IS NOT NULL		DROP TABLE ##SurveyResponseAnswerStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results




	PRINT 'Cleanup is complete'



		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
