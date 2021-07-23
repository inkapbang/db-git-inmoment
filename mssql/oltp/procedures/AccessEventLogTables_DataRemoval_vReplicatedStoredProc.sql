SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.AccessEventLogTables_DataRemoval_vReplicatedStoredProc
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
	
		Trims Access Event Log related tables, based 
		on AccessEventLog.TimeStamp
		
		BatchSize sweet spot is 2500 
		
			AccessEventLog
						
		
	History
		01.31.2012	Tad Peterson
			-- created
		
		09.22.2014	Tad Peterson
			-- converted it be scalable
		
		11.03.2014	Tad Peterson
			-- removed PK constraint


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
DECLARE @AccessEventLogCount						Int



-- Batching Variables
DECLARE @AEL_MinCount		int
DECLARE @AEL_MaxTotal		int
DECLARE @AEL_CurrentTotal	int
DECLARE @AEL_Total			int










-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC dbo.AccessEventLogTables_DataRemoval_vReplicatedStoredProc'
	PRINT N'	@DisplayInfo			   = 0'
	PRINT N'	, @GenerateCountsOnly	   = 1'	
	PRINT N'	, @PurgeDatesOlderThanDays = 180'
	PRINT N'	, @BatchSize			   = 1000'
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


	-- AccessEventLog table counts
	SET		@AccessEventLogCount							= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		AccessEventLog
																WHERE
																		TimeStamp < @StartDate
															)


													
													
													


	-- Building Result Set
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'Table Counts                      '
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'AccessEventLog                      ' + REPLACE(CONVERT(varchar(20), (CAST( @AccessEventLogCount  as money  )), 1), '.00', '')
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
IF OBJECT_ID('tempdb..#AccessEventLog') IS NOT NULL						DROP TABLE #AccessEventLog		
CREATE TABLE #AccessEventLog
	(
		RowId						int Identity ( 1, 1 )
		, AccessEventLogObjectId	int
		
	)





-- Set the max total for AccessEventLog records to be removed
SET @AEL_MaxTotal			= 
								(
									SELECT
											COUNT(1)
									FROM
											AccessEventLog
									WHERE
											TimeStamp < @StartDate
								)



-- AEL Working Batch
INSERT INTO #AccessEventLog ( AccessEventLogObjectId )
SELECT
		TOP ( @BatchSize )
		ObjectId
FROM
		AccessEventLog
WHERE
		TimeStamp < @StartDate
ORDER BY
		ObjectId ASC	
	
	

	
WHILE @AEL_MaxTotal > 0
BEGIN

SET @message = ' '
RAISERROR (@message,0,1) with NOWAIT  


SET @message = 'AEL max total records ' + CAST( @AEL_MaxTotal as varchar )
RAISERROR (@message,0,1) with NOWAIT  

	
	
		-- Batch delete AccessEventLog
		SET @AEL_Total = 
							(
								SELECT
										COUNT(1)
								FROM
										AccessEventLog
								WHERE
										ObjectId IN 
																	(
																		SELECT
																				AccessEventLogObjectId
																		FROM
																				#AccessEventLog
																	)
							)
		
		
		
		
		
		
		WHILE @AEL_Total > 0
		BEGIN
		
		

				-- Deletes AccessEventLog in batches
				SET @message = 'AEL remaining in this batch ' + CAST( @AEL_Total as varchar )
				RAISERROR (@message,0,1) with NOWAIT  
				
				
				/*********  Warning  *********/
				DELETE 
						TOP ( @BatchSize )
				FROM	
						AccessEventLog WITH ( ROWLOCK )	
				WHERE
						ObjectId IN ( SELECT AccessEventLogObjectId FROM #AccessEventLog )


						
				-- Re-calculate Totals
				SET @AEL_Total = 
									(
										SELECT
												COUNT(1)
										FROM
												AccessEventLog
										WHERE
												ObjectId IN 
																			(
																				SELECT
																						AccessEventLogObjectId
																				FROM
																						#AccessEventLog
																			)
									)


		END
	
	
	



-- Truncates the working AEL table
TRUNCATE TABLE #AccessEventLog


-- Re-calculate Totals
SET @AEL_MaxTotal			= 
								(
									SELECT
											COUNT(1)
									FROM
											AccessEventLog
									WHERE
											TimeStamp < @StartDate
								)



-- AEL Working Batch
INSERT INTO #AccessEventLog ( AccessEventLogObjectId )
SELECT
		TOP ( @BatchSize )
		ObjectId
FROM
		AccessEventLog
WHERE
		TimeStamp < @StartDate
ORDER BY
		ObjectId ASC	



	
END	
	

	
	
-- Testing
--SELECT *	FROM #AccessEventLog ORDER BY RowId


	
	
	
END



-- Post Processing Table Counts
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Generating Final Counts'
	RAISERROR (@message,0,1) with NOWAIT  


	-- AccessEventLog table counts
	SET	@AccessEventLogCount							= 	
															(
																SELECT
																		COUNT(1)
																FROM
																		AccessEventLog
																WHERE
																		TimeStamp < @StartDate
															)


													
													
													




	-- Building Result Set
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'Table Counts                      '
	RAISERROR (@message,0,1) with NOWAIT  


	SET @message = 'AccessEventLog                      ' + REPLACE(CONVERT(varchar(20), (CAST( @AccessEventLogCount  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT 


END





SEND_NOTIFICATION:

IF @GenerateCountsOnlyCheck = 1 AND @SendNotification = 1 AND @@SERVERNAME = 'Doctor'
BEGIN

	DECLARE	@deleteValue	varchar(50)

	SET		@deleteValue	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST( @AccessEventLogCount  as money  )), 1), '.00', '') )


	DECLARE @xml01 		NVARCHAR(MAX)
	DECLARE @body01 	NVARCHAR(MAX)


	SET @xml01 = CAST(( 


	SELECT	@deleteValue				AS 'td'


	FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


	SET @body01 =
												'<html><body><H3>
	Access Event Log Table	
												</H3><table border = 1><tr><th> 
	Delete Count For Job Execution Tonight		</th></tr>
	'    

	 
	SET @body01 = @body01 + @xml01 +'</table></body></html>'


	--
	DECLARE @bodyActionEmail01		varchar(max)
	DECLARE @bodyActionText01		varchar(max)
	DECLARE	@bodyExplain01			varchar(max)

	SET		@bodyActionEmail01	=	'Rows To Be Delete Tonight = '+ @deleteValue
	SET		@bodyActionText01	=	'AccessEventLog Deleting '+ @deleteValue + ' rows tonight'
	SET		@bodyExplain01		=	'Scheduled Job will be deleting this many rows tonight on OLTP'



	--Sends email regarding details of issue
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name		= 'DB Maintenance & Jobs'
		, @body 			= @body01
		, @body_format 		= 'HTML'
		, @recipients 		= 'tpeterson@InMoment.com; '-- bluther@InMoment.com; kmciff@InMoment.com' -- Tad; Bob
		, @copy_recipients	= ''
		, @subject 			= @bodyActionEmail01 ;



END





-- Clean up
IF OBJECT_ID('tempdb..#AccessEventLog') IS NOT NULL						DROP TABLE #AccessEventLog		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
