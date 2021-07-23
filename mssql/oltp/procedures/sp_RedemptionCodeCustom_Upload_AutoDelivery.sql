SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_RedemptionCodeCustom_Upload_AutoDelivery]
	@deliveryEmail			varchar(100)	= NULL
	, @FileName				varchar(100)	= NULL
	
	, @answer				varchar(10)		= NULL		
	, @throttle				int				= 1

AS
	
/**********************************  RedemptionCode Custom   **********************************

	Comments
		Originally requested from Todd Labrum


	History
		06.30.2014	Tad Peterson
			-- created


******************************************************************************************/
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
	
		PRINT 'RedemptionCodeCustom Upload'
		PRINT CHAR(9) + 'Description:  Uploads custom redemption codes from a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'This query provides a file setup explanation to the requestor.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT CHAR(9) + CHAR(9) + 'This stored procedures default behavior is throttled with .001 sec.  Can be turned off with a parameter.'
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
		PRINT CHAR(9) + 'OrganizationId'
		PRINT CHAR(9) + 'RedemptionCode'
		PRINT CHAR(9) + 'Market'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the exclusion reason list in order for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_RedemptionCodeCustom_Upload_AutoDelivery'
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
, @subject						= 'Custom RedemptionCode Request'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.




File Setup & Contents Example
------------------------------

OrgId           RedemptionCode          Market
855             0000749                 A&W 8
1044            Z005278n24              SLC
727             0011692001              WestVirgina





Notes & Comments
-----------------
	RedemptionCode column MUST be formatted as a TEXT column to preserve leading zeros in some codes.
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in a pipe (|) delimited CSV format.
	File restictions require the size to be 10 MB or less.  
	Row count does not matter as this process is throttled.
	
	Please make sure your file is attached to return email.





Return Email
-------------

sp_RedemptionCodeCustom_Upload_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_RedemptionCodeCustom_Upload_AutoDelivery
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


-- This allows for capturing too long redemptionCode or Market without truncation error
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Pre_Upload') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Pre_Upload
CREATE TABLE _RedemptionCodeCustom_Pre_Upload
		(
			OrganizationObjectId		INT
			, RedemptionCode			VARCHAR(2000)
			, Market					VARCHAR(2000)
			--, RedemptionCode			VARCHAR(50)
			--, Market					VARCHAR(50)
			
		)

-- Real Loading table		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload
CREATE TABLE _RedemptionCodeCustom_Upload
		(
			OrganizationObjectId		INT
			, RedemptionCode			VARCHAR(50)
			, Market					VARCHAR(50)
			
		)
		
		
		
		
SET @message = 'Uploading File'
RAISERROR (@message,0,1) with NOWAIT
		
		
DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _RedemptionCodeCustom_Pre_Upload   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'


EXECUTE (@FileNameBulkInsertStatement)



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _RedemptionCodeCustom_Pre_Upload	)
			
--SELECT @originalFileSize






-- Validating RedemptionCode and Market Length
SET @message = 'Validating RedemptionCode and Market Lengths'
RAISERROR (@message,0,1) with NOWAIT


-- Checks for existing records
DECLARE @RedemptionCodeMarketLength		int
SET		@RedemptionCodeMarketLength		= 
										(
											SELECT
													COUNT(1)
											FROM
													_RedemptionCodeCustom_Pre_Upload		t10
											WHERE
													LEN( t10.RedemptionCode ) 	> 50
												OR
													LEN( t10.Market ) 			> 50
												
										)


--SELECT @RedemptionCodeMarketLength


-- Removes bad length records; preserve and removes
IF @RedemptionCodeMarketLength > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_RedemptionCodeMarket_Length') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_RedemptionCodeMarket_Length
	SELECT
			t10.OrganizationObjectId
			, t10.RedemptionCode
			, t10.Market
			
	INTO _RedemptionCodeCustom_RedemptionCodeMarket_Length
	FROM
			_RedemptionCodeCustom_Pre_Upload		t10
	WHERE
			LEN( t10.RedemptionCode ) 	> 50
		OR
			LEN( t10.Market ) 			> 50
			

	-- Deletes Exist
	DELETE	t10
	FROM
			_RedemptionCodeCustom_Pre_Upload						t10
		JOIN
			_RedemptionCodeCustom_RedemptionCodeMarket_Length		t20
					ON	
							t10.OrganizationObjectId	= t20.OrganizationObjectId
						AND
							t10.RedemptionCode			= t20.RedemptionCode
						AND
							t10.Market					= t20.Market
					


END



-- Load records into upload table
SET @message = 'Loading upload table'
RAISERROR (@message,0,1) with NOWAIT



-- Move remaning records into load table
INSERT INTO _RedemptionCodeCustom_Upload ( OrganizationObjectId, RedemptionCode, Market )
SELECT
		t10.OrganizationObjectId
		, t10.RedemptionCode
		, t10.Market
FROM
		_RedemptionCodeCustom_Pre_Upload		t10






-- Validating NULLs
SET @message = 'Validating NULLs'
RAISERROR (@message,0,1) with NOWAIT


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _RedemptionCodeCustom_Upload		WHERE OrganizationObjectId IS NULL	OR	RedemptionCode IS NULL OR Market IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _RedemptionCodeCustom_Upload
	WHERE
			OrganizationObjectId	IS NULL
		OR
			RedemptionCode			IS NULL
		OR
			Market					IS NULL

			
END			




-- Verifies OrgId is legit
DECLARE @notLegitOrganizationId		int
SET		@notLegitOrganizationId		= 
											(
												SELECT
														COUNT(1)
												FROM
														_RedemptionCodeCustom_Upload		t10
													LEFT JOIN
														Organization						t20
															ON t10.OrganizationObjectId = t20.objectId
												WHERE
														t20.ObjectId IS NULL
											)

--SELECT @notLegitOrganizationId




-- Validating Organization Ids
SET @message = 'Validating Organization Ids'
RAISERROR (@message,0,1) with NOWAIT


-- Non legit Organization Id; preserved and deleted
IF @notLegitOrganizationId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_BadOrgId') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload_BadOrgId
	SELECT
			OrganizationObjectId
			, RedemptionCode
			, Market
	INTO _RedemptionCodeCustom_Upload_BadOrgId
	FROM
			_RedemptionCodeCustom_Upload		t10
		LEFT JOIN
			Organization						t20
				ON t10.OrganizationObjectId = t20.objectId
	WHERE
			t20.ObjectId IS NULL

	-- Delete Step
	DELETE	t10
	FROM
			_RedemptionCodeCustom_Upload			t10
		JOIN
			_RedemptionCodeCustom_Upload_BadOrgId	t20
				ON t10.OrganizationObjectId = t20.OrganizationObjectId

END





-- Validating Duplicates
SET @message = 'Validating Duplicates'
RAISERROR (@message,0,1) with NOWAIT
	
	
-- Checks for Duplicates
DECLARE @duplicateCheck		int
SET		@duplicateCheck		= 
								(
									SELECT
											COUNT(1)
									FROM
										(		
											SELECT
													OrganizationObjectId
													, RedemptionCode
													, Market
											FROM
													_RedemptionCodeCustom_Upload		t10
											GROUP BY 
													OrganizationObjectId
													, RedemptionCode
													, Market
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_Duplicates') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload_Duplicates
	SELECT
			OrganizationObjectId
			, RedemptionCode
			, Market
	INTO  _RedemptionCodeCustom_Upload_Duplicates		
	FROM
			_RedemptionCodeCustom_Upload				t10

	GROUP BY 
			OrganizationObjectId
			, RedemptionCode
			, Market
	HAVING	COUNT(1) > 1

	-- Deletes Duplicates
	DELETE	t10
	FROM
			_RedemptionCodeCustom_Upload				t10
		JOIN
			_RedemptionCodeCustom_Upload_Duplicates	t20
						ON	
								t10.OrganizationObjectId	= t20.OrganizationObjectId
							AND
								t10.RedemptionCode			= t20.RedemptionCode
							AND
								t10.Market					= t20.Market
								
							

		
	-- Puts single version back in original file
	INSERT INTO _RedemptionCodeCustom_Upload ( OrganizationObjectId, RedemptionCode, Market )
	SELECT
			OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_Upload_Duplicates			


END





-- Validating Duplicates
SET @message = 'Validating Existing Records'
RAISERROR (@message,0,1) with NOWAIT


-- Checks for existing records
DECLARE @RedemptionCodeCustomExist	int
SET		@RedemptionCodeCustomExist	= 
										(
											SELECT
													COUNT(1)
											FROM
													_RedemptionCodeCustom_Upload		t10
												JOIN
													RedemptionCodeCustom				t20 
															ON	
																	t10.OrganizationObjectId	= t20.OrganizationObjectId
																AND
																	t10.RedemptionCode			= t20.RedemptionCode
																AND
																	t10.Market					= t20.Market
										)


--SELECT @RedemptionCodeCustomExist


-- Removes existing records; preserve and removes
IF @RedemptionCodeCustomExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_Exist') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload_Exist
	SELECT
			t10.OrganizationObjectId
			, t10.RedemptionCode
			, t10.Market
			
	INTO _RedemptionCodeCustom_Upload_Exist
	FROM
			_RedemptionCodeCustom_Upload		t10
		JOIN
			RedemptionCodeCustom				t20 
					ON	
							t10.OrganizationObjectId	= t20.OrganizationObjectId
						AND
							t10.RedemptionCode			= t20.RedemptionCode
						AND
							t10.Market					= t20.Market

	-- Deletes Exist
	DELETE	t10
	FROM
			_RedemptionCodeCustom_Upload			t10
		JOIN
			_RedemptionCodeCustom_Upload_Exist		t20
					ON	
							t10.OrganizationObjectId	= t20.OrganizationObjectId
						AND
							t10.RedemptionCode			= t20.RedemptionCode
						AND
							t10.Market					= t20.Market
					


END










-- Validating Insert
SET @message = 'Validating Insert Records'
RAISERROR (@message,0,1) with NOWAIT


DECLARE @RedemptionCodeCustomInsert	int
SET		@RedemptionCodeCustomInsert	= 
										(
											SELECT
													COUNT(1)
											FROM
													_RedemptionCodeCustom_Upload		t10
												LEFT JOIN
													RedemptionCodeCustom				t20 
															ON	
																	t10.OrganizationObjectId	= t20.OrganizationObjectId
																AND
																	t10.RedemptionCode			= t20.RedemptionCode
																AND
																	t10.Market					= t20.Market
											WHERE
													t20.OrganizationObjectId	IS NULL
												OR
													t20.RedemptionCode			IS NULL
												OR
													t20.Market					IS NULL
													
										)

										


-- Seperates updating records; preserve and removes
IF @RedemptionCodeCustomInsert > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_Insert') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload_Insert
	SELECT
			t10.OrganizationObjectId
			, t10.RedemptionCode
			, t10.Market
			
	INTO _RedemptionCodeCustom_Upload_Insert
	FROM
			_RedemptionCodeCustom_Upload		t10
		LEFT JOIN
			RedemptionCodeCustom				t20 
					ON	
							t10.OrganizationObjectId	= t20.OrganizationObjectId
						AND
							t10.RedemptionCode			= t20.RedemptionCode
						AND
							t10.Market					= t20.Market
	WHERE
			t20.OrganizationObjectId	IS NULL
		OR
			t20.RedemptionCode			IS NULL
		OR
			t20.Market					IS NULL

			
	-- Deletes Inserts
	DELETE	t10
	FROM
			_RedemptionCodeCustom_Upload			t10
		JOIN
			_RedemptionCodeCustom_Upload_Insert		t20
					ON	
							t10.OrganizationObjectId	= t20.OrganizationObjectId
						AND
							t10.RedemptionCode			= t20.RedemptionCode
						AND
							t10.Market					= t20.Market
					


END







-- Validating Unidentified
SET @message = 'Validating Unidentified Records'
RAISERROR (@message,0,1) with NOWAIT



-- Identifies any remaining rows in original file
DECLARE @RedemptionCodeCustomUnidentified		int
SET		@RedemptionCodeCustomUnidentified		= ( SELECT COUNT(1)	FROM _RedemptionCodeCustom_Upload )


IF @RedemptionCodeCustomUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Unidentified') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Unidentified
	SELECT
			*
	INTO _RedemptionCodeCustom_Unidentified
	FROM
		_RedemptionCodeCustom_Upload
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload







-- Building Statistics Table
SET @message = 'Building Statistics Table'
RAISERROR (@message,0,1) with NOWAIT


IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Statistics') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Statistics
CREATE TABLE _RedemptionCodeCustom_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, redemptionCodeMarketLength							int
		, notLegitOrganizationId								int
		, duplicateCheck										int
		, redemptionCodeCustomExist								int
		, redemptionCodeCustomInsert							int
		, redemptionCodeCustomUnidentified						int
		, throttle												int		
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _RedemptionCodeCustom_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, redemptionCodeMarketLength, notLegitOrganizationId, duplicateCheck, redemptionCodeCustomExist, redemptionCodeCustomInsert, redemptionCodeCustomUnidentified, throttle )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @RedemptionCodeMarketLength, @notLegitOrganizationId, @duplicateCheck, @redemptionCodeCustomExist , @redemptionCodeCustomInsert, @redemptionCodeCustomUnidentified, @throttleCheck




-- Results Print Out
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT 'RedemptionCodeCustom Upload Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   							AS money)), 1), '.00', '')
PRINT 'RedemptionCode or Market Exceeds Length  :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@redemptionCodeMarketLength						AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   									AS money)), 1), '.00', '')
PRINT 'Non Legit Org Ids                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitOrganizationId							AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   								AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@redemptionCodeCustomExist   					AS money)), 1), '.00', '')
PRINT 'Records Needing Insert                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@redemptionCodeCustomInsert   					AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@redemptionCodeCustomUnidentified   			AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                  AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_RedemptionCodeCustom_Upload_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_RedemptionCodeCustom_Upload_AutoDelivery	@answer = ''terminate'''

RETURN

END





--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _RedemptionCodeCustom_Statistics )
SET		@check			=	( 
								SELECT 
										MAX( ABS( DateDiff( SECOND, GETDATE(), CurrentAsOf ) ) )
								FROM 
										PUTWH09.JobServerDb.dbo.ProductionDetailsCurrentAsOf
								WHERE
										--CurrentAsOf IS NOT NULL
										ReportingEnabled 	= 1
									AND
										Eligible 			= 1
							)



					


IF @answerCheck = 1
BEGIN
	

	DECLARE @RedemptionCodeCustomInsertCheck		int
	SET		@RedemptionCodeCustomInsertCheck		= ( SELECT redemptionCodeCustomInsert		FROM _RedemptionCodeCustom_Statistics )


	UPDATE	_RedemptionCodeCustom_Statistics
	SET		processingStart = GETDATE()

	
	IF @RedemptionCodeCustomInsertCheck > 0
	BEGIN
	
		PRINT 'Inserting ' + CAST(@RedemptionCodeCustomInsertCheck AS varchar) + ' records'



		/********************  RedemptionCodeCustom Insert  ********************/

		-----Cursor for RCC Insert

		DECLARE @countV2 bigint, @OrganizationObjectIdV2 int, @RedemptionCodeV2 varchar(50), @MarketV2 varchar(50), @LoadedDate dateTime
		
		SET @LoadedDate = ( SELECT processingStart		FROM _RedemptionCodeCustom_Statistics )
		
		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT OrganizationObjectId, RedemptionCode, Market FROM _RedemptionCodeCustom_Upload_Insert

		OPEN mycursor
		FETCH next FROM mycursor INTO @OrganizationObjectIdV2, @RedemptionCodeV2, @MarketV2

		WHILE @@Fetch_Status = 0
		BEGIN

			  
		PRINT cast(@countV2 as varchar)+', '+cast(@OrganizationObjectIdV2 as varchar)+', '+cast(@RedemptionCodeV2 as varchar)+', '+cast(@MarketV2 as varchar)


		----******************* W A R N I N G***************************


		INSERT INTO RedemptionCodeCustom ( OrganizationObjectId, RedemptionCode, Market, LoadedDate )
		SELECT @OrganizationObjectIdV2, @RedemptionCodeV2, @MarketV2, @LoadedDate


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
											PUTWH09.JobServerDb.dbo.ProductionDetailsCurrentAsOf
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
												PUTWH09.JobServerDb.dbo.ProductionDetailsCurrentAsOf
										WHERE
												--CurrentAsOf IS NOT NULL
												ReportingEnabled 	= 1
											AND
												Eligible 			= 1
									)	
			END
		END


		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @OrganizationObjectIdV2, @RedemptionCodeV2, @MarketV2

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
		
		
		IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_InsertCompleted') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Upload_InsertCompleted
		SELECT
				t10.OrganizationObjectId
				, t10.RedemptionCode
				, t10.Market
		INTO _RedemptionCodeCustom_Upload_InsertCompleted
		FROM 
				_RedemptionCodeCustom_Upload_Insert							t10		
			JOIN 
				RedemptionCodeCustom										t20
						ON 
							t10.OrganizationObjectId	= t20.OrganizationObjectId 
						AND 
							t10.RedemptionCode			= t20.RedemptionCode
						AND 
							t10.Market					= t20.Market
		
		
		-- Deletes Successful Inserts
		DELETE FROM t10
		FROM
				_RedemptionCodeCustom_Upload_Insert					t10
			JOIN
				_RedemptionCodeCustom_Upload_InsertCompleted		t20
						ON	
								t10.OrganizationObjectId	= t20.OrganizationObjectId
							AND
								t10.RedemptionCode			= t20.RedemptionCode
							AND
								t10.Market					= t20.Market
		
		
		
		DECLARE @successfulInsert		int
		SET		@successfulInsert		= ( SELECT COUNT(1)		FROM _RedemptionCodeCustom_Upload_InsertCompleted )
		
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@RedemptionCodeCustomInsertCheck AS varchar) + ' Successful: ' + CAST(@successfulInsert as varchar)
		PRINT ''
		PRINT ''
		
		
	
	END


	UPDATE	_RedemptionCodeCustom_Statistics
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
	

IF @RedemptionCodeCustomInsertCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  

		@DeliveryEmailV2										varchar(100)
		, @inputFileNameV2										varchar(100)
		, @serverNameV2											varchar(25)
		, @originalCountV2										int
		, @nullCountV2											int
		, @redemptionCodeMarketLengthV2							int
		, @notLegitOrganizationIdV2								int
		, @duplicateCheckV2										int
		, @redemptionCodeCustomExistV2							int
		, @redemptionCodeCustomInsertV2							int
		, @redemptionCodeCustomUnidentifiedV2					int
		, @throttleV2											int
		, @ProcessingStartV2									dateTime
		, @ProcessingCompleteV2									dateTime
		, @ProcessingDurationV2									varchar(25)


		, @Minutes												varchar(3)
		, @Seconds												varchar(3)		
				
		

		
		
		
		
SET @deliveryEmailV2								= ( SELECT deliveryEmail									FROM _RedemptionCodeCustom_Statistics )
SET @inputFileNameV2								= ( SELECT inputFileName									FROM _RedemptionCodeCustom_Statistics )
SET @serverNameV2									= ( SELECT serverName										FROM _RedemptionCodeCustom_Statistics )
SET @originalCountV2								= ( SELECT originalCount									FROM _RedemptionCodeCustom_Statistics )
SET @nullCountV2									= ( SELECT nullCount										FROM _RedemptionCodeCustom_Statistics )
SET @redemptionCodeMarketLengthV2 					= ( SELECT redemptionCodeMarketLength						FROM _RedemptionCodeCustom_Statistics )
SET @notLegitOrganizationIdV2						= ( SELECT notLegitOrganizationId							FROM _RedemptionCodeCustom_Statistics )
SET @duplicateCheckV2								= ( SELECT duplicateCheck									FROM _RedemptionCodeCustom_Statistics )
SET @redemptionCodeCustomExistV2					= ( SELECT redemptionCodeCustomExist						FROM _RedemptionCodeCustom_Statistics )
SET @redemptionCodeCustomInsertV2					= ( SELECT redemptionCodeCustomInsert						FROM _RedemptionCodeCustom_Statistics )
SET @redemptionCodeCustomUnidentifiedV2				= ( SELECT redemptionCodeCustomUnidentified					FROM _RedemptionCodeCustom_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _RedemptionCodeCustom_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _RedemptionCodeCustom_Statistics )
		
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



IF OBJECT_ID('tempdb..##RedemptionCodeCustomStatus_Action') IS NOT NULL	DROP TABLE ##RedemptionCodeCustomStatus_Action
CREATE TABLE ##RedemptionCodeCustomStatus_Action
	(
		Action						varchar(50)
		, OrganizationObjectId		int
		, RedemptionCode			varchar(2000)
		, Market					varchar(2000)
	)




IF @redemptionCodeMarketLengthV2 > 0
BEGIN
	INSERT INTO ##RedemptionCodeCustomStatus_Action ( Action, OrganizationObjectId, RedemptionCode, Market )
	SELECT 	
			'RedemptionCode Market Length'
			, OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_RedemptionCodeMarket_Length
END


IF @notLegitOrganizationIdV2 > 0
BEGIN
	INSERT INTO ##RedemptionCodeCustomStatus_Action ( Action, OrganizationObjectId, RedemptionCode, Market )
	SELECT 	
			'NonLegit Organization Id'
			, OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_Upload_BadOrgId
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##RedemptionCodeCustomStatus_Action ( Action, OrganizationObjectId, RedemptionCode, Market )
	SELECT 	
			'Duplicate'
			, OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_Upload_Duplicates

END
		



IF @RedemptionCodeCustomExistV2 > 0
BEGIN
	INSERT INTO ##RedemptionCodeCustomStatus_Action ( Action, OrganizationObjectId, RedemptionCode, Market )
	SELECT 	
			'Record Already Exist'
			, OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_Upload_Exist

END




IF @RedemptionCodeCustomUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##RedemptionCodeCustomStatus_Action ( Action, OrganizationObjectId, RedemptionCode, Market )
	SELECT 	
			'Record Unidentified'
			, OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_Unidentified

END



IF @RedemptionCodeCustomInsertV2 > 0	
BEGIN
	INSERT INTO ##RedemptionCodeCustomStatus_Action ( Action, OrganizationObjectId, RedemptionCode, Market )
	SELECT 	
			'Inserted'
			, OrganizationObjectId
			, RedemptionCode
			, Market
	FROM
			_RedemptionCodeCustom_Upload_InsertCompleted

END




		



-- Builds Final Email
IF OBJECT_ID('tempdb..##RedemptionCodeCustomStatus_Results') IS NOT NULL	DROP TABLE ##RedemptionCodeCustomStatus_Results
CREATE TABLE ##RedemptionCodeCustomStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##RedemptionCodeCustomStatus_Results ( Item, Criteria )
SELECT 'Server Name'								, @serverNameV2
UNION ALL
SELECT 'Delivery Email'								, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'							, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'RedemptionCode or Market Exceeds Length'	, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @redemptionCodeMarketLengthV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'									, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit Organization Id'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitOrganizationIdV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'									, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @RedemptionCodeCustomExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @RedemptionCodeCustomUnidentifiedV2 , 0)    	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Insert'								, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @redemptionCodeCustomInsertV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Insert'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulInsert , 0)   						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'						, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'						, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'RedemptionCodeCustom_Upload_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, OrganizationObjectId
										, RedemptionCode
										, Market
												
								FROM 
										##RedemptionCodeCustomStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##RedemptionCodeCustomStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
RedemptionCodeCustom Upload
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
, @subject						= 'RedemptionCodeCustom Upload Completed'
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
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


-- Quick table access
/*
SELECT *	FROM _RedemptionCodeCustom_RedemptionCodeMarket_Length
SELECT *	FROM _RedemptionCodeCustom_Upload
SELECT *	FROM _RedemptionCodeCustom_Upload_BadOrgId
SELECT *	FROM _RedemptionCodeCustom_Upload_Duplicates
SELECT *	FROM _RedemptionCodeCustom_Upload_Exist
SELECT *	FROM _RedemptionCodeCustom_Upload_Insert
SELECT *	FROM _RedemptionCodeCustom_Unidentified
SELECT *	FROM _RedemptionCodeCustom_Statistics
SELECT *	FROM _RedemptionCodeCustom_Upload_InsertCompleted

*/

-- Cleans up all temp tables
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Pre_Upload') AND type = (N'U'))    					DROP TABLE _RedemptionCodeCustom_Pre_Upload
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_RedemptionCodeMarket_Length') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_RedemptionCodeMarket_Length
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload') AND type = (N'U'))    						DROP TABLE _RedemptionCodeCustom_Upload
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_BadOrgId') AND type = (N'U'))    			DROP TABLE _RedemptionCodeCustom_Upload_BadOrgId
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_Duplicates') AND type = (N'U'))    			DROP TABLE _RedemptionCodeCustom_Upload_Duplicates
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_Exist') AND type = (N'U'))    				DROP TABLE _RedemptionCodeCustom_Upload_Exist
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_Insert') AND type = (N'U'))    				DROP TABLE _RedemptionCodeCustom_Upload_Insert
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Unidentified') AND type = (N'U'))    				DROP TABLE _RedemptionCodeCustom_Unidentified
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Statistics') AND type = (N'U'))    					DROP TABLE _RedemptionCodeCustom_Statistics
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Upload_InsertCompleted') AND type = (N'U'))    		DROP TABLE _RedemptionCodeCustom_Upload_InsertCompleted


IF OBJECT_ID('tempdb..##RedemptionCodeCustomStatus_Action') IS NOT NULL				DROP TABLE ##RedemptionCodeCustomStatus_Action
IF OBJECT_ID('tempdb..##RedemptionCodeCustomStatus_Results') IS NOT NULL			DROP TABLE ##RedemptionCodeCustomStatus_Results



Print 'Clean up complete'
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
