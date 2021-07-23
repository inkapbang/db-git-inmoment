SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @Answer				varchar(10)		= NULL		
		, @Throttle				int				= 1

AS
	
/****************  BackFill Options Auto Deliver  ****************


	History
		01.23.2013	Tad Peterson
			-- Tested With live data; successful.
	
		09.03.2014	Tad Peterson
			-- Added throttling support
	

	Execute on OLTP.
	
	sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery		
		@DeliveryEmail			= 'bluther@InMoment.com'
		, @FileName				= NULL

		, @Answer				= NULL		
		, @Throttle			= 1

		
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




										
--SELECT 	@deliveryEmailCheck, @FileNameCheck, @dataFieldObjectId01Check, @dataFieldObjectId02Check, @dataFieldObjectId03Check, @dataFieldObjectId04Check, @dataFieldObjectId05Check, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'SurveyResponseAnswer Insert & Update NULLs Only'
		PRINT CHAR(9) + 'Description:  Inserts or Updates dataFieldOptionObjectId based on a dataFieldObjectId derived from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query only provides support for modifying a dataFieldOptionObjectId to NULL given a dataFieldObjectId.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                                 -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address & File name                    -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'DataFieldObjectId'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a spreadsheet with answers for them to create the file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail = ''Their Email Here'''
		PRINT '' 
		
	RETURN
	END		


---- Catch, if email is the only thing listed
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
	AND
		@answerCheck 			= 0

BEGIN
	PRINT 'Emailed form to ' + @deliveryEmail
	

DECLARE @DataFieldOptionFileName	nvarchar(100)
SET		@DataFieldOptionFileName	= CAST(REPLACE(CONVERT(varchar(10),GETDATE(),120),'-','') as varchar) + 'dataFieldOptionIds_Answers.csv'


	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Data Field Option Set To NULL Form'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.




File Setup & Contents Example
------------------------------

SurveyResponseId	DataFieldId
103090587		57733
103090588		57733





Notes & Comments
-----------------
	The script only allows for setting a dataFieldOptionId to NULL given a dataFieldId
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		

		
-- Example Below --

sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery
	@DeliveryEmail	= ''tpeterson@InMoment.com''
	, @FileName		= ''Cracker Barrel #01.csv''
		



		
'		
;
	IF OBJECT_ID('tempdb..##dataFieldOptionTemp') IS NOT NULL			DROP TABLE ##dataFieldOptionTemp

	
RETURN	
END		


/*******************************************************************  Upload & Processing Portion  *******************************************************************/

-- Upload and Process Statistics
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 1	

BEGIN

SET NOCOUNT ON 

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
CREATE TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
		(
			SurveyResponseId			bigint
			, DataFieldId				int	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)






--These next TWO steps are specific to this AutoDelivery process
ALTER TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
ADD DataFieldOptionId	varchar(4)


UPDATE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
SET DataFieldOptionId = 'NULL'







DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only	WHERE SurveyResponseId IS NULL	OR	DataFieldId IS NULL	OR  DataFieldOptionId IS NULL )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
	WHERE
			SurveyResponseId	IS NULL
		OR
			DataFieldId			IS NULL
			
END			




-- Verifies DataFieldOption is legit
DECLARE @notLegitDataField		int
SET		@notLegitDataField		= 
														(
															SELECT
																	COUNT(1)
															FROM
																	_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
																LEFT JOIN
																	DataField														t02
																			ON t01.DataFieldId = t02.ObjectId 
															WHERE
																	t02.objectId IS NULL		
														)

--SELECT @notLegitDataField



-- Non legit dataFieldId; preserved and deleted
IF @notLegitDataField > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Bad') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Bad
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Bad
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
		LEFT JOIN
			DataField														t02
					ON t01.DataFieldId = t02.ObjectId 
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
		LEFT JOIN
			DataField														t02
					ON t01.DataFieldId = t02.ObjectId 
	WHERE
			t02.objectId IS NULL		

END




DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
												LEFT JOIN
													SurveyResponse													t02	WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitSurveyResponseId


-- Non legit SurveyResponseIds; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_BadSurveyResponseId
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_BadSurveyResponseId
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
		LEFT JOIN
			SurveyResponse										t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
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
													, DataFieldId
													, DataFieldOptionId
											FROM
													_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
											GROUP BY 
													SurveyResponseId
													, DataFieldId
													, DataFieldOptionId
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates		
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only				t01

	GROUP BY 
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only				t01
		JOIN
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates	t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.DataFieldId			= t02.DataFieldId
							AND
								t01.DataFieldOptionId	= t02.DataFieldOptionId			--This should be correct as it compares 'NULL' text to 'NULL' text

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only ( SurveyResponseId, DataFieldId, DataFieldOptionId )
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates			


END



-- Checks for existing records
DECLARE @surveyResponseDataFieldDataFieldOptionExist	int
SET		@surveyResponseDataFieldDataFieldOptionExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																					AND
																						t02.DataFieldOptionObjectId	IS NULL
															)


--SELECT @surveyResponseDataFieldDataFieldOptionExist


-- Removes existing records; preserve and removes
IF @surveyResponseDataFieldDataFieldOptionExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
						AND
							t02.DataFieldOptionObjectId	IS NULL

	-- Deletes Exist
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only				t01
		JOIN
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.DataFieldOptionId	= t02.DataFieldOptionId				--This should be correct as it compares 'NULL' text to 'NULL' text
					


END




DECLARE @surveyResponseDataFieldDataFieldOptionUpdate	int
SET		@surveyResponseDataFieldDataFieldOptionUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
																	JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																					AND
																						t02.DataFieldOptionObjectId	IS NOT NULL
															)


-- Seperates updating records; preserve and removes
IF @surveyResponseDataFieldDataFieldOptionUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
			, t02.objectId					AS SurveyResponseAnswerId
			, t02.dataFieldOptionObjectId	AS DataFieldOptionId_Old
			
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
		JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
						AND
							t02.DataFieldOptionObjectId	IS NOT NULL

	-- Deletes Updates
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only				t01
		JOIN
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.DataFieldOptionId	= t02.DataFieldOptionId				--This should be correct as it compares 'NULL' text to 'NULL' text
					


END




DECLARE @surveyResponseDataFieldDataFieldOptionInsert	int
SET		@surveyResponseDataFieldDataFieldOptionInsert	= 
															(
																SELECT
																		COUNT(1)			
																FROM
																		_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
																	LEFT JOIN
																		SurveyResponseAnswer								t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.SurveyResponseObjectId
																					AND
																						t01.DataFieldId			= t02.DataFieldObjectId
																WHERE
																		t02.objectId IS NULL

															)

IF @surveyResponseDataFieldDataFieldOptionInsert > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert
	SELECT
			SurveyResponseId
			, DataFieldId
			, DataFieldOptionId
			, t02.objectId			AS SurveyResponseAnswerId
			
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only		t01
		LEFT JOIN
			SurveyResponseAnswer								t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseObjectId
						AND
							t01.DataFieldId			= t02.DataFieldObjectId
	WHERE
			t02.objectId IS NULL
									

	-- Deletes Inserts
	DELETE	t01
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only				t01
		JOIN
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert		t02
					ON	
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.DataFieldId			= t02.DataFieldId
						AND
							t01.DataFieldOptionId	= t02.DataFieldOptionId				--This should be correct as it compares 'NULL' text to 'NULL' text
					


END



-- Identifies any remaining rows in original file
DECLARE @surveyResponseDataFieldDataFieldOptionUnidentified		int
SET		@surveyResponseDataFieldDataFieldOptionUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only )


IF @surveyResponseDataFieldDataFieldOptionUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Unidentified
	SELECT
			*
	INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Unidentified
	FROM
		_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics
CREATE TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, surverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitDataField										varchar(4)
		, notLegitSurveyResponseId								int
		, duplicateCheck										int
		, surveyResponseDataFieldDataFieldOptionExist			int
		, surveyResponseDataFieldDataFieldOptionUpdate			int
		, surveyResponseDataFieldDataFieldOptionInsert			int
		, surveyResponseDataFieldDataFieldOptionUnidentified	int
		, throttle												int						
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics ( DeliveryEmail, inputFileName, surverName, originalCount, nullCount, notLegitDataField, notLegitSurveyResponseId, duplicateCheck, surveyResponseDataFieldDataFieldOptionExist, surveyResponseDataFieldDataFieldOptionUpdate, surveyResponseDataFieldDataFieldOptionInsert, surveyResponseDataFieldDataFieldOptionUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitDataField, @notLegitSurveyResponseId, @duplicateCheck, @surveyResponseDataFieldDataFieldOptionExist , @surveyResponseDataFieldDataFieldOptionUpdate, @surveyResponseDataFieldDataFieldOptionInsert, @surveyResponseDataFieldDataFieldOptionUnidentified, @throttleCheck




-- Results Print Out
PRINT 'SurveyResponseAnswer DataField & Options NULLs Only Statistics'
PRINT ''
PRINT 'Original CSV Row Count                            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   									AS money)), 1), '.00', '')
PRINT 'NULL Values Found In Response or DataField        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   											AS money)), 1), '.00', '')
PRINT 'Non Legit DataFields                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitDataField					AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                             :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId								AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   										AS money)), 1), '.00', '')
PRINT 'Records Already Exist                             :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldDataFieldOptionExist   			AS money)), 1), '.00', '')
PRINT 'Records Needing Update                            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldDataFieldOptionUpdate   		AS money)), 1), '.00', '')
PRINT 'Records Needing Insert                            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldDataFieldOptionInsert   		AS money)), 1), '.00', '')
PRINT 'Records Unidentified                              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@surveyResponseDataFieldDataFieldOptionUnidentified   	AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                  		AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '----->   Generally, There should be no inserts for this type of request   <-----'
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_AutoDelivery	@answer = ''terminate'''

RETURN

END







/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
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
	
	DECLARE @sraUpdateCheck		int
	SET		@sraUpdateCheck		= ( SELECT surveyResponseDataFieldDataFieldOptionUpdate		FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
	
	DECLARE @sraInsertCheck		int
	SET		@sraInsertCheck		= ( SELECT surveyResponseDataFieldDataFieldOptionInsert		FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )


	UPDATE	_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @sraUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@sraUpdateCheck AS varchar) + ' records'
	
		/********************  SurveyResponseAnswer DataField DataFieldOption Update  ********************/

		-----Cursor for SRA Update

		DECLARE @count bigint, @SurveyResponseAnswerId bigint, @DataFieldOptionId varchar(4)

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseAnswerId, DataFieldOptionId FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseAnswerId, @DataFieldOptionId

		WHILE @@Fetch_Status = 0
		BEGIN


			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseAnswerId as varchar)+', '+cast(@DataFieldOptionId as varchar)


		----******************* W A R N I N G***************************


		UPDATE SurveyResponseAnswer	WITH (ROWLOCK)
		SET dataFieldOptionObjectId = NULL			--This is a true NULL value
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
											CurrentAsOf IS NOT NULL
								)	

			-- 2.5 min behind
			
			-- Need to put back
			--WHILE @check >= 180
			
			
			-- temporary 
			WHILE @check >= 10800
			
			--
			
			
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
		
		
		
		
		
		
		
		
		
		
		SET @count = @count + 1
		FETCH next FROM mycursor INTO @SurveyResponseAnswerId, @DataFieldOptionId

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update	t01		JOIN SurveyResponseAnswer t02	ON t01.surveyResponseAnswerId = t02.objectId AND t01.dataFieldId = t02.dataFieldObjectId AND t02.dataFieldOptionObjectId IS NULL )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@sraUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END
	
	
	
	
	IF @sraInsertCheck > 0
	BEGIN
	
		PRINT 'Inserting ' + CAST(@sraInsertCheck AS varchar) + ' records'



		/********************  SurveyResponseAnswer DataField DataFieldOption Insert  ********************/

		-----Cursor for SRA Insert

		DECLARE @countV2 bigint, @SurveyResponseIdV2 bigint, @DataFieldIdV2 bigint, @DataFieldOptionIdV2 varchar(4), @newSequence bigint

		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, DataFieldId, DataFieldOptionId FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @DataFieldIdV2, @DataFieldOptionIdV2

		WHILE @@Fetch_Status = 0
		BEGIN

		SET @newSequence =	( SELECT max(sequence) + 1	FROM surveyResponseAnswer WHERE surveyResponseObjectId = @SurveyResponseIdV2 )
			  
		PRINT cast(@countV2 as varchar)+', '+cast(@SurveyResponseIdV2 as varchar)+', '+cast(@DataFieldIdV2 as varchar)+', '+cast(@DataFieldOptionIdV2 as varchar)+', '+cast(@newSequence as varchar)


		----******************* W A R N I N G***************************


		INSERT INTO surveyResponseAnswer (surveyResponseObjectId, dataFieldObjectId, sequence)		--Note there is not a dataFieldOption inserted;  
		SELECT @SurveyResponseIdV2, @DataFieldIdV2, @newSequence									--this is the only way to get a true NULL value


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
											CurrentAsOf IS NOT NULL
								)	

			-- 2.5 min behind
			
			-- Need to put back
			--WHILE @check >= 180
			
			
			-- temporary 
			WHILE @check >= 10800
			
			--
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
		
		
		
		
		
		
		
		
		
		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @DataFieldIdV2, @DataFieldOptionIdV2

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
		
		
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted
		SELECT
				SurveyResponseId
				, DataFieldId
				, DataFieldOptionId
				, t02.objectId			AS SurveyResponseAnswerId
		INTO _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted
		FROM 
				_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert				t01		
			JOIN 
				SurveyResponseAnswer															t02	WITH (NOLOCK)
						ON 
							t01.surveyResponseId	= t02.SurveyResponseObjectId 
						AND 
							t01.dataFieldId			= t02.dataFieldObjectId 
						AND 
							t02.dataFieldOptionObjectId IS NULL 
		
		
		-- Deletes Successful Inserts
		DELETE FROM t01
		FROM
				_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert				t01
			JOIN
				_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted		t02
						ON	
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.DataFieldId			= t02.DataFieldId
							AND
								t01.DataFieldOptionId	= t02.DataFieldOptionId			--This should be correct as it compares 'NULL' text to 'NULL' text
		
		
		
		DECLARE @successfulInsert		int
		SET		@successfulInsert		= ( SELECT COUNT(1)		FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted )
		
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@sraInsertCheck AS varchar) + ' Successful: ' + CAST(@successfulInsert as varchar)
		PRINT ''
		PRINT ''
		
		
	
	END


	UPDATE	_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics
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
IF @sraUpdateCheck > 0 OR @sraInsertCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitDataFieldV2					int
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @surveyResponseDataFieldDataFieldOptionExistV2			int
		, @surveyResponseDataFieldDataFieldOptionUpdateV2			int
		, @surveyResponseDataFieldDataFieldOptionInsertV2			int
		, @surveyResponseDataFieldDataFieldOptionUnidentifiedV2		int
		, @surveyResponseDataFieldDataFieldOptionInsertFailedV2		int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @serverNameV2											= ( SELECT surverName												FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @notLegitDataFieldV2 									= ( SELECT notLegitDataField										FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @notLegitSurveyResponseIdV2								= ( SELECT notLegitSurveyResponseId									FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @duplicateCheckV2										= ( SELECT duplicateCheck											FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @surveyResponseDataFieldDataFieldOptionExistV2			= ( SELECT surveyResponseDataFieldDataFieldOptionExist				FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @surveyResponseDataFieldDataFieldOptionUpdateV2			= ( SELECT surveyResponseDataFieldDataFieldOptionUpdate				FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @surveyResponseDataFieldDataFieldOptionInsertV2			= ( SELECT surveyResponseDataFieldDataFieldOptionInsert				FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @surveyResponseDataFieldDataFieldOptionUnidentifiedV2	= ( SELECT surveyResponseDataFieldDataFieldOptionUnidentified		FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )

IF @sraInsertCheck > 0
BEGIN
SET @surveyResponseDataFieldDataFieldOptionInsertFailedV2	= ( SELECT COUNT(1)													FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert )
END

SET @ProcessingStartV2			= ( SELECT ProcessingStart				FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
SET @ProcessingCompleteV2		= ( SELECT ProcessingComplete			FROM _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics )
		
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
		, DataFieldOptionId					nvarchar(2000)
		, SurveyResponseAnswerId			bigInt
		, DataFieldOptionId_Old				nvarchar(2000)
	)


IF @surveyResponseDataFieldDataFieldOptionInsertFailedV2 > 0
BEGIN	
	INSERT INTO ##SurveyResponseAnswerStatus_Action	( Action, SurveyResponseAnswerId, DataFieldId, DataFieldOptionId )
	SELECT 	'Insert Failed'
			, SurveyResponseId
			, DataFieldId
			, DataFieldOptionId		
			
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert

END


IF @notLegitSurveyResponseIdV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseAnswerId, DataFieldId, DataFieldOptionId )
	SELECT 	'NonLegit SurveyResponseId'
		, SurveyResponseId
		, DataFieldId
		, DataFieldOptionId		
			
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_BadSurveyResponseId
END


IF @notLegitDataFieldV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, DataFieldOptionId )
	SELECT 	'NonLegit DataField & Option Pair'
			, SurveyResponseId
			, DataFieldId
			, DataFieldOptionId	
			
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Bad
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, DataFieldOptionId )
	SELECT 	'Duplicate'
			, SurveyResponseId
			, DataFieldId
			, DataFieldOptionId	
			
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates

END
		



IF @surveyResponseDataFieldDataFieldOptionExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, DataFieldOptionId, SurveyResponseAnswerId )
	SELECT 	'Record Exist'
		, SurveyResponseId
		, DataFieldId
		, DataFieldOptionId		
		, SurveyResponseAnswerId
			
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist

END




IF @surveyResponseDataFieldDataFieldOptionUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, DataFieldOptionId )
	SELECT 	'Unidentified'
			, SurveyResponseId
			, DataFieldId
			, DataFieldOptionId	
			
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Unidentified

END



IF @surveyResponseDataFieldDataFieldOptionUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, DataFieldOptionId, SurveyResponseAnswerId, DataFieldOptionId_Old )
	SELECT 	'Updated'
			, SurveyResponseId
			, DataFieldId
			, DataFieldOptionId		
			, SurveyResponseAnswerId
			, DataFieldOptionId_Old
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update

END




IF @surveyResponseDataFieldDataFieldOptionInsertV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseAnswerStatus_Action ( Action, SurveyResponseId, DataFieldId, DataFieldOptionId, SurveyResponseAnswerId )
	SELECT 	'Inserted'
			, SurveyResponseId
			, DataFieldId
			, DataFieldOptionId		
			, SurveyResponseAnswerId
	FROM
			_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted

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
SELECT 'NonLegit DataField'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitDataFieldV2 , 0)						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit SurveyResponseIds'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitSurveyResponseIdV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldDataFieldOptionExistV2 , 0)					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldDataFieldOptionUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldDataFieldOptionUpdateV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldDataFieldOptionInsertV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Insert'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulInsert , 0)   												AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Failed Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @surveyResponseDataFieldDataFieldOptionInsertFailedV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponseAnswer_DataFieldId_DataFieldOptionId_NULLs_Only_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseId
										, DataFieldId
										, DataFieldOptionId		
										, SurveyResponseAnswerId
										, DataFieldOptionId_Old
												
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
SurveyResponseAnswer DataFieldId DataFieldOption NULLs Only Backfill
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
, @copy_recipients 				= 'tpeterson@InMoment.com; dperkins@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'SurveyResponseAnswer DataField DataFieldOption NULLs Only Completed'
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
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only') AND type = (N'U'))						DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Bad') AND type = (N'U'))				DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Bad
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates') AND type = (N'U'))				DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist') AND type = (N'U'))					DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update') AND type = (N'U'))					DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert') AND type = (N'U'))					DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Insert
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Unidentified') AND type = (N'U'))			DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics') AND type = (N'U'))				DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_Statistics
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted') AND type = (N'U'))		DROP TABLE _surveyResponseAnswer_DataField_DataFieldOption_NULLs_Only_InsertCompleted

	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Action') IS NOT NULL		DROP TABLE ##SurveyResponseAnswerStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseAnswerStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseAnswerStatus_Results




	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
