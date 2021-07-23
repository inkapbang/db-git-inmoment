SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_ReportRunStatus_AutoDelivery]
		@deliveryEmail	varchar(100)	= NULL
		, @OrgId		int				= NULL
		, @beginDate	dateTime		= NULL
		, @endDate		dateTime		= NULL

AS

/**************  Report Run Status Auto Delivery  **************

	This can be executed against any warehouse.

	Modified:
		2.20.2013	Tad Peterson
			-- added in PageObjectId
		
		8.29.2014	Tad Peterson
			-- modified date format to be more obvious


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
SET 	@FileName 				= 	cast(replace(convert(varchar(10),getdate(),120),'-','') as varchar) + 'reportRunStatus_OrgId_' + CAST(@OrgId as varchar) + '.csv'


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
	
		PRINT 'Report Run Status'
		PRINT CHAR(9) + 'Description:  Displays a list of all Pages (reports) for a given organization'
		PRINT CHAR(9) + 'and notes whether it has been run.  Useful for Ops "spring cleaning" an orgs reports.'
		PRINT CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'Org Id' + CHAR(13) + CHAR(9) + 'Begin Date'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'End Date'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT CHAR(9) + 'sp_ReportRunStatus_AutoDelivery' 
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
, @subject			= 'Report Run Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.


sp_ReportRunStatus_AutoDelivery
		@deliveryEmail	= ''your email address here''
		, @OrgId		= ''organization id here''
		, @beginDate	= ''starting date here''
		
	-- optional	
		, @endDate		= NULL
		




		
		
		
-- Example Below --

sp_ReportRunStatus_AutoDelivery
		@deliveryEmail	= ''tpeterson@InMoment.com''
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
IF OBJECT_ID('tempdb..##reportRunStatus_ResultSet') IS NOT NULL			DROP TABLE ##reportRunStatus_ResultSet
CREATE TABLE ##reportRunStatus_ResultSet
	(
	
	
		OrgName						varchar(100)
		, FolderName				nvarchar(max)
		, PageObjectId				int
		, PageName					nvarchar(max)
		, ManualRunStatus			varchar(5)
		, ScheduledRunStatus		varchar(5)
		, LastRunTimestamp			dateTime
		, ExecutionCount			bigInt
	
	)


INSERT INTO ##reportRunStatus_ResultSet	( OrgName, FolderName, PageObjectId, PageName, ManualRunStatus, ScheduledRunStatus, LastRunTimestamp, ExecutionCount )
SELECT
		REPLACE(a.OrgName , ',' , ' ')
		--a.OrgName
		
		, REPLACE(a.FolderName , ',' , ' ')
		--, a.FolderName
		
		, a.PageObjectId
		
		, REPLACE(a.PageName , ',' , ' ')
		--, a.PageName
		, CASE WHEN b.PageObjectId IS NULL	THEN 'Never'	ELSE 'Ran'		END		AS ManualRunStatus
		, CASE WHEN c.PageObjectId IS NULL	THEN 'Never'	ELSE 'Ran'		END		AS ScheduledRunStatus
		
		, d.LastRunTimestamp
		, e.ExecutionCount
		
FROM
		(
			SELECT
					
					t01.objectId					AS OrgObjectIdId
					, t02.objectId					AS FolderObjectId
					, t04.objectId					AS PageObjectId


					, t01.name						AS OrgName
					, t03.value						AS FolderName
					, t05.value						AS PageName

			FROM
					organization					t01		WITH (NOLOCK)
				JOIN
					folder							t02		WITH (NOLOCK)
							ON t01.objectId = t02.organizationObjectId
				JOIN
					localizedStringValue			t03		WITH (NOLOCK)
							ON t02.nameObjectId = t03.localizedStringObjectId	AND t03.localeKey = 'en_US'	
				JOIN
					page							t04		WITH (NOLOCK)
							ON t02.objectId = t04.folderObjectId
				JOIN
					localizedStringValue			t05		WITH (NOLOCK)												
							ON t04.nameObjectId = t05.localizedStringObjectId	AND t05.localeKey = 'en_US'	


			WHERE
					t01.objectId					= @OrgID
							
		)	AS a

LEFT JOIN

		(
			--Manually Ran Reports
			SELECT 
					t02.objectId					AS PageObjectId		
				
			FROM
					organization					t01	WITH (NOLOCK)
				JOIN 
					page							t02 WITH (NOLOCK)
							ON t01.objectId = t02.organizationObjectId
				JOIN 
					pageLogEntry					t03 WITH (NOLOCK)
							ON t02.objectId = t03.pageObjectId
				JOIN 
					localizedStringValue			t04 WITH (NOLOCK)
							ON t02.nameObjectId = t04.localizedStringObjectId

			WHERE 
					t01.objectid					= @OrgID
				AND 
					t03.pageScheduleObjectId		IS NULL
				AND 
					t03.creationDateTime			BETWEEN	@beginDate 
														AND @endDate

			GROUP BY 
					t02.objectId

		)	AS b
				ON a.pageObjectId = b.PageObjectId

LEFT JOIN
		(
			--Scheduled Ran Reports
			SELECT 
					t02.objectId					AS PageObjectId		
				
			FROM
					organization					t01	WITH (NOLOCK)
				JOIN 
					page							t02 WITH (NOLOCK)
							ON t01.objectId = t02.organizationObjectId
				JOIN 
					pageLogEntry					t03 WITH (NOLOCK)
							ON t02.objectId = t03.pageObjectId
				JOIN 
					localizedStringValue			t04 WITH (NOLOCK)
							ON t02.nameObjectId = t04.localizedStringObjectId

			WHERE 
					t01.objectid					= @OrgID
				AND 
					t03.pageScheduleObjectId		IS NOT NULL
				AND 
					t03.creationDateTime			BETWEEN @beginDate 
														AND	@endDate

			GROUP BY 
					t02.objectId

		)	AS c
				ON a.pageObjectId = c.PageObjectId


LEFT JOIN
		(
			SELECT 
					t02.objectId					AS PageObjectId	
					, MAX( t03.creationDateTime )	AS LastRunTimestamp
				
			FROM
					organization					t01	WITH (NOLOCK)
				JOIN 
					page							t02 WITH (NOLOCK)
							ON t01.objectId = t02.organizationObjectId
				JOIN 
					pageLogEntry					t03 WITH (NOLOCK)
							ON t02.objectId = t03.pageObjectId
				JOIN 
					localizedStringValue			t04 WITH (NOLOCK)
							ON t02.nameObjectId = t04.localizedStringObjectId

			WHERE 
					t01.objectid					= @OrgID
				AND 
					t03.creationDateTime			BETWEEN @beginDate 
														AND	@endDate

			GROUP BY 
					t02.objectId

		)	AS d
				ON a.pageObjectId = d.PageObjectId

LEFT JOIN
		(
			SELECT 
					t02.objectId					AS PageObjectId	
					, COUNT(1)						AS ExecutionCount
				
			FROM
					organization					t01	WITH (NOLOCK)
				JOIN 
					page							t02 WITH (NOLOCK)
							ON t01.objectId = t02.organizationObjectId
				JOIN 
					pageLogEntry					t03 WITH (NOLOCK)
							ON t02.objectId = t03.pageObjectId
				JOIN 
					localizedStringValue			t04 WITH (NOLOCK)
							ON t02.nameObjectId = t04.localizedStringObjectId

			WHERE 
					t01.objectid					= @OrgID
				AND 
					t03.creationDateTime			BETWEEN @beginDate 
														AND	@endDate

			GROUP BY 
					t02.objectId

		)	AS e
				ON a.pageObjectId = e.PageObjectId
			
ORDER BY
		a.OrgName
		, a.FolderName
		, a.PageName		

	
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
IF OBJECT_ID('tempdb..##reportRunStatus_Results') IS NOT NULL	DROP TABLE ##reportRunStatus_Results
CREATE TABLE ##reportRunStatus_results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)

DECLARE @fileRowCount	varchar(25)
SET		@fileRowCount	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST(    		COUNT(1)    	AS money)), 1), '.00', '')		FROM ##reportRunStatus_ResultSet )
 	

INSERT INTO ##reportRunStatus_results ( Item, Criteria )
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
										, ManualRunStatus
										, ScheduledRunStatus
										, LastRunTimeStamp
										, ExecutionCount
												
								FROM 
										##reportRunStatus_ResultSet

							'				



SET @xml = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##reportRunStatus_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @body =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Report Run Status Comments
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @body = @body + @xml +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
, @copy_recipients 				= 'tpeterson@InMoment.com'
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
		
IF OBJECT_ID('tempdb..##reportRunStatus_Results') IS NOT NULL	DROP TABLE ##reportRunStatus_Results	
IF OBJECT_ID('tempdb..##reportRunStatus_ResultSet') IS NOT NULL	DROP TABLE ##reportRunStatus_ResultSet	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
