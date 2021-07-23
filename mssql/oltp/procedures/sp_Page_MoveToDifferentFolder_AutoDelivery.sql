SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_Page_MoveToDifferentFolder_AutoDelivery
CREATE Procedure [dbo].[sp_Page_MoveToDifferentFolder_AutoDelivery]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		

AS
	
/****************  Page Move To Different Folder Auto Deliver  ****************

	Execute on OLTP.

	Tested With live data 

	Modified:
			2.20.2013  -Tad Peterson
				--Created Script

	
	sp_Page_MoveToDifferentFolder_AutoDelivery		
		@deliveryEmail			= 'tpeterson@mshare.net'
		, @FileName				= NULL

		, @answer				= NULL		

	
******************************************************************************/

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
										
										


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @FolderObjectIdCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Moves Page To A Different Folder Update'
		PRINT CHAR(9) + 'Description:  Updates Folder Column on Page Table based on a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor list of the exclusion reasons. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'PageObjectId' + CHAR(13) + CHAR(9) + 'FolderObjectId'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the form for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_Page_MoveToDifferentFolder_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail = ''Their Email Here'''
		
	RETURN
	END		






-- Sends Form
IF		@deliveryEmailCheck		= 1	
	AND 
		@FileNameCheck			= 0	
			
BEGIN

	PRINT 'Emailed form to ' + @deliveryEmail
	
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Move Page To Different Folder Request'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.




File Setup & Contents Example
------------------------------

PageId	FolderId
10967       2902
16135       2902
16199       758





Notes & Comments
-----------------
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_Page_MoveToDifferentFolder_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_Page_MoveToDifferentFolder_AutoDelivery
	@DeliveryEmail	= ''tpeterson@mshare.net''
	, @FileName		= ''HertzZPendingDelete.csv''
		



		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move') AND type = (N'U'))    DROP TABLE _Page_Folder_Move
CREATE TABLE _Page_Folder_Move
		(
			PageObjectId			bigint
			, FolderObjectId			int	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _Page_Folder_Move   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _Page_Folder_Move	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _Page_Folder_Move	WHERE PageObjectId IS NULL	OR	FolderObjectId IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _Page_Folder_Move
	WHERE
			PageObjectId		IS NULL
		OR
			FolderObjectId		IS NULL
			
END			




-- Verifies DataFieldOption is legit
DECLARE @notLegitFolderObjectId		int
SET		@notLegitFolderObjectId		= 
											(
												SELECT
														COUNT(1)
												FROM
														_Page_Folder_Move		t10
													LEFT JOIN
														Folder					t20
															ON t10.FolderObjectId = t20.ObjectId
												WHERE
														t20.objectId IS NULL
											)

--SELECT @notLegitFolderObjectId



-- Non legit FolderObjectId; preserved and deleted
IF @notLegitFolderObjectId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_BadFolderObjectId') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_BadFolderObjectId
	SELECT
			PageObjectId
			, FolderObjectId
	INTO _Page_Folder_Move_BadFolderObjectId
	FROM
			_Page_Folder_Move		t10
		LEFT JOIN
			Folder					t20
				ON t10.FolderObjectId = t20.ObjectId
	WHERE
			t20.objectId IS NULL

	-- Delete Step
	DELETE	t10
	FROM
			_Page_Folder_Move						t10
		JOIN
			_Page_Folder_Move_BadFolderObjectId		t20
				ON t10.PageObjectId = t20.PageObjectId AND t10.FolderObjectId = t20.FolderObjectId
END




DECLARE @notLegitPageObjectId	bigint
SET		@notLegitPageObjectId	=

										(
											SELECT
													COUNT(1)
											FROM
													_Page_Folder_Move		t10
												LEFT JOIN
													Page					t20	WITH (NOLOCK)
														ON t10.PageObjectId = t20.objectId
											WHERE
													t20.objectId IS NULL		
										)

--SELECT @notLegitPageObjectId


-- Non legit PageObjectIds; preserved and deleted
IF @notLegitPageObjectId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_BadPageObjectId') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_BadPageObjectId
	SELECT
			PageObjectId
			, t10.FolderObjectId
	INTO _Page_Folder_Move_BadPageObjectId
	FROM
			_Page_Folder_Move								t10
		LEFT JOIN
			Page											t20	WITH (NOLOCK)
					ON t10.PageObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

	-- Delete Step
	DELETE	t10
	FROM
			_Page_Folder_Move								t10
		JOIN
			_Page_Folder_Move_BadPageObjectId				t20
					ON t10.PageObjectId = t20.PageObjectId

END



-- Checks for Duplicates; PageObjectId Only
DECLARE @duplicateCheck		int
SET		@duplicateCheck		= 
								(
									SELECT
											COUNT(1)
									FROM
										(		

											SELECT
													PageObjectId
											FROM
													_Page_Folder_Move		t10
											GROUP BY 
													PageObjectId
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Duplicates') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_Duplicates
	SELECT
			PageObjectId
			, FolderObjectId
	INTO _Page_Folder_Move_Duplicates
	FROM
			_Page_Folder_Move
	WHERE
			PageObjectId IN ( SELECT PageObjectId 	FROM _Page_Folder_Move 	GROUP BY PageObjectId	HAVING COUNT(1) > 1 )
	ORDER BY
			PageObjectId
	

	-- Deletes Duplicates
	DELETE	t10
	FROM
			_Page_Folder_Move				t10
		JOIN
			_Page_Folder_Move_Duplicates	t20
						ON	
								t10.PageObjectId	= t20.PageObjectId
							AND
								t10.FolderObjectId	= t20.FolderObjectId

								
								
	--THIS IS NOT NECCESSARY FOR THIS SCRIPT	
	---- Puts single version back in original file
	--INSERT INTO _Page_Folder_Move ( PageObjectId, FolderObjectId )
	--SELECT
	--		PageObjectId
	--		, FolderObjectId
	--FROM
	--		_Page_Folder_Move_Duplicates			


	
	--Sets @duplicateCheck value to true count.
	SET	@duplicateCheck = ( SELECT COUNT(1)	FROM _Page_Folder_Move_Duplicates )
			
END



-- Checks for existing records
DECLARE @PageFolderObjectIdExist	int
SET		@PageFolderObjectIdExist	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_Page_Folder_Move		t10
																	JOIN
																		Page						t20 WITH (NOLOCK)
																				ON	
																						t10.PageObjectId	= t20.ObjectId
																					AND
																						t10.FolderObjectId	= t20.FolderObjectId
															)


--SELECT @PageFolderObjectIdExist


-- Removes existing records; preserve and removes
IF @PageFolderObjectIdExist > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Exist') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_Exist
	SELECT
			PageObjectId
			, t10.FolderObjectId
			
	INTO _Page_Folder_Move_Exist
	FROM
			_Page_Folder_Move		t10
		JOIN
			Page					t20 WITH (NOLOCK)
					ON	
							t10.PageObjectId	= t20.ObjectId
						AND
							t10.FolderObjectId	= t20.FolderObjectId

	-- Deletes Exist
	DELETE	t10
	FROM
			_Page_Folder_Move			t10
		JOIN
			_Page_Folder_Move_Exist		t20
					ON	
							t10.PageObjectId	= t20.PageObjectId
						AND
							t10.FolderObjectId	= t20.FolderObjectId
					


END




DECLARE @PageFolderObjectIdUpdate	int
SET		@PageFolderObjectIdUpdate	= 
															(
																SELECT
																		COUNT(1)
																FROM
																		_Page_Folder_Move		t10
																	JOIN
																		Page					t20 WITH (NOLOCK)
																				ON	
																						t10.PageObjectId	= t20.ObjectId
																					AND
																						t10.FolderObjectId	!= t20.FolderObjectId
															)


-- Seperates updating records; preserve and removes
IF @PageFolderObjectIdUpdate > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Update') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_Update
	SELECT
			PageObjectId
			, t10.FolderObjectId
			, t20.FolderObjectId						AS FolderObjectId_Old
			
	INTO _Page_Folder_Move_Update
	FROM
			_Page_Folder_Move				t10
		JOIN
			Page							t20 WITH (NOLOCK)
					ON	
							t10.PageObjectId	= t20.ObjectId
						AND
							t10.FolderObjectId	!= t20.FolderObjectId

	-- Deletes Updates
	DELETE	t10
	FROM
			_Page_Folder_Move				t10
		JOIN
			_Page_Folder_Move_Update		t20
					ON	
							t10.PageObjectId		= t20.PageObjectId
						AND
							t10.FolderObjectId		= t20.FolderObjectId
					


END








-- Identifies any remaining rows in original file
DECLARE @PageFolderObjectIdUnidentified		int
SET		@PageFolderObjectIdUnidentified		= ( SELECT COUNT(1)	FROM _Page_Folder_Move )


IF @PageFolderObjectIdUnidentified > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Unidentified') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_Unidentified
	SELECT
			*
	INTO _Page_Folder_Move_Unidentified
	FROM
		_Page_Folder_Move
	
END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move') AND type = (N'U'))    DROP TABLE _Page_Folder_Move




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Statistics') AND type = (N'U'))    DROP TABLE _Page_Folder_Move_Statistics
CREATE TABLE _Page_Folder_Move_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitFolderObjectId								int
		, notLegitPageObjectId									int
		, duplicateCheck										int
		, PageFolderObjectIdExist								int
		, PageFolderObjectIdUpdate								int
		, PageFolderObjectIdUnidentified						int
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _Page_Folder_Move_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitFolderObjectId, notLegitPageObjectId, duplicateCheck, PageFolderObjectIdExist, PageFolderObjectIdUpdate, PageFolderObjectIdUnidentified )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitFolderObjectId, @notLegitPageObjectId, @duplicateCheck, @PageFolderObjectIdExist , @PageFolderObjectIdUpdate, @PageFolderObjectIdUnidentified




-- Results Print Out
PRINT 'Page Move To Different Folder Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   				AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   						AS money)), 1), '.00', '')
PRINT 'Non Legit Folder Ids                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitFolderObjectId				AS money)), 1), '.00', '')
PRINT 'Non Legit Page   Ids                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitPageObjectId				AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   					AS money)), 1), '.00', '')
PRINT 'Records Already Exist                    :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@PageFolderObjectIdExist   			AS money)), 1), '.00', '')
PRINT 'Records Needing Update                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@PageFolderObjectIdUpdate   		AS money)), 1), '.00', '')
PRINT 'Records Unidentified                     :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@PageFolderObjectIdUnidentified   	AS money)), 1), '.00', '')

PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_Page_MoveToDifferentFolder_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_Page_MoveToDifferentFolder_AutoDelivery	@answer = ''terminate'''

RETURN

END





--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN
	
	DECLARE @SrExUpdateCheck		int
	SET		@SrExUpdateCheck		= ( SELECT PageFolderObjectIdUpdate		FROM _Page_Folder_Move_Statistics )
	


	UPDATE	_Page_Folder_Move_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @SrExUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@SrExUpdateCheck AS varchar) + ' records'
	


		/**************  Survey Response Exclusion Reason Update  **************/

		DECLARE @count int, @PageObjectId int, @FolderObjectId int

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT PageObjectId, FolderObjectId FROM _Page_Folder_Move_Update

		OPEN mycursor
		FETCH next FROM mycursor INTO @PageObjectId, @FolderObjectId

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@PageObjectId as varchar)+', '+cast(@FolderObjectId as varchar)


		----******************* W A R N I N G***************************

		
		UPDATE Page WITH (ROWLOCK)
		SET FolderObjectId = @FolderObjectId
		WHERE objectId = @PageObjectId
		

		----***********************************************************

		SET @count = @count+1
		FETCH next FROM mycursor INTO @PageObjectId, @FolderObjectId

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _Page_Folder_Move_Update	t10		JOIN Page t20	WITH (NOLOCK) 	ON t10.PageObjectId = t20.objectId AND t10.FolderObjectId = t20.FolderObjectId )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@SrExUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	UPDATE	_Page_Folder_Move_Statistics
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
IF @SrExUpdateCheck > 0 
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  @deliveryEmailV2											varchar(100)			
		, @inputFileNameV2											varchar(100)
		, @serverNameV2												varchar(25)
		, @originalCountV2											int
		, @nullCountV2												int
		, @notLegitFolderObjectIdV2									int
		, @notLegitPageObjectIdV2									int
		, @duplicateCheckV2											int
		, @PageFolderObjectIdExistV2								int
		, @PageFolderObjectIdUpdateV2								int
		, @PageFolderObjectIdUnidentifiedV2							int
		, @ProcessingStartV2										dateTime
		, @ProcessingCompleteV2										dateTime
		, @ProcessingDurationV2										varchar(25)


		, @Minutes													varchar(3)
		, @Seconds													varchar(3)		
				
		

SET @deliveryEmailV2					= ( SELECT deliveryEmail						FROM _Page_Folder_Move_Statistics )
SET @inputFileNameV2					= ( SELECT inputFileName						FROM _Page_Folder_Move_Statistics )
SET @serverNameV2						= ( SELECT serverName							FROM _Page_Folder_Move_Statistics )
SET @originalCountV2					= ( SELECT originalCount						FROM _Page_Folder_Move_Statistics )
SET @nullCountV2						= ( SELECT nullCount							FROM _Page_Folder_Move_Statistics )
SET @notLegitFolderObjectIdV2 			= ( SELECT notLegitFolderObjectId				FROM _Page_Folder_Move_Statistics )
SET @notLegitPageObjectIdV2				= ( SELECT notLegitPageObjectId					FROM _Page_Folder_Move_Statistics )
SET @duplicateCheckV2					= ( SELECT duplicateCheck						FROM _Page_Folder_Move_Statistics )
SET @PageFolderObjectIdExistV2			= ( SELECT PageFolderObjectIdExist				FROM _Page_Folder_Move_Statistics )
SET @PageFolderObjectIdUpdateV2			= ( SELECT PageFolderObjectIdUpdate				FROM _Page_Folder_Move_Statistics )
SET @PageFolderObjectIdUnidentifiedV2	= ( SELECT PageFolderObjectIdUnidentified		FROM _Page_Folder_Move_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _Page_Folder_Move_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _Page_Folder_Move_Statistics )
		
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


IF OBJECT_ID('tempdb..##PageFolderObjectIdStatus_Action') IS NOT NULL	DROP TABLE ##PageFolderObjectIdStatus_Action
CREATE TABLE ##PageFolderObjectIdStatus_Action
	(
		Action							varchar(50)
		, PageObjectId					bigInt
		, FolderObjectId				int
		, FolderObjectId_Old			int
	)




IF @notLegitPageObjectIdV2 > 0
BEGIN
	INSERT INTO ##PageFolderObjectIdStatus_Action ( Action, PageObjectId, FolderObjectId )
	SELECT 	'NonLegit PageObjectId'
		, PageObjectId
		, FolderObjectId	
			
	FROM
			_Page_Folder_Move_BadPageObjectId
END


IF @notLegitFolderObjectIdV2 > 0
BEGIN
	INSERT INTO ##PageFolderObjectIdStatus_Action ( Action, PageObjectId, FolderObjectId )
	SELECT 	'NonLegit FolderObjectId'
			, PageObjectId
			, FolderObjectId	
			
	FROM
			_Page_Folder_Move_BadFolderObjectId
END


IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##PageFolderObjectIdStatus_Action ( Action, PageObjectId, FolderObjectId )
	SELECT 	'Duplicate'
			, PageObjectId
			, FolderObjectId	
			
	FROM
			_Page_Folder_Move_Duplicates

END
		



IF @PageFolderObjectIdExistV2 > 0
BEGIN
	INSERT INTO ##PageFolderObjectIdStatus_Action ( Action, PageObjectId, FolderObjectId )
	SELECT 	'Record Exist'
		, PageObjectId
		, FolderObjectId	
			
	FROM
			_Page_Folder_Move_Exist

END




IF @PageFolderObjectIdUnidentifiedV2 > 0
BEGIN
	INSERT INTO ##PageFolderObjectIdStatus_Action ( Action, PageObjectId, FolderObjectId )
	SELECT 	'Unidentified'
			, PageObjectId
			, FolderObjectId	
			
	FROM
			_Page_Folder_Move_Unidentified

END



IF @PageFolderObjectIdUpdateV2 > 0	
BEGIN
	INSERT INTO ##PageFolderObjectIdStatus_Action ( Action, PageObjectId, FolderObjectId, FolderObjectId_Old )
	SELECT 	'Updated'
			, PageObjectId
			, FolderObjectId		
			, FolderObjectId_Old
	FROM
			_Page_Folder_Move_Update

END




		



-- Builds Final Email
IF OBJECT_ID('tempdb..##PageFolderObjectIdStatus_Results') IS NOT NULL	DROP TABLE ##PageFolderObjectIdStatus_Results
CREATE TABLE ##PageFolderObjectIdStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##PageFolderObjectIdStatus_Results ( Item, Criteria )
SELECT 'Server Name'						, @serverNameV2
UNION ALL
SELECT 'Delivery Email'						, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'					, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit Folder Ids'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitFolderObjectIdV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit Page Ids'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitPageObjectIdV2 , 0)    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records Already Exist'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PageFolderObjectIdExistV2 , 0)				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Unidentified Records'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PageFolderObjectIdUnidentifiedV2 , 0)    	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Needing Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PageFolderObjectIdUpdateV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Successful Updates'					, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'				, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'				, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'Page_MoveToDifferent_Folder_Completed.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action
										, PageObjectId
										, FolderObjectId									
										, FolderObjectId_Old
												
								FROM 
										##PageFolderObjectIdStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##PageFolderObjectIdStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Page Move To Different Folder Update
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
--, @copy_recipients 				= 'tpeterson@mshare.net'
, @copy_recipients 				= 'tpeterson@mshare.net; bluther@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Page Move To Different Folder Completed'
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

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move') AND type = (N'U'))    					DROP TABLE _Page_Folder_Move
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_BadFolderObjectId') AND type = (N'U'))    	DROP TABLE _Page_Folder_Move_BadFolderObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_BadPageObjectId') AND type = (N'U'))    	DROP TABLE _Page_Folder_Move_BadPageObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Duplicates') AND type = (N'U'))    			DROP TABLE _Page_Folder_Move_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Exist') AND type = (N'U'))    				DROP TABLE _Page_Folder_Move_Exist
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Update') AND type = (N'U'))    				DROP TABLE _Page_Folder_Move_Update
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Unidentified') AND type = (N'U'))    		DROP TABLE _Page_Folder_Move_Unidentified
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Folder_Move_Statistics') AND type = (N'U'))    			DROP TABLE _Page_Folder_Move_Statistics
	
	
	
	IF OBJECT_ID('tempdb..##PageFolderObjectIdStatus_Action') IS NOT NULL	DROP TABLE ##PageFolderObjectIdStatus_Action
	IF OBJECT_ID('tempdb..##PageFolderObjectIdStatus_Results') IS NOT NULL	DROP TABLE ##PageFolderObjectIdStatus_Results

	
	PRINT 'Cleanup is complete'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
