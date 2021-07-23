SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_ReportRunStatusByUser_AutoDelivery]
		@deliveryEmail	varchar(100)	= NULL
		, @OrgId		int				= NULL
		, @beginDate	dateTime		= NULL
		, @endDate		dateTime		= NULL

AS

/**************  Report Run Status Auto Delivery  **************

	This can be executed against any warehouse.

	Name		: In-Kap Bang
	Date		: 2016.09.30
	Description	: Report Run Status By User


***************************************************************/
SET NOCOUNT ON


DECLARE @deliveryEmailCheck		int
SET		@deliveryEmailCheck		= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
										WHEN LEN(@deliveryEmail) = 0	THEN 0
										WHEN LEN(@deliveryEmail) > 0	THEN 1
									END
									

DECLARE @OrgIdCheck				int
SET		@OrgIdCheck				= CASE	WHEN ISNULL(@OrgId, 0 ) IS NULL 	THEN 0
										WHEN ISNULL(@OrgId, 0 ) = 0			THEN 0
										WHEN ISNULL(@OrgId, 0 ) > 0			THEN 1
									END

									
DECLARE @beginDateCheck			int
SET		@beginDateCheck			= CASE	WHEN @beginDate IS NULL							THEN 0
										WHEN @beginDate = '1900-01-01 00:00:00.000'		THEN 0
										WHEN @beginDate > '1900-01-01 00:00:00.000'		THEN 1
									END

									
DECLARE @endDateCheck			int
SET		@endDateCheck			= CASE	WHEN @endDate IS NULL						THEN 0
										WHEN @endDate = '1900-01-01 00:00:00.000'	THEN 0
										WHEN @endDate > '1900-01-01 00:00:00.000'	THEN 1
									END


SET		@endDate				= CASE	WHEN @endDateCheck = 0	THEN DATEADD(dd,1,cast(floor(cast(getdate() as float))as datetime)) --tomorrow
										WHEN @endDateCheck = 1	THEN @endDate
									END	

						
DECLARE @FileName				varchar(100)
SET 	@FileName 				= 	cast(replace(convert(varchar(10),getdate(),120),'-','') as varchar) + 'reportRunStatusByUser_OrgId_' + CAST(@OrgId as varchar) + '.csv'


DECLARE @querySqlStatement		nvarchar(Max)											
DECLARE @xml   					nvarchar(Max)
DECLARE @body   				nvarchar(Max)
						
						
						
-- Parameter Checking / Verification
--SELECT @deliveryEmailCheck AS Email, @OrgIdCheck AS OrgId, @beginDateCheck AS BeginDate
--SELECT @endDate, @endDateCheck



-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@OrgIdCheck				= 0	
	AND 
		@beginDateCheck			= 0	
			
	BEGIN
	
		PRINT 'Report Run Status By User'
		PRINT CHAR(9) + 'Description:  Displays a list of all Pages (reports) for a given organization'
		PRINT CHAR(9) + 'and notes whether it has been run by user identified by e-mail.'
		PRINT CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'Org Id' + CHAR(13) + CHAR(9) + 'Begin Date'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'End Date'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT CHAR(9) + 'sp_ReportRunStatusByUser_AutoDelivery' 
		PRINT CHAR(9) +CHAR(9) + '@DeliveryEmail  = ''Their Email Here'''
		
	RETURN
	END		


IF		@deliveryEmailCheck		= 0	
	AND 
		(
				@OrgIdCheck				= 0
			OR
				@OrgIdCheck				= 1
		)	
	AND 
		(
				@beginDateCheck			= 0
			OR
				@beginDateCheck			= 1	
		)			
			
	BEGIN
		PRINT 'Email is required'		
	RETURN
	END		

	
	
-- Send an email to delivery for information
IF		@deliveryEmailCheck		= 1	
	AND 
		@OrgIdCheck				= 0	
	AND 
		@beginDateCheck			= 0		


BEGIN
	PRINT 'Emailed Form'
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name		= 'Internal Request'
, @recipients		= @deliveryEmail
, @reply_to			= 'dba@InMoment.com'
, @subject			= 'Report Run By User Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.


sp_ReportRunStatusByUser_AutoDelivery
		@deliveryEmail	= ''your email address here''
		, @OrgId		= ''organization id here''
		, @beginDate	= ''starting date here''
		
	-- optional	
		, @endDate		= NULL
		




		
		
		
-- Example Below --

sp_ReportRunStatusByUser_AutoDelivery
		@deliveryEmail	= ''ikpbang@InMoment.com''
		, @OrgId		= ''777''
		, @beginDate	= ''10/21/2012''
		
	-- optional
		, @endDate		= ''11/16/2012''
		


Notes & Comments
-----------------
	All entries must be inside single quotes '''', except NULLs
		
	Currently our database only retains log history information
	for the previous 6 months.


		
'		
	
	
RETURN	
END


------------------   Place remaining Stored Procedure Here   -------------------------
-- Missing Begin Date Parameter
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 0
			
BEGIN
	PRINT 'Begin Date parameter required'
RETURN	
END


-- Missing Org Id Parameter
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 0		
	AND
		@beginDateCheck		= 1

BEGIN
	PRINT 'Org Id parameter required'
RETURN	
END




-- When "required" are present run the drop out analysis
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1

BEGIN
	PRINT 'Query has been generated'
	

-- Builds Final Temp Table
IF OBJECT_ID('tempdb..##reportRunStatusByUser_ResultSet') IS NOT NULL			DROP TABLE ##reportRunStatusByUser_ResultSet
CREATE TABLE ##reportRunStatusByUser_ResultSet
	(
	
	
		OrgName						varchar(100)
		, FolderName				nvarchar(max)
		, PageObjectId				int
		, PageName					nvarchar(max)
		, UserEmail					varchar(100)
		, ManualRunStatus			varchar(5)
		, ScheduledRunStatus		varchar(5)
		, LastRunTimestamp			dateTime
		, ExecutionCount			bigInt
	
	)


INSERT INTO ##reportRunStatusByUser_ResultSet	( OrgName, FolderName, PageObjectId, PageName, UserEmail, ManualRunStatus, ScheduledRunStatus, LastRunTimestamp, ExecutionCount )


SELECT	REPLACE(PAGE_DETAIL.OrgName, ',', ' ') as OrgName,
		REPLACE(PAGE_DETAIL.FolderName, ',', ' ') as FolderName,
		PAGE_DETAIL.PageObjectId,
		REPLACE(PAGE_DETAIL.PageName, ',', ' ') as PageName,
		ISNULL(PLE_DETAIL.UserEmail,'') as UserEmail,
		CASE WHEN PLE_DETAIL.RunStatus IS NULL THEN 'Never' WHEN PLE_DETAIL.RunStatus = 'ManualRun' THEN 'Ran' ELSE 'Never' END AS ManualRunStatus,
		CASE WHEN PLE_DETAIL.RunStatus IS NULL THEN 'Never' WHEN PLE_DETAIL.RunStatus = 'ScheduledRun' THEN 'Ran' ELSE 'Never' END AS ScheduledRunStatus,
		PLE_DETAIL.LastRunDate,
		PLE_DETAIL.RunCount
FROM

		(
		SELECT	o.objectId as OrgObjectId,
				f.objectId as FolderObjectId,
				p.objectId as PageObjectId,
				o.name as OrgName,
				lsv1.value as FolderName,
				lsv2.value as PageName
		FROM	Organization o WITH (NOLOCK)
				INNER JOIN Folder f WITH (NOLOCK) ON (o.objectId = f.organizationObjectId)
				INNER JOIN LocalizedStringValue lsv1 WITH (NOLOCK) ON (f.nameObjectId = lsv1.localizedStringObjectId AND lsv1.localeKey = 'en_US')
				INNER JOIN Page p WITH (NOLOCK) ON (f.objectId = p.folderObjectId)
				INNER JOIN LocalizedStringValue lsv2 WITH (NOLOCK) ON (p.nameObjectId = lsv2.localizedStringObjectId AND lsv2.localeKey = 'en_US')
		WHERE	o.objectId = @OrgID
		) PAGE_DETAIL

		LEFT OUTER JOIN

		(
		SELECT	PageObjectId,
				UserEmail,
				RunStatus,
				MAX(creationDateTime) as LastRunDate,
				COUNT(DISTINCT(PageLogEntryId)) as RunCount
		FROM
				(
				SELECT	ple.objectId as PageLogEntryId,
						p.objectId as PageObjectId,
						CASE WHEN ple.pageScheduleObjectId IS NULL THEN 'ManualRun' ELSE 'ScheduledRun' END AS RunStatus,
						ua.email as UserEmail,
						p.nameObjectId,
						ple.creationDateTime
				FROM	Page p WITH (NOLOCK)
						INNER JOIN PageLogEntry ple WITH (NOLOCK) ON (p.objectId = ple.pageObjectId)
						LEFT OUTER JOIN PageLogEntryUserAccount pleua WITH (NOLOCK) ON (ple.objectId = pleua.pageLogEntryObjectId)
						LEFT OUTER JOIN UserAccount ua WITH (NOLOCK) ON pleua.userAccountObjectId = ua.objectId
				WHERE	p.organizationObjectId = @OrgID
						AND (ple.creationDateTime BETWEEN	@beginDate AND @endDate)
				) PLE
		GROUP BY PageObjectId, UserEmail, RunStatus
		) PLE_DETAIL ON (PAGE_DETAIL.PageObjectId = PLE_DETAIL.PageObjectId)
		ORDER BY
		PAGE_DETAIL.OrgName
		, PAGE_DETAIL.FolderName
		, PAGE_DETAIL.PageName	

	
END
		
		

--Optional @endDate, will automatically be present from CASE statement at beginning.

--No options present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@endDateCheck		= 0		

	BEGIN
		PRINT 'No Additonal Options'
		
	GOTO CLEANUP
	END

		
--Optional endDate, present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@endDateCheck		= 1
		
	BEGIN
		PRINT 'Includes End Date'
		
	GOTO CLEANUP
	END
		
		
		
		
		
		
		
		
		
		
		
		
CLEANUP:

PRINT 'Generating & Sending Results via Email'


-- Builds Final Email
IF OBJECT_ID('tempdb..##reportRunStatusByUser_Results') IS NOT NULL	DROP TABLE ##reportRunStatusByUser_Results
CREATE TABLE ##reportRunStatusByUser_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)

DECLARE @fileRowCount	varchar(25)
SET		@fileRowCount	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST(    		COUNT(1)    	AS money)), 1), '.00', '')		FROM ##reportRunStatusByUser_ResultSet )
 	

INSERT INTO ##reportRunStatusByUser_results ( Item, Criteria )
SELECT 'Server Name', @@SERVERNAME
UNION ALL
SELECT 'Delivery Email', @deliveryEmail
UNION ALL
SELECT 'Organization Id', CAST(@OrgId as varchar)
UNION ALL
SELECT 'Start Date', CONVERT(char(8), @beginDate, 112)
UNION ALL
SELECT 'End Date', CONVERT(char(8), @endDate, 112)
UNION ALL
SELECT 'Execution Date & Time', CONVERT(varchar, getdate(), 109)
UNION ALL
SELECT 'File Row Count', @fileRowCount

		
		
		
		-- Email Results & File	
SET @querySqlStatement		= 
							'
								SELECT
										OrgName
										, FolderName
										, PageObjectId																				
										, PageName
										, UserEmail
										, ManualRunStatus
										, ScheduledRunStatus
										, LastRunTimeStamp
										, ExecutionCount
												
								FROM 
										##reportRunStatusByUser_ResultSet

							'				



SET @xml = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##reportRunStatusByUser_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @body =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Report Run Status By User Comments
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @body = @body + @xml +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @copy_recipients 				= 'ikpbang@InMoment.com'
--, @copy_recipients 				= 'tpeterson@InMoment.com; jdiamond@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Report Run Status Results & Criteria'
, @body_format					= 'HTML'
, @body							= @body
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= ','
, @query_attachment_filename	= @FileName
, @query_result_header 			= 1
, @execute_query_database		= 'oltp'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatement


		
		
		
PRINT 'Email Has Been Sent'		
	
PRINT 'Removing Temp Tables'

--SELECT *	FROM ##reportRunStatus_ResultSet
		
IF OBJECT_ID('tempdb..##reportRunStatusByUser_Results') IS NOT NULL	DROP TABLE ##reportRunStatusByUser_Results	
IF OBJECT_ID('tempdb..##reportRunStatusByUser_ResultSet') IS NOT NULL	DROP TABLE ##reportRunStatusByUser_ResultSet	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
