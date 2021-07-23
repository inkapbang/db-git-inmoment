SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- CREATE Procedure sp_CampaignUnsubscribe_AutoDelivery
CREATE Procedure [dbo].[sp_CampaignUnsubscribe_AutoDelivery]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		

AS
	
/****************  Campaign Unsubscribe Auto Deliver  ***************

	Tested With live data 11/08/2013; successful.

	Execute on OLTP.
	
	sp_CampaignUnsubscribe_AutoDelivery		
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
										
										


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @exclusionReasonCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Campaign Unsubscribe Update'
		PRINT CHAR(9) + 'Description:  Updates Campaign Unsubscribe based on a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides a file format to the requestor.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor file format for prep. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the file setup description for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_CampaignUnsubscribe_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		
	RETURN
	END		






-- Sends File setup
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Campaign Unsubscribe File Setup'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



UnsubscribeType Possible Options = 1 or 2



File Setup & Contents Example
------------------------------

CampaignObjectId     ContactInfo     UnsubscribeType
81                   2012476054      1
81                   2013031792      1
81                   2016382695      1
81                   2016500588      1





Notes & Comments
-----------------
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_CampaignUnsubscribe_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_CampaignUnsubscribe_AutoDelivery
	@DeliveryEmail	= ''tpeterson@mshare.net''
	, @FileName		= ''CampaignUnsubscribe_JiB.csv''
		



		
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

IF OBJECT_ID('tempdb..##campaignUnsubscribe_Upload') IS NOT NULL			DROP TABLE ##campaignUnsubscribe_Upload		
CREATE TABLE ##campaignUnsubscribe_Upload
(
	CampaignObjectId		int
	, ContactInfo			varchar(255)
	, UnsubscribeType		int
)


DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##campaignUnsubscribe_Upload   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)


ALTER TABLE ##campaignUnsubscribe_Upload
ADD DateAdded 	dateTime;



DECLARE @NewGetDate  		dateTime
SET		@NewGetDate			= ( SELECT GETDATE() )



UPDATE ##campaignUnsubscribe_Upload
SET DateAdded = @NewGetDate



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM ##campaignUnsubscribe_Upload	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM ##campaignUnsubscribe_Upload	WHERE CampaignObjectId IS NULL	OR	ContactInfo IS NULL  OR  UnsubscribeType IS NULL )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM ##campaignUnsubscribe_Upload
	WHERE
			CampaignObjectId 	IS NULL
		OR
			ContactInfo 		IS NULL
		OR
			UnsubscribeType 	IS NULL
			
END			

	
	
	
	
-- Verifies UnsubscribeType is legit
DECLARE @notLegitUnsubscribeType		int
SET		@notLegitUnsubscribeType		= 
											(
												SELECT
														COUNT(1)
												FROM
														##campaignUnsubscribe_Upload		t01
														
												WHERE
														t01.UnsubscribeType NOT IN ( 1, 2 )
											)

--SELECT @notLegitUnsubscribeType
	

	
-- Non legit UnsubscribeType; preserved and deleted
IF @notLegitUnsubscribeType > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_UnsubscribeType') AND type = (N'U'))    DROP TABLE _campaignUnsubscribe_UnsubscribeType
	SELECT
			t01.CampaignObjectId
			, t01.ContactInfo
			, t01.UnsubscribeType
			, t01.DateAdded
			
	INTO _campaignUnsubscribe_UnsubscribeType
	FROM
			##campaignUnsubscribe_Upload			t01
	WHERE
			t01.UnsubscribeType NOT IN ( 1, 2 )

	-- Delete Step
	DELETE	t01
	FROM
			##campaignUnsubscribe_Upload			t01
	WHERE
			t01.UnsubscribeType NOT IN ( 1, 2 )

END




DECLARE @notLegitContactInfo	int
SET		@notLegitContactInfo	= 0
/*****  Not Used as there are no constraints on this field
SET		@notLegitContactInfo	=

										(
											SELECT
													COUNT(1)
											FROM
													##campaignUnsubscribe_Upload		t01
												LEFT JOIN
													SurveyResponse						t02	WITH (NOLOCK)
															ON t01.ContactInfo = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitContactInfo


-- Non legit ContactInfo; preserved and deleted
IF @notLegitContactInfo > 0
BEGIN
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_ContactInfo') AND type = (N'U'))   				DROP TABLE _campaignUnsubscribe_ContactInfo
	SELECT
			ContactInfo
			, t01.ExclusionReason
	INTO _surveyResponse_ExclusionReason_BadContactInfo
	FROM
			_surveyResponse_ExclusionReason							t01
		LEFT JOIN
			SurveyResponse											t02	WITH (NOLOCK)
					ON t01.ContactInfo = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			_surveyResponse_ExclusionReason							t01
		JOIN
			_surveyResponse_ExclusionReason_BadContactInfo			t02
					ON t01.ContactInfo = t02.ContactInfo

END
*****/





DECLARE @notLegitCampaignObjectId	int
SET		@notLegitCampaignObjectId	=

										(
											SELECT
													COUNT(1)
											FROM
													##campaignUnsubscribe_Upload		t01
												LEFT JOIN
													campaign							t02	WITH (NOLOCK)
															ON t01.CampaignObjectId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)

--SELECT @notLegitCampaignObjectId


-- Non legit CampaignObjectId; preserved and deleted
IF @notLegitCampaignObjectId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_CampaignObjectId') AND type = (N'U'))    DROP TABLE _campaignUnsubscribe_CampaignObjectId
	SELECT
			t01.CampaignObjectId
			, t01.ContactInfo
			, t01.UnsubscribeType
			, t01.DateAdded
			
	INTO _campaignUnsubscribe_CampaignObjectId
	FROM
			##campaignUnsubscribe_Upload		t01
		LEFT JOIN
			campaign							t02	WITH (NOLOCK)
					ON t01.CampaignObjectId = t02.objectId
	WHERE
			t02.objectId IS NULL		

	-- Delete Step
	DELETE	t01
	FROM
			##campaignUnsubscribe_Upload							t01
		JOIN
			_campaignUnsubscribe_CampaignObjectId					t02
					ON t01.CampaignObjectId = t02.CampaignObjectId

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
													CampaignObjectId
													, ContactInfo
													, UnsubscribeType
											FROM
													##campaignUnsubscribe_Upload		t01
											GROUP BY 
													CampaignObjectId
													, ContactInfo
													, UnsubscribeType
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Duplicates') AND type = (N'U'))    DROP TABLE _campaignUnsubscribe_Duplicates
	SELECT
			t01.CampaignObjectId
			, t01.ContactInfo
			, t01.UnsubscribeType
			, t01.DateAdded
			
	INTO _campaignUnsubscribe_Duplicates		
	FROM
			##campaignUnsubscribe_Upload		t01

	GROUP BY 
			CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t01
	FROM
			##campaignUnsubscribe_Upload		t01
		JOIN
			_campaignUnsubscribe_Duplicates		t02
						ON	
								t01.CampaignObjectId	= t02.CampaignObjectId
							AND
								t01.ContactInfo			= t02.ContactInfo
							AND
								t01.UnsubscribeType		= t02.UnsubscribeType
							

		
	-- Puts single version back in original file
	INSERT INTO ##campaignUnsubscribe_Upload ( CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT
			CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
	FROM
			_campaignUnsubscribe_Duplicates			


END






-- Checks for existing records
DECLARE @campaignUnsubscribeExist		int
SET		@campaignUnsubscribeExist		= 
															(
																SELECT
																		COUNT(1)
																FROM
																		##campaignUnsubscribe_Upload		t01
																	JOIN
																		CampaignUnsubscribe					t02 WITH (NOLOCK)
																				ON	
																						t01.CampaignObjectId	= t02.CampaignObjectId
																					AND
																						t01.ContactInfo			= t02.ContactInfo
																					AND
																						t01.UnsubscribeType		= t02.UnsubscribeType
																						
															)


--SELECT @campaignUnsubscribeExist


-- Removes existing records; preserve and removes
IF @campaignUnsubscribeExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Exist') AND type = (N'U'))    DROP TABLE _campaignUnsubscribe_ExclusionReason_Exist
	SELECT
			t01.CampaignObjectId
			, t01.ContactInfo
			, t01.UnsubscribeType
			, t01.DateAdded
			
	INTO _campaignUnsubscribe_Exist
	FROM
			##campaignUnsubscribe_Upload		t01
		JOIN
			CampaignUnsubscribe					t02 WITH (NOLOCK)
					ON	
							t01.CampaignObjectId	= t02.CampaignObjectId
						AND
							t01.ContactInfo			= t02.ContactInfo
						AND
							t01.UnsubscribeType		= t02.UnsubscribeType

							
	-- Deletes Exist
	DELETE	t01
	FROM
			##campaignUnsubscribe_Upload		t01
		JOIN
			CampaignUnsubscribe					t02 WITH (NOLOCK)
					ON	
							t01.CampaignObjectId	= t02.CampaignObjectId
						AND
							t01.ContactInfo			= t02.ContactInfo
						AND
							t01.UnsubscribeType		= t02.UnsubscribeType
					


END






-- Remaining rows in original file after data cleanings
DECLARE @campaignUnsubscribeInsert		int
SET		@campaignUnsubscribeInsert		= ( SELECT COUNT(1)	FROM ##campaignUnsubscribe_Upload )



IF @campaignUnsubscribeInsert > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Insert') AND type = (N'U'))    DROP TABLE _campaignUnsubscribe_Insert
	SELECT
			t01.CampaignObjectId
			, t01.ContactInfo
			, t01.UnsubscribeType
			, t01.DateAdded
			
	INTO _campaignUnsubscribe_Insert
	FROM
			##campaignUnsubscribe_Upload		t01
END	



-- Removes original table so no accidental things happen
IF OBJECT_ID('tempdb..##campaignUnsubscribe_Upload') IS NOT NULL			DROP TABLE ##campaignUnsubscribe_Upload		






IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Statistics') AND type = (N'U'))    DROP TABLE _campaignUnsubscribe_Statistics
CREATE TABLE _campaignUnsubscribe_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitUnsubscribeType								int
		, notLegitContactInfo									varchar(255)
		, notLegitCampaignObjectId								int
		, duplicateCheck										int
		, campaignUnsubscribeExist								int
		, campaignUnsubscribeInsert								int
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _campaignUnsubscribe_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitUnsubscribeType, notLegitContactInfo, notLegitCampaignObjectId, duplicateCheck, campaignUnsubscribeExist, campaignUnsubscribeInsert )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitUnsubscribeType, @notLegitContactInfo, @notLegitCampaignObjectId, @duplicateCheck, @campaignUnsubscribeExist , @campaignUnsubscribeInsert




-- Results Print Out
PRINT 'Campaign Unsubscribe Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   							AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   									AS money)), 1), '.00', '')
PRINT 'Non Legit Unsubscribe Type               :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitUnsubscribeType						AS money)), 1), '.00', '')
PRINT 'Non Legit Contact Info                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitContactInfo							AS money)), 1), '.00', '')
PRINT 'Non Legit Campaign ObjectId              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitCampaignObjectId						AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   								AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@campaignUnsubscribeExist			   			AS money)), 1), '.00', '')
PRINT 'Records Needing Insert                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@campaignUnsubscribeInsert			   			AS money)), 1), '.00', '')


PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_CampaignUnsubscribe_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_CampaignUnsubscribe_AutoDelivery	@answer = ''terminate'''

RETURN

END












	
	
	
--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN
	DECLARE @CampaignUnsubscribeInsertCheck		int
	SET		@CampaignUnsubscribeInsertCheck		= ( SELECT CampaignUnsubscribeInsert		FROM _campaignUnsubscribe_Statistics )
	


	UPDATE	_campaignUnsubscribe_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @CampaignUnsubscribeInsertCheck > 0
	BEGIN



	
		PRINT 'Inserting ' + CAST(@CampaignUnsubscribeInsertCheck AS varchar) + ' records'
	


		/**************  Campaign Unsubscribe Insert  **************/

		DECLARE @count int, @CampaignObjectId int, @Version int, @ContactInfo varchar(255), @UnsubscribeType int, @DateAdded dateTime

		-- version is static
		SET @Version = 0
				
		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded 	FROM _campaignUnsubscribe_Insert

		OPEN mycursor
		FETCH next FROM mycursor INTO @CampaignObjectId, @ContactInfo, @UnsubscribeType, @DateAdded

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@CampaignObjectId as varchar)+', '+cast(@Version as varchar)+', '+cast(@ContactInfo as varchar)+', '+cast(@UnsubscribeType as varchar)+', '+cast(@DateAdded as varchar)


		----******************* W A R N I N G***************************


		INSERT INTO CampaignUnsubscribe ( CampaignObjectId, Version, ContactInfo, UnsubscribeType, DateAdded )
		SELECT @CampaignObjectId, @Version, @ContactInfo, @UnsubscribeType, @DateAdded
		

		----***********************************************************

		SET @count = @count+1
		FETCH next FROM mycursor INTO @CampaignObjectId, @ContactInfo, @UnsubscribeType, @DateAdded

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@count as varchar)+' Records Processed'	

		/**************************************************************************************************/


		
		
		PRINT ''			
		PRINT 'Insert Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Inserts'
		
		DECLARE @successfulInserts		int
		SET		@successfulInserts		= ( SELECT COUNT(1)		FROM _campaignUnsubscribe_Insert	t01		JOIN 	CampaignUnsubscribe t02	WITH (NOLOCK) 	ON t01.CampaignObjectId = t02.CampaignObjectId	 AND 	t01.ContactInfo = t02.ContactInfo 	AND 	t01.UnsubscribeType = t02.UnsubscribeType 	AND 	t01.DateAdded = t02.DateAdded)
		
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@CampaignUnsubscribeInsertCheck AS varchar) + ' Successful: ' + CAST(@successfulInserts as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	UPDATE	_campaignUnsubscribe_Statistics
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
IF @CampaignUnsubscribeInsertCheck > 0 
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitUnsubscribeTypeV2								int
		, @notLegitContactInfoV2									varchar(255)
		, @notLegitCampaignObjectIdV2								int
		, @duplicateCheckV2											int
		, @campaignUnsubscribeExistV2									int
		, @campaignUnsubscribeInsertV2								int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2								= ( SELECT deliveryEmail									FROM _campaignUnsubscribe_Statistics )
SET @inputFileNameV2								= ( SELECT inputFileName									FROM _campaignUnsubscribe_Statistics )
SET @serverNameV2									= ( SELECT serverName										FROM _campaignUnsubscribe_Statistics )
SET @originalCountV2								= ( SELECT originalCount									FROM _campaignUnsubscribe_Statistics )
SET @nullCountV2									= ( SELECT nullCount										FROM _campaignUnsubscribe_Statistics )
SET @notLegitUnsubscribeTypeV2 						= ( SELECT notLegitUnsubscribeType							FROM _campaignUnsubscribe_Statistics )
SET @notLegitContactInfoV2							= ( SELECT notLegitContactInfo								FROM _campaignUnsubscribe_Statistics )
SET	@notLegitCampaignObjectIdV2						= ( SELECT notLegitCampaignObjectId							FROM _campaignUnsubscribe_Statistics )
SET @duplicateCheckV2								= ( SELECT duplicateCheck									FROM _campaignUnsubscribe_Statistics )
SET @campaignUnsubscribeExistV2						= ( SELECT campaignUnsubscribeExist							FROM _campaignUnsubscribe_Statistics )
SET @campaignUnsubscribeInsertV2					= ( SELECT campaignUnsubscribeInsert						FROM _campaignUnsubscribe_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _campaignUnsubscribe_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _campaignUnsubscribe_Statistics )
		
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









IF OBJECT_ID('tempdb..##campaignUnsubscribe_Action') IS NOT NULL	DROP TABLE ##campaignUnsubscribe_Action
CREATE TABLE ##campaignUnsubscribe_Action
	(
		Action								varchar(50)
		, CampaignObjectId					int
		, ContactInfo						varchar(255)
		, UnsubscribeType					int
		, DateAdded							dateTime
	)




IF @notLegitUnsubscribeTypeV2 > 0
BEGIN
	INSERT INTO ##campaignUnsubscribe_Action ( Action, CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT 	'NonLegit UnsubscribeType'
			, CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	FROM
			_campaignUnsubscribe_UnsubscribeType
END


IF @notLegitContactInfoV2 > 0
BEGIN
	INSERT INTO ##campaignUnsubscribe_Action ( Action, CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT 	'NonLegit ContactInfo'
			, CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	FROM
			_campaignUnsubscribe_ContactInfo
END


IF @notLegitCampaignObjectIdV2 > 0
BEGIN
	INSERT INTO ##campaignUnsubscribe_Action ( Action, CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT 	'NonLegit Campaign Id'
			, CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	FROM
			_campaignUnsubscribe_CampaignObjectId
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##campaignUnsubscribe_Action ( Action, CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT 	'Duplicate'
			, CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	FROM
			_campaignUnsubscribe_Duplicates

END
		



IF @campaignUnsubscribeExistV2 > 0
BEGIN
	INSERT INTO ##campaignUnsubscribe_Action ( Action, CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT 	'Record Exist'
			, CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	FROM
			_campaignUnsubscribe_Exist

END




IF @campaignUnsubscribeInsertV2 > 0
BEGIN
	INSERT INTO ##campaignUnsubscribe_Action ( Action, CampaignObjectId, ContactInfo, UnsubscribeType, DateAdded )
	SELECT 	'Inserted'
			, CampaignObjectId
			, ContactInfo
			, UnsubscribeType
			, DateAdded
			
	FROM
			_campaignUnsubscribe_Insert

END







IF OBJECT_ID('tempdb..##campaignUnsubscribe_Results') IS NOT NULL	DROP TABLE ##campaignUnsubscribe_Results
CREATE TABLE ##campaignUnsubscribe_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##campaignUnsubscribe_Results ( Item, Criteria )
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
SELECT 'NonLegit UnsubscribeType'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitUnsubscribeTypeV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit ContactInfo'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitContactInfoV2 , 0)    							AS money)), 1), '.00', '')
UNION ALL
SELECT 'NonLegit CampaignObjectId'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitCampaignObjectIdV2 , 0)    						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @campaignUnsubscribeExistV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Insert'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @campaignUnsubscribeInsertV2 , 0)   						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Insert'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulInserts , 0)   								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2











DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'CampaignUnsubscribe_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, CampaignObjectId
										, ContactInfo
										, UnsubscribeType
										, DateAdded
												
								FROM 
										##campaignUnsubscribe_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##campaignUnsubscribe_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Campaign Unsubscribe 
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
, @copy_recipients 				= 'tpeterson@mshare.net'
--, @copy_recipients 				= 'tpeterson@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Campaign Unsubscribe  Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'OLTP'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	


END
GOTO CLEANUP




CLEANUP:

	PRINT 'Cleaning up temp tables'


				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_UnsubscribeType') AND type = (N'U'))    			DROP TABLE _campaignUnsubscribe_UnsubscribeType
				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_ContactInfo') AND type = (N'U'))   				DROP TABLE _campaignUnsubscribe_ContactInfo
				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_CampaignObjectId') AND type = (N'U'))    		DROP TABLE _campaignUnsubscribe_CampaignObjectId
				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Duplicates') AND type = (N'U'))    				DROP TABLE _campaignUnsubscribe_Duplicates
				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Exist') AND type = (N'U'))    					DROP TABLE _campaignUnsubscribe_Exist
				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Insert') AND type = (N'U'))    					DROP TABLE _campaignUnsubscribe_Insert
				IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_campaignUnsubscribe_Statistics') AND type = (N'U'))    				DROP TABLE _campaignUnsubscribe_Statistics
						
						
				IF OBJECT_ID('tempdb..##campaignUnsubscribe_Upload') IS NOT NULL	DROP TABLE ##campaignUnsubscribe_Upload		
				IF OBJECT_ID('tempdb..##campaignUnsubscribe_Action') IS NOT NULL	DROP TABLE ##campaignUnsubscribe_Action
				IF OBJECT_ID('tempdb..##campaignUnsubscribe_Results') IS NOT NULL	DROP TABLE ##campaignUnsubscribe_Results


	
	
	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
