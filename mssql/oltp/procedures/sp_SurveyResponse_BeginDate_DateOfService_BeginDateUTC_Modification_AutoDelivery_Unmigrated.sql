SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[sp_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_AutoDelivery_Unmigrated]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @Answer				varchar(10)		= NULL
		, @Throttle				int				= 1
		

AS

/**********************************  Manual Adjust BeginDate Of Responses  **********************************

	Comments
		Having more and more requests to manual adjust beginDate information.


	History
		09.03.2014	Tad Peterson
			-- converted the base manual demo org rolling forward script to an autoDelivery stored proc.

		11.10.2014	Tad Peterson
			-- added isdate() check do to out-of-range value when a the date is not a legitimate date
		
		04.05.2017 Bailey Hu
			-- Added detection/prevention of changes to migrated orgs.


**********************************************************************************************************/
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



										


										
--SELECT 	@deliveryEmailCheck, @FileNameCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'SurveyResponse BeginDate DateOfService BeginDateUTC Modification Update'
		PRINT CHAR(9) + 'Description:  Updates BeginDate, DateOfService, BeginDateUTC in SurveyResponse based on a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides details on file setup for requestor.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off via'
		PRINT CHAR(9) + CHAR(9) + CHAR(9) + '@Throttle = 0'		
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                    -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                   -   Sends requestor details on how to set up file for processing. '
		PRINT CHAR(9) + 'Delivery email address & File name       -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'OrganizationId' + CHAR(13) + CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'NewBeginDate'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a spreadsheet with answers for them to create the file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_AutoDelivery_Unmigrated'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		
		RETURN
	END		


---- Sends form to requestor
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
	AND
		@answerCheck 			= 0

BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	

	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'SurveyResponse BeginDate DateOfService BeginDateUTC Modification Form'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

OrgId     ResponseId     NewBeginDate
12344     123456789      2/14/2014
12344     987654321      7/1/2014
13570     618974599      10/31/2013
1239      23416987       2/9/2007





Notes & Comments
-----------------
	NewBeginDates can not be for future dates.
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	File restictions require the size to be 2 MB or less.  
	Row count does not matter as this process is throttled.
	
	
	Please make sure your file is attached to return email.





Return Email
-------------

sp_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		

		
-- Example Below --

sp_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''tpeterson@InMoment.com''
	, @FileName		= ''SmartGalWindows.csv''
		



		
'		
;
	
RETURN	
END		







-- Upload and Process Statistics
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 1	

BEGIN

SET NOCOUNT ON

--  Upload Create Table
IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload') IS NOT NULL 	DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		
CREATE TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload  
	(
		OrganizationObjectId 		Int
		, SurveyResponseObjectId    BigInt
		, UploadedBeginDate			varchar(10)
		
	)  


-- Processing table	
IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update') IS NOT NULL		DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update	
CREATE TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update  
	(
		OrganizationObjectId 		Int
		, SurveyResponseObjectId    BigInt
		, BeginDate_New				dateTime
		, DateOfService_New 		dateTime
		, BeginDateUTC_New 			dateTime
		, TimeOffset 				int
		, DateOfServiceOffset 		int
		, BeginDate_Old 			dateTime
		, DateOfService_Old 		dateTime
		, BeginDateUTC_Old 			dateTime
		
	)  



	
-- Upload file
DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)


-- Inspect data set for changes to migrated orgs
select objectid as organizationObjectId into #tmp_ODS_ORGS from organization with (nolock) where responseBehavior = 1

IF 
	EXISTS (
		SELECT 1 
		FROM 
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload x
		inner join #tmp_ODS_ORGS ods with (nolock) on x.organizationObjectId = ods.organizationObjectId
		--inner join _ODS_ORGS ods with (nolock) on x.organizationObjectId = ods.organizationObjectId
	)
BEGIN
	PRINT 'Detected changes to a migrated org.'
	PRINT 'Cleaning up and exiting the process.'
	DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload 
	RETURN
END

DROP TABLE #tmp_ODS_ORGS

-- Original file size
DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload	)

			
--SELECT @originalFileSize









-- NULLs removal
DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload	WHERE OrganizationObjectId		IS NULL OR SurveyResponseObjectId		IS NULL OR UploadedBeginDate			IS NULL OR UploadedBeginDate			LIKE 'NULL' )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload
	WHERE
			OrganizationObjectId		IS NULL
		OR
			SurveyResponseObjectId		IS NULL
		OR
			UploadedBeginDate			IS NULL
		OR
			UploadedBeginDate			LIKE 'NULL'
		

			
END			


-- Testing
--SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload	
			




-- Duplicate Check
DECLARE @DuplicateSurveyResponseObjectIds			int
SET		@DuplicateSurveyResponseObjectIds			= 
														(
															SELECT
																	COUNT(1)
															FROM
																	(		
																		SELECT
																				SurveyResponseObjectId
																		FROM
																				##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload				t101
																		GROUP BY
																				SurveyResponseObjectId
																		HAVING
																				COUNT(1) > 1
																	)	AS 	t10
														)			





-- Duplicate SurveyResponse Ids; preserved and deleted														
IF @DuplicateSurveyResponseObjectIds > 0
BEGIN
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds') IS NOT NULL	DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds	
	SELECT
			OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate

	INTO 	##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds	

	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload				t10
	GROUP BY 
			OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate
	HAVING
			COUNT(1) > 1

			
			
										
	-- Delete Step
	DELETE	t10
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload											t10
		JOIN
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds				t20
					ON t10.SurveyResponseObjectId = t20.SurveyResponseObjectId
							

							
							
							
	-- Puts single version back in
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload ( OrganizationObjectId, SurveyResponseObjectId, UploadedBeginDate )
	SELECT
			OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate

	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds				t10
							
							
							
							
							
END
















-- OrgId ResponseId validation			
DECLARE @OrgId_ResponseId_Bad		int		= 
												(
													SELECT
															COUNT(1)
													FROM
															##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		t10
														LEFT JOIN
															(
																SELECT
																		t20.objectId 					AS SurveyResponseObjectId
																		, t30.organizationObjectId 		AS OrganizationObjectId
																FROM		
																		SurveyResponse							t20
																	JOIN
																		Location								t30
																			ON t20.LocationObjectId = t30.objectId
																WHERE
																		t20.objectId IN ( SELECT SurveyResponseObjectId 	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload )

												
															)	AS t100
																	ON 
																			t10.SurveyResponseObjectId = t100.SurveyResponseObjectId 
																		AND
																			t10.OrganizationObjectId = t100.OrganizationObjectId
													WHERE
															t100.OrganizationObjectId IS NULL
														AND
															t100.SurveyResponseObjectId IS NULL
												)



												
IF	@OrgId_ResponseId_Bad > 0
BEGIN
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad') IS NOT NULL	DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad	
	SELECT
			t10.OrganizationObjectId
			, t10.SurveyResponseObjectId
			, t10.UploadedBeginDate	
			
	INTO 	##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		t10
		LEFT JOIN
			(
				SELECT
						t20.objectId 					AS SurveyResponseObjectId
						, t30.organizationObjectId 		AS OrganizationObjectId
				FROM		
						SurveyResponse							t20
					JOIN
						Location								t30
							ON t20.LocationObjectId = t30.objectId
				WHERE
						t20.objectId IN ( SELECT SurveyResponseObjectId 	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload )


			)	AS t100
					ON 
							t10.SurveyResponseObjectId = t100.SurveyResponseObjectId 
						AND
							t10.OrganizationObjectId = t100.OrganizationObjectId
	WHERE
			t100.OrganizationObjectId IS NULL
		AND
			t100.SurveyResponseObjectId IS NULL
	


	DELETE
			t10
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload								t10
		JOIN
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad		t20
				ON 		
						t10.OrganizationObjectId	=	t20.OrganizationObjectId
					AND
						t10.SurveyResponseObjectId	=	t20.SurveyResponseObjectId



			
			
END			


--Testing
--SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad		



			
-- Bad Dates
DECLARE @SurveyResponseBeginDateBadDates  int =
												(
													SELECT
															COUNT(1)
													FROM
															(
																SELECT
																		CASE	WHEN ISDATE( UploadedBeginDate ) = 1	THEN UploadedBeginDate 
																				ELSE NULL
																			END
																				AS UploadedBeginDate
																FROM					
																		##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload
															)	AS t10
													WHERE
															t10.UploadedBeginDate IS NULL
												)												
												
												
												
IF 	@SurveyResponseBeginDateBadDates > 0
BEGIN
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates') IS NOT NULL		DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates
	SELECT
			OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate
	INTO 	##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates
	FROM					
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload
	WHERE
			CASE WHEN ISDATE( UploadedBeginDate ) = 1 THEN UploadedBeginDate	ELSE NULL	END		IS NULL 




			
	DELETE
			t10
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload			t10
		JOIN
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates		t20
				ON 
						t10.OrganizationObjectId 	= t20.OrganizationObjectId
					AND	
						t10.SurveyResponseObjectId	= t20.SurveyResponseObjectId
					AND
						t10.UploadedBeginDate 		= t20.UploadedBeginDate
			
			

END											
												
												

												
												

	
-- Checks for existing			
DECLARE @SurveyResponseBeginDateExist 	int		= 
													(
														SELECT
																COUNT(1)
														FROM
																##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		t10
															JOIN
																SurveyResponse							t20
																	ON t10.SurveyResponseObjectId = t20.objectId
														WHERE
																t10.UploadedBeginDate	= t20.BeginDate
													)			

IF @SurveyResponseBeginDateExist > 0
BEGIN
		IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists') IS NOT NULL		DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists		
		SELECT
				t10.OrganizationObjectId
				, t10.SurveyResponseObjectId
				, t10.UploadedBeginDate
		INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists
		FROM
				##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		t10
			JOIN
				SurveyResponse							t20
					ON t10.SurveyResponseObjectId = t20.objectId
		WHERE
				t10.UploadedBeginDate	= t20.BeginDate


		
		
		
		DELETE
				t10
		FROM
				##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		t10
			JOIN
				##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists		t20
					ON 
							t10.OrganizationObjectId 	= t20.OrganizationObjectId
						AND	
							t10.SurveyResponseObjectId	= t20.SurveyResponseObjectId
						AND
							t10.UploadedBeginDate 		= t20.UploadedBeginDate
				
END


			
			
			
-- Testing
--SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists	
			






-- Sets up processing file
DECLARE @SurveyResponseBeginDateUpdate	int
SET 	@SurveyResponseBeginDateUpdate 	= ( SELECT COUNT(1) 	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload )

IF @SurveyResponseBeginDateUpdate > 0
BEGIN 

	-- Prep data; Note this is pre built at beginning of script
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update 
		( 
			OrganizationObjectId
			, SurveyResponseObjectId
			, BeginDate_New
			
			, DateOfService_New
			, BeginDateUTC_New
			, TimeOffset
			, DateOfServiceOffset
			
			, BeginDate_Old
			, DateOfService_Old
			, BeginDateUTC_Old 
		)
	
	SELECT
			t10.OrganizationObjectId
			, t10.SurveyResponseObjectId
			, CAST( t10.UploadedBeginDate 	AS DateTime )
			
			, CASE WHEN t20.DateOfService IS NULL THEN NULL ELSE DATEADD( DAY,     DATEDIFF( DAY, CAST( t10.UploadedBeginDate 	AS DateTime ), t20.beginDate )     , CAST( t10.UploadedBeginDate 	AS DateTime ) )		END		AS DateOfService_New
			, DATEADD( HOUR,    -(        DATEDIFF( HOUR, t20.beginDateUTC, ( t20.beginDate + t20.beginTime ) )          )               , ( CAST( t10.UploadedBeginDate 	AS DateTime ) + t20.beginTime ) )		AS BeginDateUTC_New
			, DATEDIFF( HOUR, t20.beginDateUTC, ( t20.beginDate + t20.beginTime ) )
			, DATEDIFF( DAY, t20.beginDate, t20.dateOfService )		AS DateOfServiceOffset
				
				
			, t20.BeginDate
			, t20.DateOfService
			, t20.BeginDateUTC
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		t10
		JOIN
			SurveyResponse							t20
				ON t10.SurveyResponseObjectId = t20.objectId


					
					
					
				
				
END
ELSE
BEGIN
		PRINT N'No records need processing'
		
		GOTO CLEANUP
		
		
END


			




			
-- Identifies any remaining rows in original file
DECLARE @SurveyResponseBeginDateUnidentified		int

/*  Not sure if this is used;  finish fixing if needed
SET		@SurveyResponseBeginDateUnidentified		= ( SELECT COUNT(1)	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload )


IF @SurveyResponseBeginDateUnidentified > 0
BEGIN

	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists') IS NOT NULL		DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists		
	SELECT
			*
	INTO _surveyResponse_Location_Offer_OfferCode_Unidentified
	FROM
		_surveyResponse_Location_Offer_OfferCode
	
END
			
*/			
			
			
			

IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics') IS NOT NULL		DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics	
CREATE TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, ServerName											varchar(25)
		, originalCount											int
		, nullCount												int
		, DuplicateSurveyResponseObjectIds						int
		, OrgId_ResponseId_Bad									int
		, SurveyResponseBeginDateBadDates						int
		, SurveyResponseBeginDateExist							int
		, SurveyResponseBeginDateUpdate							int
		, SurveyResponseBeginDateUnidentified					int
		, throttle												int				
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics ( DeliveryEmail, inputFileName, ServerName, originalCount, nullCount, DuplicateSurveyResponseObjectIds, OrgId_ResponseId_Bad, SurveyResponseBeginDateBadDates, SurveyResponseBeginDateExist, SurveyResponseBeginDateUpdate, SurveyResponseBeginDateUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @DuplicateSurveyResponseObjectIds, @OrgId_ResponseId_Bad, @SurveyResponseBeginDateBadDates, @SurveyResponseBeginDateExist, @SurveyResponseBeginDateUpdate, @SurveyResponseBeginDateUnidentified, @throttleCheck




-- Results Print Out
PRINT 'SurveyResponse BeginDate DateOfService BeginDateUTC Statistics'
PRINT ''
PRINT 'Original CSV Row Count                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   									AS money)), 1), '.00', '')
PRINT 'NULL Values Found                               :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   											AS money)), 1), '.00', '')
PRINT 'Duplicate Response Ids                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@DuplicateSurveyResponseObjectIds   					AS money)), 1), '.00', '')
PRINT 'Bad OrgId ResponseId Combination Or Invalid     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@OrgId_ResponseId_Bad									AS money)), 1), '.00', '')
PRINT 'Bad BeginDates                                  :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseBeginDateBadDates   						AS money)), 1), '.00', '')
PRINT 'Records Already Exist                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseBeginDateExist   						AS money)), 1), '.00', '')
PRINT 'Records Needing Update                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseBeginDateUpdate   						AS money)), 1), '.00', '')
PRINT 'Records Unidentified                            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseBeginDateUnidentified   					AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                  		AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_AutoDelivery_Unmigrated	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_AutoDelivery_Unmigrated	@answer = ''terminate'''

RETURN

END









RETURN







/*************************  Cursor Section, Please be careful!  *************************/

PROCESSING:



SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics  )
SET		@check			=	( 
								SELECT 
										MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
								FROM 
										putwh09.JobServerDb.dbo.ProductionDetailsCurrentAsOf
								WHERE
										--CurrentAsOf IS NOT NULL
										ReportingEnabled 	= 1
									AND
										Eligible 			= 1
							)



					


					
					

IF @answerCheck = 1
BEGIN
	
	DECLARE @srUpdateCheck		int
	SET		@srUpdateCheck		= ( SELECT SurveyResponseBeginDateUpdate		FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics  )
	

	UPDATE	##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics 
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @srUpdateCheck > 0
	BEGIN

		PRINT 'Updating ' + CAST(@srUpdateCheck AS varchar) + ' records'

		/********************  SurveyResponse BeginDate DateOfService BeginDateUTC Update  ********************/
		  
		-----Cursor for SR Update  
		SET NOCOUNT ON
		  
		DECLARE @count int, @SurveyResponseObjectId bigInt, @beginDate dateTime, @dateOfService	dateTime, @beginDateUTC	dateTime   
		 
		SET @count = 0
		  
		DECLARE mycursor cursor for  
		SELECT SurveyResponseObjectId, BeginDate_New, DateOfService_New, BeginDateUTC_New		FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update 
		  
		OPEN mycursor  
		FETCH next FROM mycursor INTO @SurveyResponseObjectId, @beginDate, @DateOfService, @BeginDateUTC  
		  
		WHILE @@Fetch_Status=0  
		BEGIN  

		  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseObjectId as varchar)
		 
		  
		  
		----******************* W A R N I N G***************************  
		  
		  
		UPDATE surveyResponse WITH (ROWLOCK)  
		SET   
			BeginDate		= @BeginDate  
			, DateOfService	= @DateOfService  
			, BeginDateUTC	= @BeginDateUTC
			
		WHERE 
			objectId		= @SurveyResponseObjectId  
		  
		  
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
											putwh09.JobServerDb.dbo.ProductionDetailsCurrentAsOf
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
												putwh09.JobServerDb.dbo.ProductionDetailsCurrentAsOf
										WHERE
												--CurrentAsOf IS NOT NULL
												ReportingEnabled 	= 1
											AND
												Eligible 			= 1
									)	
			END
		END
		
		
		
		
		
		
		
		
		
		
		

		SET @count = @count + 1
		 
		FETCH next FROM mycursor INTO @SurveyResponseObjectId, @BeginDate, @DateOfService, @BeginDateUTC  
		  
		END--WHILE  
		CLOSE mycursor  
		DEALLOCATE mycursor  
		  
		 
		 
		  
		/**************************************************************************************************/

		
		
		
		PRINT ''			
		PRINT 'Update Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Updates'
		
		DECLARE @successfulUpdates		int
		SET		@successfulUpdates		= ( SELECT COUNT(1) 	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update t10 JOIN SurveyResponse t20  ON t10.SurveyResponseObjectId = t20.ObjectId  AND t10.BeginDate_New = t20.BeginDate AND t10.BeginDateUTC_New = t20.BeginDateUTC )

		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@srUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END



	UPDATE	##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics 
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
IF @srUpdateCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'


-- Email prep
DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @DuplicateSurveyResponseObjectIdsV2						int

		, @OrgId_ResponseId_BadV2									int
		, @SurveyResponseBeginDateBadDatesV2						int
		
		, @SurveyResponseBeginDateExistV2							int
		, @SurveyResponseBeginDateUpdateV2							int
		, @SurveyResponseBeginDateUnidentifiedV2					int
		
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @serverNameV2											= ( SELECT serverName												FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @DuplicateSurveyResponseObjectIdsV2						= ( SELECT DuplicateSurveyResponseObjectIds							FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @OrgId_ResponseId_BadV2 								= ( SELECT OrgId_ResponseId_Bad										FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @SurveyResponseBeginDateBadDatesV2						= ( SELECT SurveyResponseBeginDateBadDates							FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )

SET @SurveyResponseBeginDateExistV2							= ( SELECT SurveyResponseBeginDateExist								FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @SurveyResponseBeginDateUpdateV2						= ( SELECT SurveyResponseBeginDateUpdate							FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @SurveyResponseBeginDateUnidentifiedV2					= ( SELECT SurveyResponseBeginDateUnidentified						FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )


SET @ProcessingStartV2										= ( SELECT ProcessingStart				FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
SET @ProcessingCompleteV2									= ( SELECT ProcessingComplete			FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics )
		
SET 	@Minutes											= ( SELECT (DATEDIFF( ss, @ProcessingStartV2, @ProcessingCompleteV2 )) / 60		)
SET 	@Seconds											= ( SELECT (DATEDIFF( ss, @ProcessingStartV2, @ProcessingCompleteV2 )) % 60		) 




IF @Minutes < 10
	BEGIN
		SET @Minutes = '0' + @Minutes
	END

	
IF @Seconds < 10
	BEGIN
		SET @Seconds = '0' + @Seconds
	END

SET @ProcessingDurationV2 = 'Minutes ' + @Minutes + ' Seconds ' + @Seconds


IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action') IS NOT NULL		DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action
CREATE TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action
	(
		Action						varchar(50)
		, OrganizationObjectId 		Int
		, SurveyResponseObjectId    BigInt
		, BeginDate_New				dateTime
		, DateOfService_New 		dateTime
		, BeginDateUTC_New 			dateTime
		, TimeOffset 				int
		, DateOfServiceOffset 		int
		, BeginDate_Old 			dateTime
		, DateOfService_Old 		dateTime
		, BeginDateUTC_Old 			dateTime
		, UploadedBeginDate_Bad		varchar(10)
	)

	
IF	@DuplicateSurveyResponseObjectIdsV2 > 0
BEGIN
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action ( Action, OrganizationObjectId, SurveyResponseObjectId, BeginDate_New )
	SELECT 'Duplicate Response Ids'
			, OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate		
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds
END	
	


IF @OrgId_ResponseId_BadV2 > 0
BEGIN
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action ( Action, OrganizationObjectId, SurveyResponseObjectId, BeginDate_New )
	SELECT 	'Bad OrgId ResponseId Combination Or Invalid '
			, OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate		
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad
END



IF @SurveyResponseBeginDateBadDatesV2 > 0
BEGIN
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action ( Action, OrganizationObjectId, SurveyResponseObjectId, UploadedBeginDate_Bad )
	SELECT 	'Bad BeginDate '
			, OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate		
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates
END





IF @SurveyResponseBeginDateExistV2 > 0
BEGIN
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action ( Action, OrganizationObjectId, SurveyResponseObjectId, BeginDate_New )
	SELECT 	'Record Exist'
			, OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate		
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists

END




IF @SurveyResponseBeginDateUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action ( Action, OrganizationObjectId, SurveyResponseObjectId, BeginDate_New )
	SELECT 	'Unidentified'
			, OrganizationObjectId
			, SurveyResponseObjectId
			, UploadedBeginDate		
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Unidentified

END



IF @SurveyResponseBeginDateUpdateV2 > 0	
BEGIN
	INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action ( Action, OrganizationObjectId, SurveyResponseObjectId, BeginDate_New, DateOfService_New, BeginDateUTC_New, TimeOffset, DateOfServiceOffset, BeginDate_Old, DateOfService_Old, BeginDateUTC_Old  )
	SELECT 	'Updated'
			, OrganizationObjectId
			, SurveyResponseObjectId
			, BeginDate_New
			, DateOfService_New
			, BeginDateUTC_New
			, TimeOffset
			, DateOfServiceOffset
			, BeginDate_Old
			, DateOfService_Old
			, BeginDateUTC_Old 
			
	FROM
			##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update

END







-- Builds Final Email
IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Results') IS NOT NULL	DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Results
CREATE TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Results ( Item, Criteria )
SELECT 'Server Name'									, @serverNameV2
UNION ALL
SELECT 'Delivery Email'									, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'								, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'								, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'										, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicate Response Ids'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @DuplicateSurveyResponseObjectIdsV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Bad OrgId ResponseId Combination Or Invalid'	, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @OrgId_ResponseId_BadV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Bad BeginDate'									, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseBeginDateBadDatesV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseBeginDateExistV2 , 0)					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseBeginDateUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'								, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseBeginDateUpdateV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'								, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'							, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'							, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Modification_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, OrganizationObjectId
										, SurveyResponseObjectId
										, BeginDate_New
										
										, DateOfService_New
										, BeginDateUTC_New
										, TimeOffset
										, DateOfServiceOffset
										
										, BeginDate_Old
										, DateOfService_Old
										, BeginDateUTC_Old 
										
										, UploadedBeginDate_Bad
										
								FROM 
										##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
SurveyResponse BeginDate DateOfService BeginDateUTC Update
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
, @subject						= 'SurveyResponse BeginDate DateOfService BeginDateUTC Modification Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= ','
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'oltp'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	


END

GOTO CLEANUP




CLEANUP:

	PRINT 'Cleaning up temp tables'


	-- Cleanup
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload') IS NOT NULL 							DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload		
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update') IS NOT NULL								DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update	
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds') IS NOT NULL	DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds	
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad') IS NOT NULL				DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad	
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates') IS NOT NULL							DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists') IS NOT NULL								DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists		
	IF OBJECT_ID('tempdb..##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics') IS NOT NULL							DROP TABLE ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics	


	PRINT 'Cleanup is complete'


	/*
	-- Testing 
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Upload
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Update
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_DuplicateSurveyResponseObjectIds
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_OrgId_ResponseId_Bad
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_BadDates	
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Exists
	SELECT *	FROM ##Manual_SurveyResponse_BeginDate_DateOfService_BeginDateUTC_Statistics 

	*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
