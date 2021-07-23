SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[PageLogEntryTables_DataRemoval_vReplicatedStoredProc]
	@DisplayInfo					int = 1
	, @GenerateCountsOnly			int = 1	
	, @PurgeDatesOlderThanDays		int = 180
	, @BatchSize					int = 500
	
	, @ShowChecks					int = 0
	, @SendNotification				int = 0
	

AS
/**************** Trimming Page Log Entry Related Tables  ****************


	Comments

		To be executed on OLTP
	
		Trims Page Log Entry related tables, based 
		on pageLogEntry.creationDateTime
		
			PageLogEntry
			PageLogEntryUserAccount
			PageLogEntryOrganizationalUnit
						
		Foreign Keys require data in PageLogEntry to be the last table 
		where data is deleted.  The other two must have their data removed
		first.

		
	History
		02.09.2012	Tad Peterson
			-- created
		
		09.15.2014	Tad Peterson
			-- converted it be scalable

		10.02.2015  In-Kap Bang
		    -- removed "Order by" clause when populating #PageLogEntry temp table
			-- modify e-mail recipient to dba@inmoment.com


**************************************************************************/
SET NOCOUNT ON

-- For use with RAISERROR
DECLARE @message	nvarchar(200)



-- Processing Checks
DECLARE @BatchSizeCheck						int
DECLARE @PurgeDatesOlderThanDaysCheck		int
DECLARE @GenerateCountsOnlyCheck			int
DECLARE @ShowChecksCheck					int
DECLARE @DisplayInfoCheck					int
DECLARE @SendNotificationCheck				int


SET @PurgeDatesOlderThanDaysCheck			= CASE WHEN @PurgeDatesOlderThanDays	> 0		THEN 1							ELSE 0		END
SET	@BatchSizeCheck							= CASE WHEN @BatchSize 					> 0		THEN 1							ELSE 0		END
SET @GenerateCountsOnlyCheck				= CASE WHEN @GenerateCountsOnly			= 0		THEN 0							ELSE 1		END
SET @ShowChecksCheck						= CASE WHEN @ShowChecks					= 1		THEN 1							ELSE 0		END
SET @DisplayInfoCheck						= CASE WHEN @DisplayInfo				= 1		THEN 1							ELSE 0		END
SET @SendNotificationCheck					= CASE WHEN @SendNotification			= 1		THEN 1							ELSE 0		END


-- DateModification
DECLARE @StartDate		DateTime
SET 	@StartDate		= DATEADD( DAY, -( @PurgeDatesOlderThanDays ), CAST( FLOOR( CAST( getDate() as float )) AS dateTime ) )




-- Table Counts Variables
DECLARE @PageLogEntryCount							Int
DECLARE @PageLogEntryUserAccountCount				Int
DECLARE @PageLogEntryOrganizationalUnitCount		Int



-- Batching Variables
DECLARE @PLE_MinCount		int
DECLARE @PLE_MaxTotal		int
DECLARE @PLE_CurrentTotal	int
DECLARE @PLEOU_Total		int
DECLARE @PLEUA_Total		int
DECLARE @PLE_Total			int










-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC dbo.PageLogEntryTables_DataRemoval_vReplicatedStoredProc'
	PRINT N'	@DisplayInfo			   = 0'
	PRINT N'	, @GenerateCountsOnly	   = 1'	
	PRINT N'	, @PurgeDatesOlderThanDays = 180'
	PRINT N'	, @BatchSize			   = 500'
	PRINT N' '
	PRINT N'    , @ShowChecks			   = 1'
	PRINT N'    , @SendNotification		   = 0'


	RETURN

	
END



















-- Enables input checking
IF @ShowChecksCheck = 1
BEGIN
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  



	SELECT
				
			@ShowChecksCheck					AS ShowChecksCheck
			, @ShowChecks						AS ShowChecks
			
			, @GenerateCountsOnlyCheck			AS GenerateCountsOnlyCheck
			, @GenerateCountsOnly				AS GenerateCountsOnly
			
			, @PurgeDatesOlderThanDaysCheck		AS PurgeDatesOlderThanDaysCheck
			, @PurgeDatesOlderThanDays			AS PurgeDatesOlderThanDays

			, @BatchSizeCheck					AS [BatchSizeCheck]			
			, @BatchSize						AS [BatchSize]
			
			, @StartDate						AS StartDate

			, @SendNotificationCheck			AS SendNotificationCheck
			, @SendNotification					AS SendNotification
			
			
END





IF @GenerateCountsOnlyCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Generating counts only'
	RAISERROR (@message,0,1) with NOWAIT  


	-- PageLogEntry table counts
	SET		@PageLogEntryCount							= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		pageLogEntry
																WHERE
																		CreationDateTime < @StartDate
															)


													
													
													
	-- PageLogEntryUserAccount table counts
	SET		@PageLogEntryUserAccountCount				= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		PageLogEntryUserAccount
																WHERE
																		PageLogEntryObjectId IN 
																									(
																										SELECT
																												ObjectId
																										FROM
																												PageLogEntry
																										WHERE
																												CreationDateTime < @StartDate
																									)
															)


													
													
													
	-- PageLogEntryOrganizationalUnit table counts
	SET		@PageLogEntryOrganizationalUnitCount		= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		PageLogEntryOrganizationalUnit
																WHERE
																		PageLogEntryObjectId IN 
																									(
																										SELECT
																												ObjectId
																										FROM
																												PageLogEntry
																										WHERE
																												CreationDateTime < @StartDate
																									)
														)





	-- Building Result Set
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'Table Counts                      '
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'PageLogEntry                      ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 

	SET @message = 'PageLogEntryUserAccount           ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryUserAccountCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 

	SET @message = 'PageLogEntryOrganizationalUnit    ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryOrganizationalUnitCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 

	
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Total Counts                      ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryCount + @PageLogEntryUserAccountCount + @PageLogEntryOrganizationalUnitCount     as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 
	


	IF @SendNotificationCheck = 1
	BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  
	
	SET @message = 'Moving to send notification section'
	RAISERROR (@message,0,1) with NOWAIT
	
	GOTO SEND_NOTIFICATION
	
	END 
	
	
	
	
	
	
	

	RETURN

END
















IF @PurgeDatesOlderThanDaysCheck = 1 AND @GenerateCountsOnly = 0
BEGIN

	SET @message = 'Purging Data'
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  
	

-- Creates working table
IF OBJECT_ID('tempdb..#PageLogEntry') IS NOT NULL						DROP TABLE #PageLogEntry		
CREATE TABLE #PageLogEntry
	(
		RowId						int Identity ( 1, 1 )
		, PageLogEntryObjectId		int
		
		, CONSTRAINT PK_PageLogEntry_Removal PRIMARY KEY CLUSTERED
			( RowId ASC ) WITH ( FILLFACTOR = 100 ) 
		
	)





-- Set the max total for PageLogEntry records to be removed
SET @PLE_MaxTotal			= 
								(
									SELECT
											COUNT(1)
									FROM
											pageLogEntry
									WHERE
											CreationDateTime < @StartDate
								)



-- PLE Working Batch
INSERT INTO #PageLogEntry ( PageLogEntryObjectId )
SELECT
		TOP ( @BatchSize )
		ObjectId
FROM
		PageLogEntry
WHERE
		CreationDateTime < @StartDate
--ORDER BY
--		ObjectId ASC	
	
	

	
WHILE @PLE_MaxTotal > 0
BEGIN

SET @message = ' '
RAISERROR (@message,0,1) with NOWAIT  


SET @message = 'PLE max total records ' + CAST( @PLE_MaxTotal as varchar )
RAISERROR (@message,0,1) with NOWAIT  

	
	
		-- Batch delete PageLogEntryOrganizationalUnit
		SET @PLEOU_Total = 
							(
								SELECT
										COUNT(1)
								FROM
										PageLogEntryOrganizationalUnit
								WHERE
										PageLogEntryObjectId IN 
																	(
																		SELECT
																				PageLogEntryObjectId
																		FROM
																				#PageLogEntry
																	)
							)
		
		
		
		
		
		
		WHILE @PLEOU_Total > 0
		BEGIN
		
		

				-- Deletes PageLogEntryOrganizationalUnit in batches
				SET @message = 'PLEOU remaining in this batch ' + CAST( @PLEOU_Total as varchar )
				RAISERROR (@message,0,1) with NOWAIT  
				
				
				/*********  Warning  *********/
				DELETE 
						TOP ( @BatchSize )
				FROM	
						PageLogEntryOrganizationalUnit WITH ( ROWLOCK )	
				WHERE
						PageLogEntryObjectId IN ( SELECT PageLogEntryObjectId FROM #PageLogEntry )


						
				-- Re-calculate Totals
				SET @PLEOU_Total = 
									(
										SELECT
												COUNT(1)
										FROM
												PageLogEntryOrganizationalUnit
										WHERE
												PageLogEntryObjectId IN 
																			(
																				SELECT
																						PageLogEntryObjectId
																				FROM
																						#PageLogEntry
																			)
									)


	
	
		END






		
		-- Batch delete PageLogEntryUserAccount
		SET @PLEUA_Total = 
							(
								SELECT
										COUNT(1)
								FROM
										PageLogEntryUserAccount
								WHERE
										PageLogEntryObjectId IN 
																	(
																		SELECT
																				PageLogEntryObjectId
																		FROM
																				#PageLogEntry
																	)
							)
		
		
		
		
		
		
		WHILE @PLEUA_Total > 0
		BEGIN
		
		

				-- Deletes PageLogEntryUserAccount in batches
				SET @message = 'PLEUA remaining in this batch ' + CAST( @PLEUA_Total as varchar )
				RAISERROR (@message,0,1) with NOWAIT  
				
				
				/*********  Warning  *********/
				DELETE 
						TOP ( @BatchSize )
				FROM	
						PageLogEntryUserAccount WITH ( ROWLOCK )	
				WHERE
						PageLogEntryObjectId IN ( SELECT PageLogEntryObjectId FROM #PageLogEntry )


						
				-- Re-calculate Totals
				SET @PLEUA_Total = 
									(
										SELECT
												COUNT(1)
										FROM
												PageLogEntryUserAccount
										WHERE
												PageLogEntryObjectId IN 
																			(
																				SELECT
																						PageLogEntryObjectId
																				FROM
																						#PageLogEntry
																			)
									)

		END
		





		
		
		
		
	
		-- Batch delete PageLogEntry
		SET @PLE_Total = 
							(
								SELECT
										COUNT(1)
								FROM
										PageLogEntry
								WHERE
										ObjectId IN 
																	(
																		SELECT
																				PageLogEntryObjectId
																		FROM
																				#PageLogEntry
																	)
							)
		
		
		
		
		
		
		WHILE @PLE_Total > 0
		BEGIN
		
		

				-- Deletes PageLogEntry in batches
				SET @message = 'PLE remaining in this batch ' + CAST( @PLE_Total as varchar )
				RAISERROR (@message,0,1) with NOWAIT  
				
				
				/*********  Warning  *********/
				DELETE 
						TOP ( @BatchSize )
				FROM	
						PageLogEntry WITH ( ROWLOCK )	
				WHERE
						ObjectId IN ( SELECT PageLogEntryObjectId FROM #PageLogEntry )


						
				-- Re-calculate Totals
				SET @PLE_Total = 
									(
										SELECT
												COUNT(1)
										FROM
												PageLogEntry
										WHERE
												ObjectId IN 
																			(
																				SELECT
																						PageLogEntryObjectId
																				FROM
																						#PageLogEntry
																			)
									)


		END
	
	
	



-- Truncates the working PLE table
TRUNCATE TABLE #PageLogEntry


-- Re-calculate Totals
SET @PLE_MaxTotal			= 
								(
									SELECT
											COUNT(1)
									FROM
											pageLogEntry
									WHERE
											CreationDateTime < @StartDate
								)



-- PLE Working Batch
INSERT INTO #PageLogEntry ( PageLogEntryObjectId )
SELECT
		TOP ( @BatchSize )
		ObjectId
FROM
		PageLogEntry
WHERE
		CreationDateTime < @StartDate
--ORDER BY
--		ObjectId ASC	



	
END	
	

	
	
-- Testing
--SELECT *	FROM #PageLogEntry ORDER BY RowId


	
	
	
END



-- Post Processing Table Counts
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Generating Final Counts'
	RAISERROR (@message,0,1) with NOWAIT  


	-- PageLogEntry table counts
	SET	@PageLogEntryCount							= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		pageLogEntry
																WHERE
																		CreationDateTime < @StartDate
															)


													
													
													
	-- PageLogEntryUserAccount table counts
	SET	@PageLogEntryUserAccountCount				= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		PageLogEntryUserAccount
																WHERE
																		PageLogEntryObjectId IN 
																									(
																										SELECT
																												ObjectId
																										FROM
																												PageLogEntry
																										WHERE
																												CreationDateTime < @StartDate
																									)
															)


													
													
													
	-- PageLogEntryOrganizationalUnit table counts
	SET	@PageLogEntryOrganizationalUnitCount		= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		PageLogEntryOrganizationalUnit
																WHERE
																		PageLogEntryObjectId IN 
																									(
																										SELECT
																												ObjectId
																										FROM
																												PageLogEntry
																										WHERE
																												CreationDateTime < @StartDate
																									)
															)





	-- Building Result Set
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'Table Counts                      '
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'PageLogEntry                      ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 

	SET @message = 'PageLogEntryUserAccount           ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryUserAccountCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 

	SET @message = 'PageLogEntryOrganizationalUnit    ' + REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryOrganizationalUnitCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 



END




SEND_NOTIFICATION:

IF @GenerateCountsOnlyCheck = 1 AND @SendNotification = 1 AND @@SERVERNAME = 'Doctor'
BEGIN

	DECLARE @pleUA				varchar(20)
	DECLARE @pleOU				varchar(20)
	DECLARE @ple				varchar(20)
	DECLARE @CombinedTotals		Varchar(20)
	
	
	SET @pleUA 	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryUserAccountCount   			as money  )), 1), '.00', '') )
	SET @pleOU 	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryOrganizationalUnitCount   	as money  )), 1), '.00', '') )
	SET @ple 	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryCount   					as money  )), 1), '.00', '') )		

	SET @CombinedTotals = ( SELECT REPLACE(CONVERT(varchar(20), (CAST( @PageLogEntryUserAccountCount + @PageLogEntryOrganizationalUnitCount +@PageLogEntryCount   					as money  )), 1), '.00', '') )	
			
	DECLARE @xml01 		NVARCHAR(MAX)
	DECLARE @body01 	NVARCHAR(MAX)


	SET @xml01 = CAST(( 


	SELECT	@pleUA		AS 'td',''
			, @pleOU	AS 'td',''
			, @ple		AS 'td'


	FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


	SET @body01 =
											'<html><body><H3>
	Delete Counts For Page Log Entry Related Tables	
											</H3><table border = 1><tr><th>
												
	Page Log Entry User Account				</th><th>
	Page Log Entry Organizational Unit		</th><th>								
	Page Log Entry							</th></tr>								
	'    

	 
	SET @body01 = @body01 + @xml01 +'</table></body></html>'


	--
	DECLARE @bodyActionEmail01		varchar(max)
	DECLARE	@bodyExplain01			varchar(max)

	SET		@bodyActionEmail01	=	'Rows Deleting Tonight Night = ' + @CombinedTotals
	SET		@bodyExplain01		=	'Scheduled Job will be deleting this many rows tonight on OLTP'



	--Sends email regarding details of issue
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name		= 'DB Maintenance & Jobs'
		, @body 			= @body01
		, @body_format 		= 'HTML'
		, @recipients 		= 'dba@inmoment.com; '-- bluther@InMoment.com; kmciff@InMoment.com' -- Tad; Bob
		, @copy_recipients	= ''
		, @subject 			= @bodyActionEmail01 ;
			

		


END



-- Clean up
IF OBJECT_ID('tempdb..#PageLogEntry') IS NOT NULL						DROP TABLE #PageLogEntry		
IF OBJECT_ID('tempdb..#PageLogEntryUserAccount') IS NOT NULL			DROP TABLE #PageLogEntryUserAccount		
IF OBJECT_ID('tempdb..#PageLogEntryOrganizationalUnit') IS NOT NULL		DROP TABLE #PageLogEntryOrganizationalUnit		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
