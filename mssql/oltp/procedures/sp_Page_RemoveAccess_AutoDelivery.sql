SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_Page_RemoveAccess_AutoDelivery
CREATE Procedure [dbo].[sp_Page_RemoveAccess_AutoDelivery]
		@deliveryEmail			varchar(100)	= NULL
		, @FileName				varchar(100)	= NULL
		
		, @answer				varchar(10)		= NULL		

AS
/**********************************  Page Remove Access  **********************************

		Page Table
			PublicWebAccess = 0  boolean
			
			objectId
			, OrganizationObjectId
			, FolderXbjectId

		PageWebAccess Table
			PageObjectId
			, LocationCategoryTypeObjectId
			
			
		sp_Page_RemoveAccess_AutoDelivery

--******************************************************************************************

SELECT
		ObjectId					AS PageObjectId
		, OrganizationObjectId
		, FolderXbjectId
		, PublicWebAccess

FROM
		Page
WHERE
		ObjectId IN ( 21844, 16251 )

		
		
SELECT
		PageObjectId
		, LocationCategoryTypeObjectId

FROM
		PageWebAccess
WHERE
		PageObjectId IN ( 21844, 16251 )	
		
			
		
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
										
										


--SELECT 	@deliveryEmailCheck, @FileNameCheck, @OrganizationObjectIdCheck, @answerCheck
IF @answerCheck > 0
GOTO PROCESSING									
										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0
	AND
		@answerCheck			= 0			
					
	BEGIN
	
		PRINT 'Removes Access to Page ( Reports ) Update'
		PRINT CHAR(9) + 'Description:  Updates Page Table and Deletes rows in PageWebAccess based on a provided file.'
		PRINT CHAR(9) + CHAR(9) + 'Uploads, processes, and sends a completion notice with what actions taken in a csv file.'
		PRINT CHAR(9) + CHAR(9) + 'Depending on what parameters are given with the Stored Procedure will depend on what is processed.'
		PRINT ''
		PRINT ''
		PRINT 'Execution Methods:'
		PRINT CHAR(9) + 'Stored proc name only                     -   Lists description, Optional criteria, and File setup '
		PRINT CHAR(9) + 'Delivery email address                    -   Sends requestor form for proper file setup. '
		PRINT CHAR(9) + 'Delivery email address & File name        -   Uploads, clean/sanitizes, processes, returns results and a what actions were taken on each row in csv file. '
		PRINT ''
		PRINT ''
		PRINT 'File Setup'
		PRINT CHAR(9) + 'PageObjectId' + CHAR(13) + CHAR(9) + 'OrganizationObjectId'
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor the form for them to generate a file for you to upload and proccess, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_Page_RemoveAccess_AutoDelivery'
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
, @subject						= 'Page Remove Access'
, @body_format					= 'Text'
, @body							=
'
Please fill out and return to DBAs for processing.  Please include your file as an attachment.




File Setup & Contents Example
------------------------------

PageId	OrganizationId
10967       444
16135       444
16199       444





Notes & Comments
-----------------
	Please be aware of proper file setup (order) to ensure successful processing.	
	Change your original spreadsheet to not have any commas.  ie. general formatting for numbers.
	File should be in CSV format.
	Please make sure your file is attached to return email.





Return Email
-------------

sp_Page_RemoveAccess_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @FileName		= ''newly created file name here''
		



		
		
-- Example Below --

sp_Page_RemoveAccess_AutoDelivery
	@DeliveryEmail	= ''tpeterson@mshare.net''
	, @FileName		= ''HertzZPendingDelete_RemoveAccess.csv''
		



		
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

IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access') AND type = (N'U'))    DROP TABLE _Page_Remove_Access
CREATE TABLE _Page_Remove_Access
		(
			PageObjectId				bigint
			, OrganizationObjectId		int	
		)

DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
SET		@FileNameBulkInsertStatement	= 'BULK INSERT _Page_Remove_Access   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'


EXECUTE (@FileNameBulkInsertStatement)



DECLARE	@originalFileSize	int
SET 	@originalFileSize	= ( SELECT COUNT(1)		FROM _Page_Remove_Access	)
			
--SELECT @originalFileSize


DECLARE @nullCount			int
SET		@nullCount			= ( SELECT COUNT(1) 	FROM _Page_Remove_Access	WHERE PageObjectId IS NULL	OR	OrganizationObjectId IS NULL	 )

--SELECT @nullCount


-- Removes NULLs from original fill
IF @nullCount > 0
BEGIN
	DELETE FROM _Page_Remove_Access
	WHERE
			PageObjectId			IS NULL
		OR
			OrganizationObjectId	IS NULL
			
END			


-- Verifies PageObjectId is legit
DECLARE @notLegitPageObjectId	bigint
SET		@notLegitPageObjectId	=

										(
											SELECT
													COUNT(1)
											FROM
													_Page_Remove_Access		t10
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
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_BadPageObjectId') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_BadPageObjectId
	SELECT
			PageObjectId
			, t10.OrganizationObjectId
	INTO _Page_Remove_Access_BadPageObjectId
	FROM
			_Page_Remove_Access								t10
		LEFT JOIN
			Page											t20	WITH (NOLOCK)
					ON t10.PageObjectId = t20.objectId
	WHERE
			t20.objectId IS NULL		

	-- Delete Step
	DELETE	t10
	FROM
			_Page_Remove_Access								t10
		JOIN
			_Page_Remove_Access_BadPageObjectId				t20
					ON t10.PageObjectId = t20.PageObjectId

END


-- Verifies Organization is legit
DECLARE @notLegitOrganizationObjectId		int
SET		@notLegitOrganizationObjectId		= 
											(
												SELECT
														COUNT(1)
												FROM
														_Page_Remove_Access		t10
													LEFT JOIN
														Organization					t20
															ON t10.OrganizationObjectId = t20.ObjectId
												WHERE
														t20.objectId IS NULL
											)

--SELECT @notLegitOrganizationObjectId



-- Non legit OrganizationObjectId; preserved and deleted
IF @notLegitOrganizationObjectId > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_BadOrganizationObjectId') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_BadOrganizationObjectId
	SELECT
			PageObjectId
			, OrganizationObjectId
	INTO _Page_Remove_Access_BadOrganizationObjectId
	FROM
			_Page_Remove_Access		t10
		LEFT JOIN
			Organization					t20
				ON t10.OrganizationObjectId = t20.ObjectId
	WHERE
			t20.objectId IS NULL

	-- Delete Step
	DELETE	t10
	FROM
			_Page_Remove_Access						t10
		JOIN
			_Page_Remove_Access_BadOrganizationObjectId		t20
				ON t10.PageObjectId = t20.PageObjectId
END



-- Verifies PageOrganizationCombination is legit
DECLARE @notLegitPageOrgCombination		int
SET		@notLegitPageOrgCombination		= 
											(
												SELECT
														COUNT(1)
												FROM
														_Page_Remove_Access		t10
													LEFT JOIN
														Page					t20
															ON t10.PageObjectId = t20.ObjectId AND t10.OrganizationObjectId = t20.OrganizationObjectId
												WHERE
														t20.objectId IS NULL
											)

--SELECT @notLegitPageOrgCombination



-- Non legit PageOrganizationCombination; preserved and deleted
IF @notLegitPageOrgCombination > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_BadPageOrganizationCombination') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_BadPageOrganizationCombination
	SELECT
			PageObjectId
			, t10.OrganizationObjectId
	INTO _Page_Remove_Access_BadPageOrganizationCombination
	FROM
			_Page_Remove_Access		t10
		LEFT JOIN
			Page					t20
				ON t10.PageObjectId = t20.ObjectId AND t10.OrganizationObjectId = t20.OrganizationObjectId
	WHERE
			t20.objectId IS NULL

	-- Delete Step
	DELETE	t10
	FROM
			_Page_Remove_Access						t10
		JOIN
			_Page_Remove_Access_BadPageOrganizationCombination		t20
				ON t10.PageObjectId = t20.PageObjectId AND t10.OrganizationObjectId = t20.OrganizationObjectId
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
													_Page_Remove_Access		t10
											GROUP BY 
													PageObjectId
											HAVING	COUNT(1) > 1
										) AS t101
								)

--SELECT @duplicateCheck


-- Removes Duplicates
IF @duplicateCheck	> 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_Duplicates') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_Duplicates
	SELECT
			PageObjectId
			, OrganizationObjectId
	INTO _Page_Remove_Access_Duplicates
	FROM
			_Page_Remove_Access
	WHERE
			PageObjectId IN ( SELECT PageObjectId 	FROM _Page_Remove_Access 	GROUP BY PageObjectId	HAVING COUNT(1) > 1 )
	ORDER BY
			PageObjectId
	

	-- Deletes Duplicates
	DELETE	t10
	FROM
			_Page_Remove_Access				t10
		JOIN
			_Page_Remove_Access_Duplicates	t20
						ON	
								t10.PageObjectId	= t20.PageObjectId
							AND
								t10.OrganizationObjectId	= t20.OrganizationObjectId

								
								
	--THIS IS NOT NECCESSARY FOR THIS SCRIPT	
	---- Puts single version back in original file
	--INSERT INTO _Page_Remove_Access ( PageObjectId, OrganizationObjectId )
	--SELECT
	--		PageObjectId
	--		, OrganizationObjectId
	--FROM
	--		_Page_Remove_Access_Duplicates			


	
	--Sets @duplicateCheck value to true count.
	SET	@duplicateCheck = ( SELECT COUNT(1)	FROM _Page_Remove_Access_Duplicates )
			
END



--Check for updates needed on page table
DECLARE @PageTableNeedingUpdates	int
SET		@PageTableNeedingUpdates	=
										(
											SELECT
													COUNT(1)
											FROM
													_Page_Remove_Access		t10
												JOIN
													Page					t20
														ON t10.PageObjectId = t20.ObjectId 
											WHERE
													t20.PublicWebAccess != 0
												OR
													t20.Hidden 			!= 1
										)
													



-- Page Tables Needing Updates
IF @PageTableNeedingUpdates > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_PageTableUpdate') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_PageTableUpdate
	SELECT
			'PageTableUpdate'								AS TableAndAction
			, PageObjectId
			, t10.OrganizationObjectId
			, t20.FolderObjectId
			, t20.PublicWebAccess							AS PublicWebAccess_Old
			, t20.Hidden									AS Hidden_Old
	INTO _Page_Remove_Access_PageTableUpdate
	FROM
			_Page_Remove_Access								t10
		JOIN
			Page											t20	WITH (NOLOCK)
				ON t10.PageObjectId = t20.ObjectId
	WHERE
			t20.PublicWebAccess != 0
		OR
			t20.Hidden			!= 1
		

		
		
	-- Delete Step; Delayed this step 
	--DELETE	t10
	--FROM
	--		_Page_Remove_Access								t10
	--	JOIN
	--		_Page_Remove_Access_PageTableUpdate				t20
	--				ON t10.PageObjectId = t20.PageObjectId

END




--Check for Deletes needed on PageWebAccess table
DECLARE @PageWebAccessTableNeedingDeletes	int
SET		@PageWebAccessTableNeedingDeletes	=
												(
													SELECT
															COUNT(1)
													FROM
															_Page_Remove_Access		t10
														JOIN
															PageWebAccess			t20
																ON t10.PageObjectId = t20.PageObjectId 
												)
													



-- PageWebAccess Tables Needing Updates
IF @PageWebAccessTableNeedingDeletes > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_PageWebAccessTableDeletes') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_PageWebAccessTableDeletes
	SELECT
			'PageWebAccessTableDelete'						AS TableAndAction
			, t10.PageObjectId
			, t20.LocationCategoryTypeObjectId
	INTO _Page_Remove_Access_PageWebAccessTableDeletes
	FROM
			_Page_Remove_Access								t10
		JOIN
			PageWebAccess									t20	WITH (NOLOCK)
				ON t10.PageObjectId = t20.PageObjectId

				
				
	-- Delete Step; Delayed this step 
	--DELETE	t10
	--FROM
	--		_Page_Remove_Access								t10
	--	JOIN
	--		_Page_Remove_Access_PageWebAccessTableDeletes	t20
	--				ON t10.PageObjectId = t20.PageObjectId

END




--Delayed Deletes; this is not a normal step
	-- Delete Step
	DELETE	t10
	FROM
			_Page_Remove_Access								t10
		JOIN
			_Page_Remove_Access_PageTableUpdate				t20
					ON t10.PageObjectId = t20.PageObjectId


	-- Delete Step
	DELETE	t10
	FROM
			_Page_Remove_Access								t10
		JOIN
			_Page_Remove_Access_PageWebAccessTableDeletes	t20
					ON t10.PageObjectId = t20.PageObjectId




--No action taken on either table, Check
DECLARE @ChecknoActionTaken					int
SET		@ChecknoActionTaken					=
												(
													SELECT
															COUNT(1)
													FROM
															_Page_Remove_Access		t10
												)
													



-- PreserverNo action taken on either table
IF @CheckNoActionTaken > 0
BEGIN
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_NoActionTaken') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_NoActionTaken
	SELECT
			'NoActionTaken'									AS TableAndAction
			, t10.PageObjectId
			, t10.OrganizationObjectId
	INTO _Page_Remove_Access_NoActionTaken
	FROM
			_Page_Remove_Access								t10

	-- Delete Step
	DELETE	t10
	FROM
			_Page_Remove_Access								t10
		JOIN
			_Page_Remove_Access_NoActionTaken				t20
					ON t10.PageObjectId = t20.PageObjectId

END


-- Removes original table so no accidental things happen
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access') AND type = (N'U'))    DROP TABLE _Page_Remove_Access


--Builds Statistics Table
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_Statistics') AND type = (N'U'))    DROP TABLE _Page_Remove_Access_Statistics
CREATE TABLE _Page_Remove_Access_Statistics
	(
		DeliveryEmail											varchar(100)
		, inputFileName											varchar(100)
		, serverName											varchar(25)
		, originalCount											int
		, nullCount												int
		, notLegitPageObjectId									int
		, notLegitOrganizationObjectId							int
		, notLegitPageOrgCombination							int
		, duplicateCheck										int
		, NoActionTaken											int
		, PageTableNeedingUpdates								int
		, PageWebAccessTableNeedingDeletes						int
		, processingStart										dateTime
		, processingComplete									dateTime

	)		

INSERT INTO _Page_Remove_Access_Statistics ( DeliveryEmail, inputFileName, serverName, originalCount, nullCount, notLegitPageObjectId, notLegitOrganizationObjectId, notLegitPageOrgCombination, duplicateCheck, NoActionTaken, PageTableNeedingUpdates, PageWebAccessTableNeedingDeletes )	
SELECT @deliveryEmail, @FileName, @@SERVERNAME, @originalFileSize, @nullCount, @notLegitPageObjectId, @notLegitOrganizationObjectId, @notLegitPageOrgCombination, @duplicateCheck, @CheckNoActionTaken, @PageTableNeedingUpdates, @PageWebAccessTableNeedingDeletes




-- Results Print Out
PRINT 'Page Remove Access Statistics'
PRINT ''
PRINT 'Original CSV Row Count                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@originalFileSize   				AS money)), 1), '.00', '')
PRINT 'NULL Values Found                        :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@nullCount   						AS money)), 1), '.00', '')
PRINT 'Non Legit Page Ids                       :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitPageObjectId				AS money)), 1), '.00', '')
PRINT 'Non Legit Org  Ids                     	:' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitOrganizationObjectId		AS money)), 1), '.00', '')
PRINT 'Non Legit PageOrg Combination            :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@notLegitPageOrgCombination		AS money)), 1), '.00', '')
PRINT 'Duplicate Values Found                   :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@duplicateCheck   					AS money)), 1), '.00', '')
PRINT 'Records With No Action Taken             :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@CheckNoActionTaken   		        AS money)), 1), '.00', '')
PRINT 'Page Table Needing Update                :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@PageTableNeedingUpdates   		    AS money)), 1), '.00', '')
PRINT 'PageWebAccess Table Deletes              :' + CHAR(9) + REPLACE(CONVERT(varchar(20), (CAST(    		@PageWebAccessTableNeedingDeletes	AS money)), 1), '.00', '')

PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT ''
PRINT '*****  If these statistics are acceptable, please execute the following  *****'
PRINT CHAR(9) +  'sp_Page_RemoveAccess_AutoDelivery	@answer = ''EXECUTE'''
PRINT ''
PRINT ''
PRINT '*****  To terminate process  *****'
PRINT  CHAR(9) + 'sp_Page_RemoveAccess_AutoDelivery	@answer = ''terminate'''

RETURN

END


--/*************************  Cursor Section, Please be careful!  *************************/
PROCESSING:

SET NOCOUNT ON


IF @answerCheck = 1
BEGIN
	
	DECLARE @PageTableUpdateCheck						int
	SET		@PageTableUpdateCheck						= ( SELECT PageTableNeedingUpdates				FROM _Page_Remove_Access_Statistics )

	DECLARE @PageWebAccessTableNeedingDeletesCheck		int
	SET		@PageWebAccessTableNeedingDeletesCheck		= ( SELECT PageWebAccessTableNeedingDeletes		FROM _Page_Remove_Access_Statistics )
	


	UPDATE	_Page_Remove_Access_Statistics
	SET		processingStart = GETDATE()
	
	
	--If statements for Cursors Here
	IF @PageTableUpdateCheck > 0
	BEGIN



	
		PRINT 'Updating ' + CAST(@PageTableUpdateCheck AS varchar) + ' records'
	


		/**************  Page Table PublicWebAccess Update  **************/

		DECLARE @count int, @PageObjectId int

		SET @count = 0

		DECLARE mycursor CURSOR for
		SELECT PageObjectId FROM _Page_Remove_Access_PageTableUpdate

		OPEN mycursor
		FETCH next FROM mycursor INTO @PageObjectId

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@count as varchar)+', '+cast(@PageObjectId as varchar)+', '+cast( '0' as varchar)+', '+cast( '1' as varchar)


		----******************* W A R N I N G***************************

		
		UPDATE 	Page WITH (ROWLOCK)
		SET 	PublicWebAccess = 0
				, Hidden		= 1
		WHERE 	objectId 		= @PageObjectId
		

		----***********************************************************

		SET @count = @count+1
		FETCH next FROM mycursor INTO @PageObjectId

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
		SET		@successfulUpdates		= ( SELECT COUNT(1)		FROM _Page_Remove_Access_PageTableUpdate	t10		JOIN Page t20	WITH (NOLOCK) 	ON t10.PageObjectId = t20.objectId AND ( t10.PublicWebAccess_Old != t20.PublicWebAccess OR t10.Hidden_Old != t20.Hidden ) )
		
		PRINT CHAR(9) + 'Requested Updates: ' + CAST(@PageTableUpdateCheck AS varchar) + ' Successful: ' + CAST(@successfulUpdates as varchar)
		PRINT ''
		PRINT ''
	
		
	END




	--If statements for Cursors Here
	IF @PageWebAccessTableNeedingDeletesCheck > 0
	BEGIN



	
		PRINT 'Deleting ' + CAST(@PageWebAccessTableNeedingDeletesCheck AS varchar) + ' records'
	


		/**************  Page Table PublicWebAccess Update  **************/

		DECLARE @countV2 int, @PageObjectIdV2 int, @LocationCategoryTypeObjectIdV2 int

		SET @countV2 = 0

		DECLARE mycursor CURSOR for
		SELECT PageObjectId, LocationCategoryTypeObjectId 	FROM _Page_Remove_Access_PageWebAccessTableDeletes

		OPEN mycursor
		FETCH next FROM mycursor INTO @PageObjectIdV2, @LocationCategoryTypeObjectIdV2

		WHILE @@FETCH_Status = 0
		BEGIN

			  
		PRINT cast(@countV2 as varchar)+', '+cast(@PageObjectIdV2 as varchar)+', '+cast( @LocationCategoryTypeObjectIdV2 as varchar)


		----******************* W A R N I N G***************************

		
		DELETE 	PageWebAccess WITH (ROWLOCK)
		WHERE 	
					PageObjectId 					= @PageObjectIdV2
				AND
					LocationCategoryTypeObjectId 	= @LocationCategoryTypeObjectIdV2
		

		----***********************************************************

		SET @countV2 = @countV2 + 1
		FETCH next FROM mycursor INTO @PageObjectIdV2, @LocationCategoryTypeObjectIdV2

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT cast(@countV2 as varchar)+' Records Processed'	

		/**************************************************************************************************/


		
		
		PRINT ''			
		PRINT 'Delete Portion Complete'
		PRINT ''
		PRINT ''
		PRINT 'Verifying Successful Deletes'
		
		DECLARE @SuccessfulDeletesCount		int
		SET 	@SuccessfulDeletesCount 	= ( SELECT COUNT(1) FROM _Page_Remove_Access_PageWebAccessTableDeletes	t10		JOIN PageWebAccess t20	WITH (NOLOCK) 	ON t10.PageObjectId = t20.PageObjectId AND t10.LocationCategoryTypeObjectId = t20.LocationCategoryTypeObjectId )
				
		DECLARE @successfulDeletes			int
		SET		@successfulDeletes			= ( SELECT @PageWebAccessTableNeedingDeletesCheck - @SuccessfulDeletesCount )
		
		PRINT CHAR(9) + 'Requested Deletes: ' + CAST(@PageWebAccessTableNeedingDeletesCheck AS varchar) + ' Successful: ' + CAST(@successfulDeletes as varchar)
		PRINT ''
		PRINT ''
	
		
	END


	
	
	UPDATE	_Page_Remove_Access_Statistics
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
IF @PageTableUpdateCheck > 0	OR 	@PageWebAccessTableNeedingDeletesCheck > 0
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE  

		@DeliveryEmailV2										varchar(100)
		, @inputFileNameV2										varchar(100)
		, @serverNameV2											varchar(25)
		, @originalCountV2										int
		, @nullCountV2											int
		, @notLegitPageObjectIdV2								int
		, @notLegitOrganizationObjectIdV2						int
		, @notLegitPageOrgCombinationV2							int
		, @duplicateCheckV2										int
		, @NoActionTakenV2										int
		, @PageTableNeedingUpdatesv2							int
		, @PageWebAccessTableNeedingDeletesV2					int
		, @processingStartV2									dateTime
		, @processingCompleteV2									dateTime
		, @ProcessingDurationV2									varchar(25)


		, @Minutes												varchar(3)
		, @Seconds												varchar(3)		
				
		

SET @DeliveryEmailV2					= ( SELECT deliveryEmail						FROM _Page_Remove_Access_Statistics )
SET @inputFileNameV2					= ( SELECT inputFileName						FROM _Page_Remove_Access_Statistics )
SET @serverNameV2						= ( SELECT serverName							FROM _Page_Remove_Access_Statistics )
SET @originalCountV2					= ( SELECT originalCount						FROM _Page_Remove_Access_Statistics )
SET @nullCountV2						= ( SELECT nullCount							FROM _Page_Remove_Access_Statistics )
SET @notLegitPageObjectIdV2				= ( SELECT notLegitPageObjectId					FROM _Page_Remove_Access_Statistics )
SET @notLegitOrganizationObjectIdV2		= ( SELECT notLegitOrganizationObjectId			FROM _Page_Remove_Access_Statistics )
SET @notLegitPageOrgCombinationV2		= ( SELECT notLegitPageOrgCombination			FROM _Page_Remove_Access_Statistics )
SET @duplicateCheckV2					= ( SELECT duplicateCheck						FROM _Page_Remove_Access_Statistics )
SET @NoActionTakenV2					= ( SELECT NoActionTaken						FROM _Page_Remove_Access_Statistics )
SET @PageTableNeedingUpdatesV2			= ( SELECT PageTableNeedingUpdates				FROM _Page_Remove_Access_Statistics )
SET @PageWebAccessTableNeedingDeletesV2	= ( SELECT PageWebAccessTableNeedingDeletes		FROM _Page_Remove_Access_Statistics )

SET @ProcessingStartV2								= ( SELECT ProcessingStart									FROM _Page_Remove_Access_Statistics )
SET @ProcessingCompleteV2							= ( SELECT ProcessingComplete								FROM _Page_Remove_Access_Statistics )
		
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


IF OBJECT_ID('tempdb..##PageRemoveAccessStatus_Action') IS NOT NULL	DROP TABLE ##PageRemoveAccessStatus_Action
CREATE TABLE ##PageRemoveAccessStatus_Action
	(
		Action							varchar(50)
		, PageObjectId					bigInt
		, OrganizationObjectId			int
		, FolderObjectId				int
		, PublicWebAccess_Old			int
		, Hidden_Old					int
		, LocationCategoryTypeObjectId	int
	)




IF @notLegitPageObjectIdV2 > 0
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, OrganizationObjectId )
	SELECT 	'NonLegit PageObjectId'
		, PageObjectId
		, OrganizationObjectId	
			
	FROM
			_Page_Remove_Access_BadPageObjectId
END


IF @notLegitOrganizationObjectIdV2 > 0
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, OrganizationObjectId )
	SELECT 	'NonLegit PageObjectId'
		, PageObjectId
		, OrganizationObjectId	
			
	FROM
			_Page_Remove_Access_BadOrganizationObjectId
END



IF @notLegitPageOrgCombinationV2 > 0
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, OrganizationObjectId )
	SELECT 	'NonLegit PageOrgCombination'
		, PageObjectId
		, OrganizationObjectId	
			
	FROM
			_Page_Remove_Access_BadPageOrganizationCombination
END







IF @duplicateCheckV2 > 0
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, OrganizationObjectId )
	SELECT 	'Duplicate'
			, PageObjectId
			, OrganizationObjectId	
			
	FROM
			_Page_Remove_Access_Duplicates

END
		



IF @NoActionTakenV2 > 0
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, OrganizationObjectId )
	SELECT 	
			TableAndAction
			, PageObjectId
			, OrganizationObjectId	
			
	FROM
			_Page_Remove_Access_NoActionTaken

END




IF @PageTableNeedingUpdatesV2 > 0
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, OrganizationObjectId, FolderObjectId, PublicWebAccess_Old, Hidden_Old )
	SELECT 	
			TableAndAction
			, PageObjectId
			, OrganizationObjectId
			, FolderObjectId
			, PublicWebAccess_Old
			, Hidden_Old
			
	FROM
			_Page_Remove_Access_PageTableUpdate

END



IF @PageWebAccessTableNeedingDeletesV2 > 0	
BEGIN
	INSERT INTO ##PageRemoveAccessStatus_Action ( Action, PageObjectId, LocationCategoryTypeObjectId )
	SELECT 	
			TableAndAction
			, PageObjectId
			, LocationCategoryTypeObjectId
			
	FROM
			_Page_Remove_Access_PageWebAccessTableDeletes

END








-- Builds Final Email
IF OBJECT_ID('tempdb..##PageRemoveAccessStatus_Results') IS NOT NULL	DROP TABLE ##PageRemoveAccessStatus_Results
CREATE TABLE ##PageRemoveAccessStatus_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##PageRemoveAccessStatus_Results ( Item, Criteria )
SELECT 'Server Name'							, @serverNameV2
UNION ALL
SELECT 'Delivery Email'							, @deliveryEmailV2
UNION ALL	
SELECT 'Input File Name'						, @inputFileNameV2
UNION ALL
SELECT 'CSV File Row Count'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   						AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Null Count'								, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @nullCountV2 , 0)    							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit Page Ids'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitPageObjectIdV2 , 0)    				AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit Org  Ids'						, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitOrganizationObjectIdV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'NonLegit PageOrg Combination  Ids'		, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @notLegitPageOrgCombinationV2 , 0)    		AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Duplicates'								, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @duplicateCheckV2 , 0)    					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Records With No Action Taken'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @NoActionTakenV2 , 0)							AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Page Table Needing Updates'				, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PageTableNeedingUpdatesV2 , 0)   			AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Page Table Successful Updates'			, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulUpdates , 0)   					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'PageWebAccess Table Needing Deletes'	, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @PageWebAccessTableNeedingDeletesV2 , 0)   	AS money)), 1), '.00', '')	
UNION ALL
SELECT 'PageWebAccess Table Successful Deletes'	, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @successfulDeletes , 0)   					AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'					, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'					, @ProcessingDurationV2
		

		
		
		

DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'Page_Remove_Accecss_Completed.csv' ) 


		
-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										Action						
										, PageObjectId				
										, OrganizationObjectId		
										, FolderObjectId			
										, PublicWebAccess_Old
										, Hidden_Old
										, LocationCategoryTypeObjectId
												
								FROM 
										##PageRemoveAccessStatus_Action

							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##PageRemoveAccessStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Page Remove Access
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
, @subject						= 'Page Remove Access Completed'
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
	
	



--Clean Up Tables
CLEANUP:

	PRINT 'Cleaning up temp tables'


	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access') AND type = (N'U'))									DROP TABLE _Page_Remove_Access
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_BadPageObjectId') AND type = (N'U'))					DROP TABLE _Page_Remove_Access_BadPageObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_BadOrganizationObjectId') AND type = (N'U'))			DROP TABLE _Page_Remove_Access_BadOrganizationObjectId
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_BadPageOrganizationCombination') AND type = (N'U'))   DROP TABLE _Page_Remove_Access_BadPageOrganizationCombination
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_Duplicates') AND type = (N'U'))						DROP TABLE _Page_Remove_Access_Duplicates
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_NoActionTaken') AND type = (N'U'))					DROP TABLE _Page_Remove_Access_NoActionTaken
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_PageTableUpdate') AND type = (N'U'))					DROP TABLE _Page_Remove_Access_PageTableUpdate
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_PageWebAccessTableDeletes') AND type = (N'U'))		DROP TABLE _Page_Remove_Access_PageWebAccessTableDeletes

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_Page_Remove_Access_Statistics') AND type = (N'U'))						DROP TABLE _Page_Remove_Access_Statistics



	IF OBJECT_ID('tempdb..##PageRemoveAccessStatus_Action') IS NOT NULL		DROP TABLE ##PageRemoveAccessStatus_Action
	IF OBJECT_ID('tempdb..##PageRemoveAccessStatus_Results') IS NOT NULL	DROP TABLE ##PageRemoveAccessStatus_Results

	
	PRINT 'Cleanup is complete'


	
	
--Remove These
/*

SELECT * FROM _Page_Remove_Access_BadPageObjectId
SELECT * FROM _Page_Remove_Access_BadOrganizationObjectId
SELECT * FROM _Page_Remove_Access_BadPageOrganizationCombination
SELECT * FROM _Page_Remove_Access_Duplicates
SELECT * FROM _Page_Remove_Access_NoActionTaken
SELECT * FROM _Page_Remove_Access_PageTableUpdate
SELECT * FROM _Page_Remove_Access_PageWebAccessTableDeletes


*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
