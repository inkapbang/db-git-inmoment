SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[sp_ResponseSegment_AutoDelivery_Unmigrated]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		, @answer				varchar(10)		= NULL	
		
		, @throttle				int				= 1

AS
	
/****************  BackFill Options Auto Deliver  ****************

	Tested With live data 5/23/2012; successful.
	

	Execute on OLTP.
	
	sp_ResponseSegmentFile_AutoDelivery_Unmigrated		
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

										
--SELECT 	@deliveryEmailCheck, @FileNameCheck, @ResponseSegmentObjectId01Check, @ResponseSegmentObjectId02Check, @ResponseSegmentObjectId03Check, @ResponseSegmentObjectId04Check, @ResponseSegmentObjectId05Check, @answerCheck, @ThrottleCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'ResponseSegment Update'
		PRINT CHAR(9) + 'Description:  Updates a SegmentObjectId from a provided file.'
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
		PRINT CHAR(9) + 'OrgId' + CHAR(13) + CHAR(9) + 'SurveyResponseId' + CHAR(13) + CHAR(9) + 'SegmentObjectId'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a spreadsheet with answers for them to create the file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_ResponseSegmentFile_AutoDelivery_Unmigrated'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail         = ''Their Email Here'''
		PRINT CHAR(9) + CHAR(9) +',@fileName         = ''example.csv'''
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
, @subject						= 'New SegmentObjectId File Setup Explanation'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.



File Setup & Contents Example
------------------------------

OrgId	SurveyResponseId	SegmentId
1230	103090587			248			      
1230	103090588			248			      






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

sp_ResponseSegmentFile_AutoDelivery_Unmigrated
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		


	
-- Example Below --

sp_ResponseSegmentFile_AutoDelivery_Unmigrated
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile
CREATE TABLE _ResponseSegmentFile
		(
			 OrgId			int	
			,SurveyResponseId	bigint
			,SegmentObjectId		int
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _ResponseSegmentFile   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)

-- Inspect data set for changes to migrated orgs
select objectid as organizationObjectId into #tmp_ODS_ORGS from organization with (nolock) where responseBehavior = 1



IF 
	EXISTS (
		SELECT 1 
		FROM 
			_ResponseSegmentFile x
		inner join surveyResponse sr with (nolock) on x.SurveyResponseId = sr.objectId
		inner join location loc with (nolock) on sr.locationObjectId = loc.objectId
		inner join #tmp_ODS_ORGS ods with (nolock) on loc.organizationObjectId = ods.organizationObjectId
	)
BEGIN
	PRINT 'Detected changes to a migrated org.'
	PRINT 'Cleaning up and exiting the process.'
	DROP TABLE _ResponseSegmentFile
	RETURN
END

DROP TABLE #tmp_ODS_ORGS


DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _ResponseSegmentFile	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) FROM _ResponseSegmentFile	WHERE OrgId IS NULL	OR SurveyResponseId IS NULL	OR	SegmentObjectId IS NULL )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _ResponseSegmentFile
	WHERE
			OrgId				IS Null
		OR
			SurveyResponseId	IS NULL
		OR
			SegmentObjectId	IS NULL		
END			


--select * from _ResponseSegmentFile  ---Isa

-- Verifies Segment ObjectId is legit
DECLARE @notLegitSegmentId_New		int
SET		@notLegitSegmentId_New		= 
														(
															SELECT
																	COUNT(1)
															FROM
																	_ResponseSegmentFile t01 
																LEFT JOIN
																	Segment	t02 WITH (NOLOCK)
																			ON t01.SegmentObjectId = t02.ObjectId and t01.orgId=t02.organizationObjectId
																		
															WHERE
																	t02.objectId IS NULL		
														)


	



IF @notLegitSegmentId_New > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Bad') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_Bad
	SELECT
			t01.OrgId
			,t01.SurveyResponseId
			,t01.SegmentObjectId
	INTO _ResponseSegmentFile_Bad
	FROM
			_ResponseSegmentFile		t01
		LEFT JOIN
			Segment	t02 WITH (NOLOCK)
				ON t01.SegmentObjectId = t02.ObjectId and t01.orgId=t02.organizationObjectId
			WHERE
				t02.objectId IS NULL

	--select * from _ResponseSegmentFile  ---Isa
	
	print 'Invalid segment objectId for this orgId in file, please fix it.  end process.'
	GOTO CLEANUP

END


DECLARE @notLegitSurveyResponseId	bigint
SET		@notLegitSurveyResponseId	=

										(
											SELECT
													COUNT(1)
											FROM
													_ResponseSegmentFile		t01
												LEFT JOIN
													SurveyResponse			t02	WITH (NOLOCK)
															ON t01.SurveyResponseId = t02.objectId
											WHERE
													t02.objectId IS NULL		
										)



-- Non legit SurveyResponseIds; preserved and deleted
IF @notLegitSurveyResponseId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_BadSurveyResponseId
	SELECT
			t01.OrgId
			,t01.SurveyResponseId
			,t01.SegmentObjectId
	INTO _ResponseSegmentFile_BadSurveyResponseId
	FROM
			_ResponseSegmentFile		t01
		LEFT JOIN
			SurveyResponse	t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL	
			
			

	-- Delete Step
	DELETE	t01
	FROM
			_ResponseSegmentFile		t01
		LEFT JOIN
			SurveyResponse			t02	WITH (NOLOCK)
					ON t01.SurveyResponseId = t02.objectId
	WHERE
			t02.objectId IS NULL		

END

--select * from _ResponseSegmentFile  ---Isa

-- Checks for Duplicates
DECLARE @duplicateCheck		int
SET		@duplicateCheck		= 
								(
									SELECT
											COUNT(1)
									FROM
										(		

											SELECT
													OrgId
													,SurveyResponseId
													,SegmentObjectId
											FROM
													_ResponseSegmentFile		t01
											GROUP BY 
													OrgId
													,SurveyResponseId
													,SegmentObjectId
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Duplicates') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_Duplicates
	SELECT
			OrgId
			,SurveyResponseId
			,SegmentObjectId
	INTO _ResponseSegmentFile_Duplicates		
	FROM
			_ResponseSegmentFile				t01

	GROUP BY 
			OrgId
			,SurveyResponseId
			,SegmentObjectId
	HAVING	COUNT(1) > 1
	
	
	select * from _ResponseSegmentFile_Duplicates

	-- Deletes Duplicates
	DELETE	t01
	FROM
			_ResponseSegmentFile				t01
		JOIN
			_ResponseSegmentFile_Duplicates	t02
						ON	
							t01.OrgId		= t02.OrgId	
							AND
								t01.SurveyResponseId	= t02.SurveyResponseId
							AND
								t01.SegmentObjectId	= t02.SegmentObjectId

		
	-- Puts single version back in original file
	INSERT INTO _ResponseSegmentFile ( OrgId,SurveyResponseId,SegmentObjectId)
	SELECT
			OrgId
			,SurveyResponseId
			,SegmentObjectId
	FROM
			_ResponseSegmentFile_Duplicates			

	--select * from _ResponseSegmentFile  ---Isa
END

-- Checks for existing records
DECLARE @responseSegmentNewExist	int
SET		@responseSegmentNewExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_ResponseSegmentFile		t01
																	JOIN
																		ResponseSegment	t02 WITH (NOLOCK)
																				ON	
																						t01.SurveyResponseId	= t02.responseObjectId
																					AND
																						t01.SegmentObjectId		= t02.SegmentObjectId
															)



-- Removes existing records; preserve and removes
IF @responseSegmentNewExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Exist') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_Exist
	SELECT
			t01.OrgId
			,t01.SurveyResponseId
			,t01.SegmentObjectId
			
	INTO _ResponseSegmentFile_Exist
	FROM
			_ResponseSegmentFile	t01
		JOIN
			ResponseSegment	t02 WITH (NOLOCK)
					ON	
							t01.SurveyResponseId	= t02.responseObjectId
						AND
							t01.SegmentObjectId		= t02.segmentObjectId

	-- Deletes Exist
	DELETE	t01
	FROM
			_ResponseSegmentFile	t01
		JOIN
			_ResponseSegmentFile_Exist		t02
					ON	
							t01.OrgId	= t02.OrgId
						AND
							t01.SurveyResponseId	= t02.SurveyResponseId
						AND
							t01.SegmentObjectId		= t02.SegmentObjectId
					

	--select * from _ResponseSegmentFile  ---Isa
	--SELECT COUNT(1)	FROM _ResponseSegmentFile  --Isa
END


-- Identifies any remaining rows in original file
DECLARE @responseSegmentNewInsert		int
SET		@responseSegmentNewInsert		= ( SELECT COUNT(1)	FROM _ResponseSegmentFile )


IF @responseSegmentNewInsert > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_NewInsert') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_NewInsert
	SELECT
			*
	INTO _ResponseSegmentFile_NewInsert
	FROM
		_ResponseSegmentFile
	
END

--select * from _ResponseSegmentFile_NewInsert ---Isa

-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Statistics') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_Statistics
CREATE TABLE _ResponseSegmentFile_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, surverName											varchar(25)
		, originalCount											int
		, nullCount												int
--		, notLegitResponseSegmentNew_Bad						int
		, notLegitSurveyResponseId								int
		, duplicateCheck										int
		, responseSegmentNewExist								int
--		, responseSegmentNewUpdate								int
		, responseSegmentNewInsert								int
		, throttle												int
		, processingStart										dateTime
		, processingComplete									dateTime
)

INSERT INTO _ResponseSegmentFile_Statistics ( DeliveryEmail, inputFileName, surverName, originalCount, nullCount, notLegitSurveyResponseId, duplicateCheck, responseSegmentNewExist,responseSegmentNewInsert, throttle )	
 SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitSurveyResponseId, @duplicateCheck, @responseSegmentNewExist , @responseSegmentNewInsert, @throttleCheck






-- Results Print Out
PRINT 'ResponseSegmentOld ResponseSegmentNew Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   									AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   											AS money)), 1), '.00', '')
--PRINT 'Non Legit ResponseSegments New                 :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    @notLegitResponseSegment_New					        AS money)), 1), '.00', '')
PRINT 'Non Legit ResponseIds                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitSurveyResponseId								AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   										AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ResponseSegmentNewExist   								AS money)), 1), '.00', '')
--PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ResponseSegmentNewUpdate   							AS money)), 1), '.00', '')
PRINT 'Records New								:' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@responseSegmentNewInsert   						AS money)), 1), '.00', '')
PRINT ''
PRINT 'Throttled                                :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@ThrottleCheck                                          AS money)), 1), '.00', '')
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_ResponseSegment_AutoDelivery_Unmigrated	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_ResponseSegment_AutoDelivery_Unmigrated	@answer = ''terminate'''

RETURN

------------
/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


-- Current replication delay value
SET 	@ThrottleCheck 	= 	( SELECT TOP 1 throttle	FROM _ResponseSegmentFile_Statistics )
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
	

	DECLARE @sraInsertCheck		int
	SET		@sraInsertCheck		= ( SELECT responseSegmentNewInsert		FROM _ResponseSegmentFile_Statistics )


	UPDATE	_ResponseSegmentFile_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @sraInsertCheck > 0
	BEGIN

		print 'Begin cursor'
		
		/******************** Response Segment Insert  ********************/
		DECLARE @successfulInsert int
		-----Cursor for SRA Insert

		DECLARE @countV2 bigint, @SurveyResponseIdV2 bigint, @SegmentIdV2 bigint, @newSequence bigint

		SET @countV2 = 0
		print 'Begin cursor'
		DECLARE mycursor CURSOR for
		SELECT SurveyResponseId, SegmentObjectId FROM _ResponseSegmentFile_NewInsert
		
		
		OPEN mycursor
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @SegmentIdV2

		WHILE @@Fetch_Status = 0
		BEGIN


			  
		PRINT cast(@countV2 as varchar)+', '+cast(@SurveyResponseIdV2 as varchar)+', '+cast(@SegmentIdV2 as varchar)

		----******************* W A R N I N G***************************


		--INSERT INTO _TestResponseSegment ([responseObjectId],[segmentObjectId])
		--SELECT @SurveyResponseIdV2, @SegmentIdV2
		
		INSERT INTO [dbo].[ResponseSegment] ([responseObjectId],[segmentObjectId])
		SELECT @SurveyResponseIdV2, @SegmentIdV2


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
		FETCH next FROM mycursor INTO @SurveyResponseIdV2, @SegmentIdV2
	
		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@countV2 as varchar)+' Records Processed'

		select @successfulInsert=@countV2
		/**************************************************************************************************/



		PRINT ''	
		PRINT 'Insert Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Inserts'

	
		PRINT CHAR(9) + 'Requested Inserts: ' + CAST(@sraInsertCheck AS varchar) + ' Successful: ' + CAST(@countV2 as varchar)
		PRINT ''
		PRINT ''
		
		
	
	END


	UPDATE	_ResponseSegmentFile_Statistics
	SET		processingComplete = GETDATE()
	
	
	GOTO PROCESSING_COMPLETE		

END


IF @answerCheck = 2
BEGIN

	PRINT 'Terminating Script'
	PRINT ''

	
GOTO CLEANUP
END

-----------------

PROCESSING_COMPLETE:

IF  @sraInsertCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitSurveyResponseIdV2								int
		, @duplicateCheckV2											int
		, @ResponseSegmenExistV2									int
		, @responseSegmentInsertV2									int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2										= ( SELECT deliveryEmail											FROM _ResponseSegmentFile_Statistics )
SET @inputFileNameV2										= ( SELECT inputFileName											FROM _ResponseSegmentFile_Statistics )
SET @serverNameV2											= ( SELECT surverName												FROM _ResponseSegmentFile_Statistics )
SET @originalCountV2										= ( SELECT originalCount											FROM _ResponseSegmentFile_Statistics )
SET @nullCountV2											= ( SELECT nullCount												FROM _ResponseSegmentFile_Statistics )
SET @notLegitSurveyResponseIdV2								= ( SELECT notLegitSurveyResponseId									FROM _ResponseSegmentFile_Statistics )
SET @duplicateCheckV2										= ( SELECT duplicateCheck											FROM _ResponseSegmentFile_Statistics )
SET @responseSegmenExistV2									= ( SELECT responseSegmentNewExist									FROM _ResponseSegmentFile_Statistics )
SET @responseSegmentInsertV2								= ( SELECT responseSegmentNewInsert									FROM _ResponseSegmentFile_Statistics )


IF @sraInsertCheck > 0
BEGIN
SET @responseSegmentInsertV2	= ( SELECT COUNT(1)	FROM _ResponseSegmentFile_NewInsert )
END

SET @ProcessingStartV2			= ( SELECT ProcessingStart				FROM _ResponseSegmentFile_Statistics )
SET @ProcessingCompleteV2		= ( SELECT ProcessingComplete			FROM _ResponseSegmentFile_Statistics )
		
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


END

----------
	
CLEANUP:

	PRINT 'Cleaning up temp tables'

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile') AND type = (N'U'))						DROP TABLE _ResponseSegmentFile
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Bad') AND type = (N'U'))				DROP TABLE _ResponseSegmentFile_Bad
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_BadSurveyResponseId') AND type = (N'U'))    DROP TABLE _ResponseSegmentFile_BadSurveyResponseId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Duplicates') AND type = (N'U'))				DROP TABLE _ResponseSegmentFile_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Exist') AND type = (N'U'))					DROP TABLE _ResponseSegmentFile_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_NewInsert') AND type = (N'U'))			DROP TABLE _ResponseSegmentFile_NewInsert
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile_Statistics') AND type = (N'U'))			DROP TABLE _ResponseSegmentFile_Statistics
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_ResponseSegmentFile') AND type = (N'U'))					DROP TABLE _ResponseSegmentFile

	
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
