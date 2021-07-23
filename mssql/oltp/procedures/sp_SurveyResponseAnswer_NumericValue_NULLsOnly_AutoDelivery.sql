SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery
		@deliveryEmail	varchar(100)	= NULL
		, @FileName		varchar(100)	= NULL
		
		, @answer		varchar(10)		= NULL		
		, @throttle		int				= 1

		
AS

/************** Survey Response Answer Modify NumericValue  **************

	Updates NumericValue from a provided file into survey
	response answer.
	
	Executed against OLTP only

	Note: Executing these SP without any parameters will
	print out requirements.
	
	sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery	
		@deliveryEmail	= ''''
		, @FileName		= ''''
	
		
	Tested Successfully with live date 3.4.2013
		
	History
		3.4.2013	Tad Peterson
			-- created
	
		12.23.2014	Tad Peterson
			-- added throttling
	

	
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
	
		PRINT 'Survey Response Answer DataField NumericValue to NULL Update'
		PRINT CHAR(9) + 'Description:  Updates the NumericValue in SurveyResponseAnswer to NULL based on a specified DataFieldId, from a provided file.'
		PRINT CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'File name'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'None'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''		
		PRINT ''

		PRINT CHAR(13) + 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'DataFieldId'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery'
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
, @reply_to			= 'dba@Inmoment.com'
, @subject			= 'Survey Response Answer NumericValue to Nulls Only Update Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseId	DataFieldId
103090587		46627
103090588		15261
103090589		46628




Notes & Comments
-----------------
	
	1. The script only allows for setting a NumericValue to NULL given a dataFieldId
	2. Please be aware of proper file setup (order) to ensure successful processing.
	3. Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	4. File should be in CSV format.
	5. File restictions require the size to be 5 MB or less.  
	6. Row count does not matter as this process is throttled.	
	7. Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery
	@deliveryEmail	= ''your email address here''
	, @FileName		= ''file name here''
		

		
		
-- Example Below --

sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery
	@deliveryEmail	= ''tpeterson@Inmoment.com''
	, @FileName		= ''20121021TruGreenBackfill.csv''
		

		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly
CREATE TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly
		(
			SurveyResponseId			bigint
			, DataFieldId				int	
		)


DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _SurveyResponseAnswer_NumericValue_NULLsOnly   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

--SELECT @FileNameBulkInsertStatement

EXECUTE (@FileNameBulkInsertStatement)


--SELECT TOP 25 *		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly









			
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly	)
			

--SELECT @originalFileSize

DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _SurveyResponseAnswer_NumericValue_NULLsOnly	WHERE SurveyResponseId IS NULL	OR	DataFieldId IS NULL )


--SELECT @nullCount

-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _SurveyResponseAnswer_NumericValue_NULLsOnly
	WHERE
			SurveyResponseId IS NULL
		OR
			DataFieldId IS NULL
			
END			






-- Verifies DataField is legit
DECLARE @notLegitDataField	int
SET		@notLegitDataField	= 
										(
											SELECT
													COUNT(1)
											FROM
													_SurveyResponseAnswer_NumericValue_NULLsOnly	t01
												LEFT JOIN
													DataField										t02
															ON t01.DataFieldId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitDataField

-- Non legit dataField; preserved and deleted
IF @notLegitDataField > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_BadDataField') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_BadDataField
	SELECT
			SurveyResponseId
			, DataFieldId

	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_BadDataField
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly	t01
		LEFT JOIN
			DataField										t02
					ON t01.DataFieldId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM	
			_SurveyResponseAnswer_NumericValue_NULLsOnly	t01
		LEFT JOIN
			DataField										t02
					ON t01.DataFieldId = t02.objectId
	WHERE
			t02.objectId IS NULL		

END




--SELECT @originalFileSize, REPLACE(CONVERT(varchar(20), (CAST(COUNT(1) AS money)), 1), '.00', '')	FROM	_SurveyResponseAnswer_NumericValue_NULLsOnly



DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_SurveyResponseAnswer_NumericValue_NULLsOnly	t01
												LEFT JOIN
													SurveyResponse									t02		WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)


-- Non survey Response Id; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, DataFieldId

	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly	t01
		LEFT JOIN
			SurveyResponse									t02		WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly							t01
		JOIN
			_SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId		t02
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
													
											FROM
													_SurveyResponseAnswer_NumericValue_NULLsOnly	t01

											GROUP BY 
													SurveyResponseId
													, DataFieldId
											HAVING	COUNT(1) > 1
										) AS t101
								)

-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates
	SELECT
			SurveyResponseId
			, DataFieldId
			
	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates		
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly				t01

	GROUP BY 
			SurveyResponseId
			, DataFieldId
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly				t01
		JOIN
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.DataFieldId			= t02.DataFieldId
		
	-- Puts single version back in original file
	INSERT INTO _SurveyResponseAnswer_NumericValue_NULLsOnly ( SurveyResponseId, DataFieldId )
	SELECT
			SurveyResponseId
			, DataFieldId
			
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates			


END


--SELECT * FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates






-- Checks for existing records
DECLARE @surveyResponseDataFieldNumericValueExist	int
SET		@surveyResponseDataFieldNumericValueExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_SurveyResponseAnswer_NumericValue_NULLsOnly		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																					AND
																						t02.NumericValue 		IS NULL
															)


--SELECT @surveyResponseDataFieldNumericValueExist


-- Removes existing records; preserve and removes
IF @surveyResponseDataFieldNumericValueExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Exist') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Exist
	SELECT
			SurveyResponseId
			, DataFieldId
			, t02.NumericValue
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_Exist
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly				t01
		JOIN
			SurveyResponseAnswer										t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
						AND
							t02.NumericValue		IS NULL

	-- Deletes Exist
	DELETE	t01
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly				t01
		JOIN
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Exist			t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t02.NumericValue		IS NULL
					


END



-- Checks for Updating records
DECLARE @surveyResponseDataFieldNumericValueUpdate	int
SET		@surveyResponseDataFieldNumericValueUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_SurveyResponseAnswer_NumericValue_NULLsOnly		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																					AND
																						t02.NumericValue		IS NOT NULL
															)


--SELECT @surveyResponseDataFieldNumericValueUpdate


-- Removes Updating records; preserve and removes
IF @surveyResponseDataFieldNumericValueUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Update') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Update
	SELECT
			SurveyResponseId
			, DataFieldId
			, t02.objectId			AS SurveyResponseAnswerId
			, t02.NumericValue			AS NumericValue_Old
			
	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_Update
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
						AND
							t02.NumericValue		IS NOT NULL

	-- Deletes Update
	DELETE	t01
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly				t01
		JOIN
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Update			t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
					


END




/******************************************  Do not need this insert portion **************************************
-- Checks for Inserting records
DECLARE @surveyResponseDataFieldNumericValueInsert	int
SET		@surveyResponseDataFieldNumericValueInsert	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_SurveyResponseAnswer_NumericValue_NULLsOnly		t01
																	LEFT JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																						
															)


--SELECT @surveyResponseDataFieldNumericValueInsert


-- Removes Inserting records; preserve and removes
IF @surveyResponseDataFieldNumericValueInsert > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Insert') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Insert
	SELECT
			SurveyResponseId
			, DataFieldId
			, t01.NumericValue
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_Insert
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly		t01
		LEFT JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId

	-- Deletes Insert
	DELETE	t01
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly				t01
		JOIN
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Insert			t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.NumericValue		= t02.NumericValue
					


END

******************************************  Do not need above insert portion **************************************/




-- Identifies any remaining rows in original file
DECLARE @surveyResponseDataFieldNumericValueUnidentified		int
SET		@surveyResponseDataFieldNumericValueUnidentified		= ( SELECT COUNT(1)	FROM _SurveyResponseAnswer_NumericValue_NULLsOnly )


IF @surveyResponseDataFieldNumericValueUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Unidentified') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Unidentified
	SELECT
			*
	INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_Unidentified
	FROM
		_SurveyResponseAnswer_NumericValue_NULLsOnly
	
END






IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics
CREATE TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics
	(
		DeliveryEmail										varchar(100)
		, inputFileName										varchar(100)
		, serverName										varchar(25)
		, originalCount										int
		, nullCount											int
		, notLegitDataField									int
		, notLegitSurveyResponseId							int
		, duplicateCheck									int
		, surveyResponseDataFieldNumericValueExist			int
		, surveyResponseDataFieldNumericValueUpdate			int
		, surveyResponseDataFieldNumericValueUnidentified	int
		, throttle											int						
		, processingStart									dateTime
		, processingComplete								dateTime

	)		

INSERT INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitDataField, notLegitSurveyResponseId, duplicateCheck, surveyResponseDataFieldNumericValueExist, surveyResponseDataFieldNumericValueUpdate, surveyResponseDataFieldNumericValueUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitDataField, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseDataFieldNumericValueExist , @surveyResponseDataFieldNumericValueUpdate, @surveyResponseDataFieldNumericValueUnidentified, @throttleCheck




-- Results Print Out
PRINT 'Original CSV Row Count     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   		AS money)), 1), '.00', '')
PRINT 'NULL Values Found          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   				AS money)), 1), '.00', '')
PRINT 'Non Legit DataFields       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitDataField			AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId   AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   			AS money)), 1), '.00', '')
PRINT 'Records Already Exist      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldNumericValueExist   		AS money)), 1), '.00', '')
PRINT 'Records Needing Update     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldNumericValueUpdate   		AS money)), 1), '.00', '')
PRINT 'Records Unidentified       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldNumericValueUnidentified   AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                  :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                          AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery @answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponseAnswer_NumericValue_NULLsOnly_AutoDelivery @answer = ''terminate'''




		
RETURN
END



--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
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

	DECLARE @sraUpdateCheck		int
	SET		@sraUpdateCheck		= ( SELECT surveyResponseDataFieldNumericValueUpdate			FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )

--	DECLARE @sraInsertCheck		int
--	SET		@sraInsertCheck		= ( SELECT surveyResponseDataFieldNumericValueInsert		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )

	
	
	UPDATE _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics
	SET processingStart = GETDATE()

	
	--If statements for Cursors Here
	IF @sraUpdateCheck > 0
	BEGIN

		PRINT 'Updating ' + CAST(@sraUpdateCheck AS varchar) + ' records'


		/********************  SurveyResponseAnswer NumericValue Update  ********************/


		-----Cursor for Survey Response Answer Update

		DECLARE @count bigint, @sraoid bigint

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseAnswerId		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @sraoid

		WHILE @@Fetch_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@sraoid as varchar)+', '+cast('NULL' as varchar)


		----******************* W A R N I N G***************************


		UPDATE SurveyResponseAnswer		WITH (ROWLOCK)
		SET 	NumericValue 	= NULL
		WHERE	objectId 		= @sraoid


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

		SET @count = @count + 1
		FETCH next FROM mycursor INTO @sraoid

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Update	t01		JOIN SurveyResponseAnswer t02	ON t01.surveyResponseAnswerId = t02.objectId AND t01.dataFieldId = t02.DataFieldObjectId AND t02.NumericValue IS NULL )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@sraUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END

/******************************************  Do not need above insert portion **************************************

	IF @sraInsertCheck > 0
	BEGIN
	
		PRINT 'Inserting ' + CAST(@sraInsertCheck AS varchar) + ' records'
	
		/********************  SurveyResponseAnswer DataField NumericValue Insert  ********************/

		-----Cursor for SRA Insert

		DECLARE @countV2 bigint, @SurveyResponseIdV2 bigint, @DataFieldIdV2 bigint, @NumericValueV2 float, @newSequence bigint

		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, DataFieldId, NumericValue FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Insert

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @DataFieldIdV2, @NumericValueV2

		WHILE @@Fetch_Status = 0
		BEGIN

		SET @newSequence =	( SELECT max(sequence) + 1	FROM surveyResponseAnswer WHERE surveyResponseObjectId = @SurveyResponseIdV2 )
			  
		PRINT cast(@countV2 as varchar)+', '+cast(@SurveyResponseIdV2 as varchar)+', '+cast(@DataFieldIdV2 as varchar)+', '+cast(@NumericValueV2 as varchar)+', '+cast(@newSequence as varchar)


		----******************* W A R N I N G***************************


		----INSERT INTO surveyResponseAnswer (surveyResponseObjectId, DataFieldObjectId, NumericValue, sequence)
		----SELECT @SurveyResponseIdV2, @DataFieldIdV2, @NumericValueV2, @newSequence


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

		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @DataFieldIdV2, @NumericValueV2

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
		
		
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted') AND type = (N'U'))    DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted
		SELECT
				SurveyResponseId
				, DataFieldId
				, t01.NumericValue
				, t02.objectId			AS SurveyResponseAnswerId
		INTO _SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted
		FROM 
				_SurveyResponseAnswer_NumericValue_NULLsOnly_Insert				t01		
			JOIN 
				SurveyResponseAnswer											t02	WITH (NOLOCK)
						ON 
							t01.surveyResponseId	= t02.SurveyResponseObjectId 
						AND 
							t01.dataFieldId			= t02.DataFieldObjectId 
						AND 
							t01.NumericValue		= t02.NumericValue 
		
		
		-- Deletes Successful Inserts
		DELETE FROM t01
		FROM
				_SurveyResponseAnswer_NumericValue_NULLsOnly_Insert					t01
			JOIN
				_SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted		t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.DataFieldId			= t02.DataFieldId
							AND
								t01.NumericValue		= t02.NumericValue
		
		
		
		DECLARE @successfulInsert		int
		SET		@successfulInsert		= ( SELECT COUNT(1)		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted )
		
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@sraInsertCheck AS varchar) + ' Successful: ' + CAST(@successfulInsert as varchar)
		PRINT ''
		PRINT ''
		
		
	
	END

	
	
	
******************************************  Do not need above insert portion **************************************/
	
	
	

	UPDATE _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics
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
IF @sraUpdateCheck > 0 			-- OR @sraInsertCheck > 0 
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
		, @surveyResponseDataFieldNumericValueExistV2				int
		, @surveyResponseDataFieldNumericValueUpdateV2				int
		, @surveyResponseDataFieldNumericValueUnidentifiedV2		int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @serverNameV2											= ( SELECT serverName												FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @notLegitDataFieldV2 									= ( SELECT notLegitDataField										FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @notLegitSurveyResponseIdV2								= ( SELECT notLegitSurveyResponseId									FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @duplicateCheckV2										= ( SELECT duplicateCheck											FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @surveyResponseDataFieldNumericValueExistV2				= ( SELECT surveyResponseDataFieldNumericValueExist					FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @surveyResponseDataFieldNumericValueUpdateV2				= ( SELECT surveyResponseDataFieldNumericValueUpdate			FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @surveyResponseDataFieldNumericValueUnidentifiedV2			= ( SELECT surveyResponseDataFieldNumericValueUnidentified		FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )


/********  No Inserts on this  ********

IF @sraInsertCheck > 0
BEGIN
	SET @surveyResponseDataFieldNumericValueInsertFailedV2			= ( SELECT COUNT(1)											FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Insert )
END

***************************************/



SET @ProcessingStartV2			= ( SELECT ProcessingStart				FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
SET @ProcessingCompleteV2		= ( SELECT ProcessingComplete			FROM _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics )
		
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
		, SurveyResponseAnswerId			bigInt
		, NumericValue_Old					float
	)

/********  No Inserts on this  ********

IF @surveyResponseDataFieldNumericValueInsertFailedV2 > 0
BEGIN	
	INSERT INTO ##SurveyResponseAnswerStatus_Action	( Action, SurveyResponseId, DataFieldId )
	SELECT 	'Insert Failed'
			, SurveyResponseId
			, DataFieldId
			
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Insert

END

***************************************/


IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId )
	SELECT 	'NonLegit SurveyResponseId'
			, SurveyResponseId
			, DataFieldId
			
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId
END


IF @notLegitDataFieldV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId )
	SELECT 	'NonLegit DataField'
			, SurveyResponseId
			, DataFieldId
				
			
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_BadDataField
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, DataFieldId
				
			
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates

END
		



IF @surveyResponseDataFieldNumericValueExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, SurveyResponseAnswerId )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, DataFieldId
				
		, SurveyResponseAnswerId
			
	FROM
		_SurveyResponseAnswer_NumericValue_NULLsOnly_Exist

END




IF @surveyResponseDataFieldNumericValueUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, DataFieldId
				
			
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Unidentified

END



IF @surveyResponseDataFieldNumericValueUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, SurveyResponseAnswerId, NumericValue_Old )
	SELECT 	'Updated'
			, SurveyResponseId
			, DataFieldId
					
			, SurveyResponseAnswerId
			, NumericValue_Old
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_Update

END


/********  No Inserts on this  ********

IF @surveyResponseDataFieldNumericValueInsertV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, SurveyResponseAnswerId )
	SELECT 	'Inserted'
			, SurveyResponseId
			, DataFieldId
					
			, SurveyResponseAnswerId
	FROM
			_SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted

END
		
***************************************/



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
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldNumericValueExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldNumericValueUnidentifiedV2 , 0)    	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldNumericValueUpdateV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   									AS money)), 1), '.00', '')	
--UNION ALL
--SELECT 'Needing Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldNumericValueInsertV2 , 0)   			AS money)), 1), '.00', '')	
--UNION ALL
--SELECT 'Successful Insert'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulInsert , 0)   										AS money)), 1), '.00', '')	
--UNION ALL
--SELECT 'Failed Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldNumericValueInsertFailedV2 , 0)   	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponseAnswer_DataFieldId_NumericValue_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, DataFieldId												
										, SurveyResponseAnswerId
										, NumericValue_Old
												
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
Survey Response Answer NumericValue to NULL Backfill
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'tpeterson@Inmoment.com'
, @reply_to						= 'dba@Inmoment.com'
, @subject						= 'Survey Response Answer DataField NumericValue to NULL Completed'
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
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly') AND type = (N'U'))							DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_BadDataField') AND type = (N'U'))			DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_BadDataField
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId') AND type = (N'U'))    	DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates') AND type = (N'U'))				DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Exist') AND type = (N'U'))					DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Update') AND type = (N'U'))					DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Update
--	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Insert') AND type = (N'U'))					DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Insert
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Unidentified') AND type = (N'U'))			DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics') AND type = (N'U'))				DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_Statistics
--	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted') AND type = (N'U'))			DROP TABLE _SurveyResponseAnswer_NumericValue_NULLsOnly_InsertCompleted

	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Action') IS NOT NULL		DROP TABLE ##SurveyResponseAnswerStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results




	PRINT 'Cleanup is complete'



		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
