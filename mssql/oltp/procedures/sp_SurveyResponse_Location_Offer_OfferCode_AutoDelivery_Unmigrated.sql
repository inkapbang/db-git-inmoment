SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL
		, @throttle				int				= 1
		

AS
	
/****************  BackFill Options Auto Deliver  ****************

	Comments
		built to help with automation and scaling.
		
		
	History
		08.03.2012	Tad Peterson
			-- created, successful tested with live data
			
		07.23.2014	Tad Peterson
			-- added throttling
		
		04.05.2017 Bailey Hu
			-- Added detection/prevention of changes to migrated orgs.
			
			

	Execute on OLTP.
	
	sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated		
		@deliveryEmail			= 'tpeterson@InMoment.com'
		, @FileName				= NULL

		, @answer				= NULL		

	
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



										


										
--SELECT 	@deliveryEmailCheck, @FileNameCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'SurveyResponse Update'
		PRINT CHAR(9) + 'Description:  Updates LocationObjectId, OfferObjectId, OfferCode in SurveyResponse based on a provided file.'
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
		PRINT CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'LocationObjectId' + CHAR(13) + CHAR(9) + 'OfferObjectId' + CHAR(13) + CHAR(9) + 'OfferCode'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a spreadsheet with answers for them to create the file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated'
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
, @subject						= 'SurveyResponse Location Offer OfferCode Form'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

SurveyResponseId     LocationId     OfferId     OfferCode
186924949            679667         3479        1165
186939581            697737         3197        07419
177739578            515405         2341        10038403
198732145            680530         3479        1447





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

sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		

		
-- Example Below --

sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''tpeterson@InMoment.com''
	, @FileName		= ''AsurionBackfill.csv''
		



		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode
CREATE TABLE _surveyResponse_Location_Offer_OfferCode
		(
			SurveyResponseObjectId		bigint
			, LocationObjectId			int	
			, OfferObjectId				int
			, OfferCode					varchar(50)
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _surveyResponse_Location_Offer_OfferCode   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)

select objectid as organizationObjectId into #tmp_ODS_ORGS from organization with (nolock) where responseBehavior = 1

-- Inspect data set for changes to migrated orgs
IF 
	EXISTS (
		SELECT 1 
		FROM 
			_surveyResponse_Location_Offer_OfferCode x
		inner join surveyResponse sr with (nolock) on x.SurveyResponseObjectId = sr.objectId
		inner join location loc with (nolock) on sr.locationObjectId = loc.objectId
		inner join #tmp_ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
		--inner join _ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
	)
BEGIN
	PRINT 'Detected changes to a migrated org.'
	PRINT 'Cleaning up and exiting the process.'
	DROP TABLE _surveyResponse_Location_Offer_OfferCode
	RETURN
END

DROP TABLE #tmp_ODS_ORGS



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _surveyResponse_Location_Offer_OfferCode	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _surveyResponse_Location_Offer_OfferCode	WHERE SurveyResponseObjectId IS NULL	OR	LocationObjectId IS NULL	OR  OfferObjectId IS NULL	OR OfferCode IS NULL	OR OfferCode LIKE 'NULL' )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _surveyResponse_Location_Offer_OfferCode
	WHERE
			SurveyResponseObjectId	IS NULL
		OR
			LocationObjectId		IS NULL
		OR
			OfferObjectId			IS NULL
		OR
			OfferCode				IS NULL
		OR
			OfferCode				LIKE 'NULL'
		


			
END			

--SELECT TOP 50 *	FROM _surveyResponse_Location_Offer_OfferCode




-- Duplicate SurveyResponse Ids
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
																				_surveyResponse_Location_Offer_OfferCode	t101
																		GROUP BY
																				SurveyResponseObjectId
																		HAVING
																				COUNT(1) > 1
																	)	AS 	t10
														)			


-- Duplicate SurveyResponse Ids; preserved and deleted														
IF @DuplicateSurveyResponseObjectIds > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds
	SELECT
			SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId
			, OfferCode
	INTO 	_surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds	
	FROM
			_surveyResponse_Location_Offer_OfferCode	t10
	WHERE
			SurveyResponseObjectId IN 	( 
											SELECT
													SurveyResponseObjectId
											FROM
													_surveyResponse_Location_Offer_OfferCode	t10
											GROUP BY
													SurveyResponseObjectId
											HAVING
													COUNT(1) > 1
										)	

										
	-- Delete Step
	DELETE	t10
	FROM
			_surveyResponse_Location_Offer_OfferCode										t10
		JOIN
			_surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds		t20
					ON 
							t10.SurveyResponseObjectId = t20.SurveyResponseObjectId
						AND
							t10.LocationObjectId = t20.LocationObjectId							
						AND
							t10.OfferObjectId = t20.OfferObjectId
						AND
							t10.OfferCode = t20.OfferCode
							

END
										
											


-- Location Offer OfferCode Combination Verification
DECLARE @LocationOfferOfferCodeCombinationBad		int
SET		@LocationOfferOfferCodeCombinationBad		= 
														(
															SELECT
																	COUNT(1)
															FROM
																	_surveyResponse_Location_Offer_OfferCode	t10
																LEFT JOIN
																	OfferCode									t20
																			ON 
																					t10.LocationObjectId	= t20.LocationObjectId		
																				AND		
																					t10.OfferObjectId		= t20.OfferObjectId
																				AND
																					t10.OfferCode			= t20.OfferCode

															WHERE
																	t20.LocationObjectId	IS NULL
																OR
																	t20.OfferObjectId		IS NULL
																OR
																	t20.OfferCode			IS NULL
														)

--SELECT @LocationOfferOfferCodeCombinationBad



-- Non legit LocationObjectId & dataFieldOption pairs; preserved and deleted
IF @LocationOfferOfferCodeCombinationBad > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_BadPair') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_BadPair
	SELECT
			t10.SurveyResponseObjectId
			, t10.LocationObjectId
			, t10.OfferObjectId
			, t10.OfferCode
	INTO _surveyResponse_Location_Offer_OfferCode_BadPair	
	FROM
			_surveyResponse_Location_Offer_OfferCode	t10
		LEFT JOIN
			OfferCode									t20
					ON 
							t10.LocationObjectId	= t20.LocationObjectId		
						AND		
							t10.OfferObjectId		= t20.OfferObjectId
						AND
							t10.OfferCode			= t20.OfferCode
	WHERE
			t20.LocationObjectId	IS NULL
		OR
			t20.OfferObjectId		IS NULL
		OR
			t20.OfferCode			IS NULL

	-- Delete Step
	DELETE	t10
	FROM
			_surveyResponse_Location_Offer_OfferCode			t10
		JOIN
			_surveyResponse_Location_Offer_OfferCode_BadPair	t20
					ON 
							t10.SurveyResponseObjectId = t20.SurveyResponseObjectId
						AND
							t10.LocationObjectId = t20.LocationObjectId							
						AND
							t10.OfferObjectId = t20.OfferObjectId
						AND
							t10.OfferCode = t20.OfferCode
							

END

--SELECT *	FROM _surveyResponse_Location_Offer_OfferCode_BadPair







DECLARE @SurveyResponseObjectIdBad	bigint
SET		@SurveyResponseObjectIdBad	=

										(
											SELECT
													COUNT(1)
											FROM
													_surveyResponse_Location_Offer_OfferCode			t10
												LEFT JOIN
													SurveyResponse										t20	WITH (NOLOCK)
															ON t10.SurveyResponseObjectId = t20.ObjectId
											WHERE
													t20.ObjectId IS NULL		
										)

--SELECT @SurveyResponseObjectIdBad




-- Non legit SurveyResponseIds; preserved and deleted
IF @SurveyResponseObjectIdBad > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId
	SELECT
			SurveyResponseObjectId
			, t10.LocationObjectId
			, t10.OfferObjectId
			, t10.OfferCode
	INTO _surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId
	FROM
			_surveyResponse_Location_Offer_OfferCode			t10
		LEFT JOIN
			SurveyResponse										t20	WITH (NOLOCK)
					ON t10.SurveyResponseObjectId = t20.ObjectId
	WHERE
			t20.ObjectId IS NULL		

	-- Delete Step
	DELETE	t10
	FROM
			_surveyResponse_Location_Offer_OfferCode							t10
		JOIN
			_surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId		t20	WITH (NOLOCK)
					ON 
							t10.SurveyResponseObjectId 	= t20.SurveyResponseObjectId
						AND
							t10.LocationObjectId 		= t20.LocationObjectId							
						AND
							t10.OfferObjectId 			= t20.OfferObjectId
						AND
							t10.OfferCode 				= t20.OfferCode

END

--SELECT *	FROM _surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId




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
													, LocationObjectId
													, OfferObjectId
													, OfferCode
											FROM
													_surveyResponse_Location_Offer_OfferCode		t10
											GROUP BY 
													SurveyResponseObjectId
													, LocationObjectId
													, OfferObjectId
													, OfferCode
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Duplicates') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_Duplicates
	SELECT
			SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId
			, OfferCode
	INTO _surveyResponse_Location_Offer_OfferCode_Duplicates				
	FROM
			_surveyResponse_Location_Offer_OfferCode				t10
	GROUP BY 
			SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId
			, OfferCode
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t10
	FROM
			_surveyResponse_Location_Offer_OfferCode				t10
		JOIN
			_surveyResponse_Location_Offer_OfferCode_Duplicates		t20
					ON
							t10.SurveyResponseObjectId 	= t20.SurveyResponseObjectId
						AND
							t10.LocationObjectId 		= t20.LocationObjectId							
						AND
							t10.OfferObjectId 			= t20.OfferObjectId
						AND
							t10.OfferCode 				= t20.OfferCode

		
	-- Puts single version back in original file
	INSERT INTO _surveyResponse_Location_Offer_OfferCode ( SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT
			SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId
			, OfferCode
	FROM
			_surveyResponse_Location_Offer_OfferCode_Duplicates			


END


--SELECT *	FROM _surveyResponse_Location_Offer_OfferCode_Duplicates





-- Checks for existing records
DECLARE @SurveyResponseLocationOfferOfferCodeExist	int
SET		@SurveyResponseLocationOfferOfferCodeExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_Location_Offer_OfferCode		t10
																	JOIN
																		SurveyResponse									t20 WITH (NOLOCK)
																				ON	
																						t10.SurveyResponseObjectId	= t20.ObjectId
																					AND
																						t10.LocationObjectId		= t20.LocationObjectId
																					AND
																						t10.OfferObjectId			= t20.OfferObjectId
																					AND
																						t10.OfferCode				= t20.OfferCode
															)


--SELECT @SurveyResponseLocationOfferOfferCodeExist


-- Removes existing records; preserve and removes
IF @SurveyResponseLocationOfferOfferCodeExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Exist') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_Exist
	SELECT
			t10.SurveyResponseObjectId
			, t10.LocationObjectId
			, t10.OfferObjectId
			, t10.OfferCode
			
	INTO _surveyResponse_Location_Offer_OfferCode_Exist
	FROM
			_surveyResponse_Location_Offer_OfferCode		t10
		JOIN
			SurveyResponse									t20 WITH (NOLOCK)
					ON	
							t10.SurveyResponseObjectId	= t20.ObjectId
						AND
							t10.LocationObjectId		= t20.LocationObjectId
						AND
							t10.OfferObjectId			= t20.OfferObjectId
						AND
							t10.OfferCode				= t20.OfferCode

	-- Deletes Exist
	DELETE	t10
	FROM
			_surveyResponse_Location_Offer_OfferCode			t10
		JOIN
			_surveyResponse_Location_Offer_OfferCode_Exist		t20
					ON	
							t10.SurveyResponseObjectId	= t20.SurveyResponseObjectId
						AND
							t10.LocationObjectId		= t20.LocationObjectId
						AND
							t10.OfferObjectId			= t20.OfferObjectId
						AND
							t10.OfferCode				= t20.OfferCode					


END



--SELECT *	FROM _surveyResponse_Location_Offer_OfferCode_Exist




DECLARE @SurveyResponseLocationOfferOfferCodeUpdate	int
SET		@SurveyResponseLocationOfferOfferCodeUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_surveyResponse_Location_Offer_OfferCode		t10
																	JOIN
																		SurveyResponse									t20 WITH (NOLOCK)
																				ON	
																						t10.SurveyResponseObjectId			= t20.ObjectId
																					AND
																						(
																								t10.LocationObjectId		!= t20.LocationObjectId
																							OR
																								t10.OfferObjectId			!= t20.OfferObjectId
																							OR
																								t10.OfferCode				!= t20.OfferCode
																						)
															)


-- Seperates updating records; preserve and removes
IF @SurveyResponseLocationOfferOfferCodeUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Update') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_Update
	SELECT
			t10.SurveyResponseObjectId
			, t10.LocationObjectId
			, t20.LocationObjectId			AS LocationObjectId_Old
			, t10.OfferObjectId
			, t20.OfferObjectId				AS OfferObjectId_Old
			, t10.OfferCode
			, t20.OfferCode					AS OfferCode_Old
			
	INTO _surveyResponse_Location_Offer_OfferCode_Update
	FROM
			_surveyResponse_Location_Offer_OfferCode		t10
		JOIN
			SurveyResponse									t20 WITH (NOLOCK)
					ON	
							t10.SurveyResponseObjectId			= t20.ObjectId
						AND
							(
									t10.LocationObjectId		!= t20.LocationObjectId
								OR
									t10.OfferObjectId			!= t20.OfferObjectId
								OR
									t10.OfferCode				!= t20.OfferCode
							)

	-- Deletes Updates
	DELETE	t10
	FROM
			_surveyResponse_Location_Offer_OfferCode			t10
		JOIN
			_surveyResponse_Location_Offer_OfferCode_Update		t20
					ON	
							t10.SurveyResponseObjectId		= t20.SurveyResponseObjectId
						AND
							t10.LocationObjectId			= t20.LocationObjectId
						AND
							t10.OfferObjectId				= t20.OfferObjectId
						AND
							t10.OfferCode					= t20.OfferCode


END


--SELECT *	FROM _surveyResponse_Location_Offer_OfferCode_Update





-- Identifies any remaining rows in original file
DECLARE @SurveyResponseLocationOfferOfferCodeUnidentified		int
SET		@SurveyResponseLocationOfferOfferCodeUnidentified		= ( SELECT COUNT(1)	FROM _surveyResponse_Location_Offer_OfferCode )


IF @SurveyResponseLocationOfferOfferCodeUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Unidentified') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_Unidentified
	SELECT
			*
	INTO _surveyResponse_Location_Offer_OfferCode_Unidentified
	FROM
		_surveyResponse_Location_Offer_OfferCode
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Statistics') AND type = (N'U'))    DROP TABLE _surveyResponse_Location_Offer_OfferCode_Statistics
CREATE TABLE _surveyResponse_Location_Offer_OfferCode_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, surverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, DuplicateSurveyResponseObjectIds						int
		, LocationOfferOfferCodeCombinationBad					int
		, SurveyResponseObjectIdBad								int
		, duplicateCheck										int
		, SurveyResponseLocationOfferOfferCodeExist				int
		, SurveyResponseLocationOfferOfferCodeUpdate			int
		, SurveyResponseLocationOfferOfferCodeUnidentified		int
		, throttle												int				
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _surveyResponse_Location_Offer_OfferCode_Statistics ( DeliveryEmail, inputFileName, surverName, originalCount, nullCount, DuplicateSurveyResponseObjectIds, LocationOfferOfferCodeCombinationBad, SurveyResponseObjectIdBad, duplicateCheck, SurveyResponseLocationOfferOfferCodeExist, SurveyResponseLocationOfferOfferCodeUpdate, SurveyResponseLocationOfferOfferCodeUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @DuplicateSurveyResponseObjectIds, @LocationOfferOfferCodeCombinationBad, @SurveyResponseObjectIdBad, @duplicateCheck, @SurveyResponseLocationOfferOfferCodeExist, @SurveyResponseLocationOfferOfferCodeUpdate, @SurveyResponseLocationOfferOfferCodeUnidentified, @throttleCheck




-- Results Print Out
PRINT 'SurveyResponse LocationId OfferId OfferCode Statistics'
PRINT ''
PRINT 'Original CSV Row Count                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   									AS money)), 1), '.00', '')
PRINT 'NULL Values Found                               :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   											AS money)), 1), '.00', '')
PRINT 'Duplicate Response Ids                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@DuplicateSurveyResponseObjectIds   							AS money)), 1), '.00', '')
PRINT 'Bad Location OfferId OfferCode Combination      :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@LocationOfferOfferCodeCombinationBad					AS money)), 1), '.00', '')
PRINT 'Bad ResponseIds                                 :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseObjectIdBad								AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   										AS money)), 1), '.00', '')
PRINT 'Records Already Exist                           :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseLocationOfferOfferCodeExist   			AS money)), 1), '.00', '')
PRINT 'Records Needing Update                          :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseLocationOfferOfferCodeUpdate   			AS money)), 1), '.00', '')
PRINT 'Records Unidentified                            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@SurveyResponseLocationOfferOfferCodeUnidentified   	AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                  AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_SurveyResponse_Location_Offer_OfferCode_AutoDelivery_Unmigrated	@answer = ''terminate'''

RETURN

END

















/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
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
	
	DECLARE @srUpdateCheck		int
	SET		@srUpdateCheck		= ( SELECT SurveyResponseLocationOfferOfferCodeUpdate		FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
	

	UPDATE	_surveyResponse_Location_Offer_OfferCode_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @srUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@srUpdateCheck AS varchar) + ' records'
	
		/********************  SurveyResponse LocationId OfferId OfferCode Update  ********************/

		-----Cursor for SR Update

		DECLARE @count bigInt, @SurveyResponseObjectId bigInt, @LocationObjectId bigInt, @OfferObjectId bigInt, @OfferCode varchar(50)

		SET @count = 0

		DECLARE mycursor CURSOR for 
		SELECT SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode  FROM _surveyResponse_Location_Offer_OfferCode_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseObjectId, @LocationObjectId, @OfferObjectId, @OfferCode

		WHILE @@Fetch_Status = 0
		BEGIN


			  
		PRINT cast(@count as varchar)+', '+cast(@SurveyResponseObjectId as varchar)+', '+cast(@LocationObjectId as varchar)+', '+cast(@OfferObjectId as varchar)+', '+cast(@OfferCode as varchar)


		----******************* W A R N I N G***************************


		UPDATE 	SurveyResponse			WITH (ROWLOCK)
		SET 	LocationObjectId 	= @LocationObjectId
				, OfferObjectId		= @OfferObjectId
				, OfferCode			= @OfferCode
		WHERE 	objectId			= @SurveyResponseObjectId


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
		
		
		
		
		
		
		SET @count = @count + 1
		FETCH next FROM mycursor INTO @SurveyResponseObjectId, @LocationObjectId, @OfferObjectId, @OfferCode

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
		SET		@successfulUpdates		= ( SELECT COUNT(1) 	FROM _surveyResponse_Location_Offer_OfferCode_Update t10 JOIN SurveyResponse t20 WITH (NOLOCK) ON t10.SurveyResponseObjectId	= t20.ObjectId AND t10.LocationObjectId = t20.LocationObjectId AND t10.OfferObjectId = t20.OfferObjectId AND t10.OfferCode = t20.OfferCode	)

		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@srUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END



	UPDATE	_surveyResponse_Location_Offer_OfferCode_Statistics
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



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @DuplicateSurveyResponseObjectIdsV2								int
		, @LocationOfferOfferCodeCombinationBadV2					int
		, @SurveyResponseObjectIdBadV2								int
		, @duplicateCheckV2											int
		, @SurveyResponseLocationOfferOfferCodeExistV2				int
		, @SurveyResponseLocationOfferOfferCodeUpdateV2				int
		, @SurveyResponseLocationOfferOfferCodeUnidentifiedV2		int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @serverNameV2											= ( SELECT surverName												FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @DuplicateSurveyResponseObjectIdsV2						= ( SELECT DuplicateSurveyResponseObjectIds							FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @LocationOfferOfferCodeCombinationBadV2 				= ( SELECT LocationOfferOfferCodeCombinationBad						FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @SurveyResponseObjectIdBadV2							= ( SELECT SurveyResponseObjectIdBad								FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @duplicateCheckV2										= ( SELECT duplicateCheck											FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @SurveyResponseLocationOfferOfferCodeExistV2			= ( SELECT SurveyResponseLocationOfferOfferCodeExist				FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @SurveyResponseLocationOfferOfferCodeUpdateV2			= ( SELECT SurveyResponseLocationOfferOfferCodeUpdate				FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @SurveyResponseLocationOfferOfferCodeUnidentifiedV2		= ( SELECT SurveyResponseLocationOfferOfferCodeUnidentified			FROM _surveyResponse_Location_Offer_OfferCode_Statistics )


SET @ProcessingStartV2										= ( SELECT ProcessingStart				FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
SET @ProcessingCompleteV2									= ( SELECT ProcessingComplete			FROM _surveyResponse_Location_Offer_OfferCode_Statistics )
		
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


IF OBJECT_ID('tempdb..##SurveyResponseLocationOfferOfferCodeStatus_Action') IS NOT NULL		DROP TABLE ##SurveyResponseLocationOfferOfferCodeStatus_Action
CREATE TABLE ##SurveyResponseLocationOfferOfferCodeStatus_Action
	(
		Action								varchar(50)
		, SurveyResponseObjectId			bigInt
		, LocationObjectId					int
		, OfferObjectId						int
		, OfferCode							varchar(50)
		, LocationObjectId_Old				int
		, OfferObjectId_Old					int
		, OfferCode_Old						varchar(50)
	)



	
	
	
IF	@DuplicateSurveyResponseObjectIdsV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT 'Duplicate Response Ids'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds
END	
	

IF @SurveyResponseObjectIdBadV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT 	'Bad SurveyResponseId'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId
END


IF @LocationOfferOfferCodeCombinationBadV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT 	'Bad Location Offer OfferCode Combination'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_BadPair
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT 	'Duplicate'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_Duplicates

END
		



IF @SurveyResponseLocationOfferOfferCodeExistV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT 	'Record Exist'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_Exist

END




IF @SurveyResponseLocationOfferOfferCodeUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode )
	SELECT 	'Unidentified'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_Unidentified

END



IF @SurveyResponseLocationOfferOfferCodeUpdateV2 > 0	
BEGIN
	INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Action ( Action, SurveyResponseObjectId, LocationObjectId, OfferObjectId, OfferCode, LocationObjectId_Old, OfferObjectId_Old, OfferCode_Old )
	SELECT 	'Updated'
			, SurveyResponseObjectId
			, LocationObjectId
			, OfferObjectId		
			, OfferCode
			, LocationObjectId_Old
			, OfferObjectId_Old
			, OfferCode_Old
			
	FROM
			_surveyResponse_Location_Offer_OfferCode_Update

END
		



-- Builds Final Email
IF OBJECT_ID('tempdb..##SurveyResponseLocationOfferOfferCodeStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseLocationOfferOfferCodeStatus_Results
CREATE TABLE ##SurveyResponseLocationOfferOfferCodeStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##SurveyResponseLocationOfferOfferCodeStatus_Results ( Item, Criteria )
SELECT 'Server Name'								, @serverNameV2
UNION ALL
SELECT 'Delivery Email'								, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'							, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   											AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'									, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    												AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicate Response Ids'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @DuplicateSurveyResponseObjectIdsV2 , 0)									AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Bad Location Offer OfferCode Combination'	, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @LocationOfferOfferCodeCombinationBadV2 , 0)						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Bad SurveyResponseIds'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseObjectIdBadV2 , 0)    								AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates Records'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseLocationOfferOfferCodeExistV2 , 0)					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseLocationOfferOfferCodeUnidentifiedV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @SurveyResponseLocationOfferOfferCodeUpdateV2 , 0)   				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'						, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'						, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'SurveyResponse_LocationObjectId_OfferObjectId_OfferCode_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, SurveyResponseObjectId
										, LocationObjectId
										, OfferObjectId	
										, OfferCode
										, LocationObjectId_Old
										, OfferObjectId_Old	
										, OfferCode_Old
												
								FROM 
										##SurveyResponseLocationOfferOfferCodeStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##SurveyResponseLocationOfferOfferCodeStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
SurveyResponse Location Offer OfferCode Update
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
, @subject						= 'SurveyResponse Location Offer OfferCode Update Completed'
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
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode') AND type = (N'U'))									DROP TABLE _surveyResponse_Location_Offer_OfferCode
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds') AND type = (N'U'))    	DROP TABLE _surveyResponse_Location_Offer_OfferCode_DuplicateSurveyResponseObjectIds
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_BadPair') AND type = (N'U'))							DROP TABLE _surveyResponse_Location_Offer_OfferCode_BadPair
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId') AND type = (N'U'))				DROP TABLE _surveyResponse_Location_Offer_OfferCode_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Duplicates') AND type = (N'U'))						DROP TABLE _surveyResponse_Location_Offer_OfferCode_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Exist') AND type = (N'U'))							DROP TABLE _surveyResponse_Location_Offer_OfferCode_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Update') AND type = (N'U'))							DROP TABLE _surveyResponse_Location_Offer_OfferCode_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Unidentified') AND type = (N'U'))					DROP TABLE _surveyResponse_Location_Offer_OfferCode_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_surveyResponse_Location_Offer_OfferCode_Statistics') AND type = (N'U'))						DROP TABLE _surveyResponse_Location_Offer_OfferCode_Statistics

	IF OBJECT_ID('tempdb..##SurveyResponseLocationOfferOfferCodeStatus_Action') IS NOT NULL		DROP TABLE ##SurveyResponseLocationOfferOfferCodeStatus_Action
	IF OBJECT_ID('tempdb..##SurveyResponseLocationOfferOfferCodeStatus_Results') IS NOT NULL	DROP TABLE ##SurveyResponseLocationOfferOfferCodeStatus_Results




	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
