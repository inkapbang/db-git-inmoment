SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_admin_ProductionStatsEmail_vTad]
AS
/**********************  Production Stats Daily Email  *******************************
		Executes on OLTP
		
		usp_admin_ProductionStatsEmail_vTad

		1. Daily values
		2. Day before survey volume
		3. 7 day volume data
		4. 30 day volume data
		5. 90 day volume data
		6. 180 day volume data

*************************************************************************************/


DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)

DECLARE @subjectName 	varchar(max)
DECLARE @recipientList	varchar(max)
DECLARE @dbProfileName	varchar(max)

SET @dbProfileName 	= 'Notification'
--SET @recipientList	= 'tpeterson@mshare.net'	--use this for testing
SET @recipientList	= 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- use this for live results
SET @subjectName	= 'Production Stats'



-----Place query statment below

SET @xml = CAST(( 



SELECT 	
		ROW_NUMBER() OVER(ORDER BY t01.rowCounts DESC)																			
																																					AS 'td',''																																						
		, CONVERT(varchar(10), t01.date, 101)																	
																																					AS 'td','' 																																						
		, t01.tableName																													
																																					AS 'td','' 
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.rowCounts    		AS money)), 1), '.00', '')
																																					AS 'td','' 
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.total/1024    		AS money)), 1), '.00', '')																												
																																					AS 'td','' 
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.data/1024   		AS money)), 1), '.00', '')													
																																					AS 'td','' 
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.indexSize/1024   	AS money)), 1), '.00', '')
																																					AS 'td',''
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.rowCounts - t02.rowCounts    		AS money)), 1), '.00', '')	
																																					AS 'td',''																																								
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.rowCounts - t03.rowCounts    		AS money)), 1), '.00', '')	
																																					AS 'td',''
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.rowCounts - t04.rowCounts    		AS money)), 1), '.00', '')	
																																					AS 'td',''
		, REPLACE(CONVERT(varchar(20), (CAST(    t01.rowCounts - t05.rowCounts    		AS money)), 1), '.00', '')	
																																					AS 'td',''																																					
																																					
		, CAST(   (((cast(t01.total AS FLOAT)/NULLIF(   CAST(t03.total AS FLOAT), 0 )   ) -1)* 100)  AS	DECIMAL(10,2)	)
																																					AS 'td','' 
		, CAST(   (((cast(t01.data AS FLOAT)/NULLIF(   CAST(t03.data AS FLOAT), 0 )   ) -1)* 100)  AS	DECIMAL(10,2)	)
																																					AS 'td','' 
		, CAST(   (((cast(t01.total AS FLOAT)/NULLIF(   CAST(t04.total AS FLOAT), 0 )   ) -1)* 100)  AS	DECIMAL(10,2)	)
																																					AS 'td','' 
		, CAST(   (((cast(t01.data AS FLOAT)/NULLIF(   CAST(t04.data AS FLOAT), 0 )   ) -1)* 100)  AS	DECIMAL(10,2)	)
																																					AS 'td',''	
		, CAST(   (((cast(t01.total AS FLOAT)/NULLIF(   CAST(t05.total AS FLOAT), 0 )   ) -1)* 100)  AS	DECIMAL(10,2)	)
																																					AS 'td','' 
		, CAST(   (((cast(t01.data AS FLOAT)/NULLIF(   CAST(t05.data AS FLOAT), 0 )   ) -1)* 100)  AS	DECIMAL(10,2)	)
																																					AS 'td'	

																																					
FROM
		(
			SELECT 
					*
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = CAST(FLOOR(CAST(getDate() as float)) as dateTime)
		)	as t01
	LEFT JOIN
		(
			SELECT 
					*
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -1, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t02
						ON t01.tableName = t02.tableName	
	LEFT JOIN
		(
			SELECT 
					*
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -7, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t03
						ON t01.tableName = t03.tableName	
	LEFT JOIN
		(
			SELECT 
					*
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -30, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t04
						ON t01.tableName = t04.tableName	
	LEFT JOIN
		(
			SELECT 
					*
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -90, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t05
						ON t01.tableName = t05.tableName	

	




FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))





-----Header Naming and Column Naming below

SET @body =											
													'<html><body><H1><font color="#4040C5">
Greetings From Alert Monitoring Engine													
													</font></H1><br /><H4>
													
Production Table Statistics
	
													</H4><table border = 2><tr><th> 
Row Id							
													</th><th> 
Date 							
													</th><th> 
Table Name								
													</th><th> 
Row Counts								
													</th><th>
Total MB									
													</th><th>
Data MB										
													</th><th>
Index Size MB
													</th><th>
Row Counts - 1 Day Chg
													</th><th>													
Row Counts - 7 Day Chg
													</th><th>
Row Counts - 30 Day Chg
													</th><th>
Row Counts - 90 Day Chg
													</th><th>																																							
Total - 7 Day Percent Chg
													</th><th>
Data - 7 Day Percent Chg
													</th><th>													
Total - 30 Day Percent Chg
													</th><th>
Data - 30 Day Percent Chg
													</th><th>
Total - 90 Day Percent Chg
													</th><th>
Data - 90 Day Percent Chg
													</th></tr>' 													

 
 
 
 
SET @body = @body + @xml +'</table></body></html>'


EXEC msdb.dbo.sp_send_dbmail
@profile_name 	= @dbProfileName 	-- replace with your SQL Database Mail Profile 
, @body 		= @body
, @body_format 	='HTML'
, @recipients 	= @recipientList 		-- replace with your email address
, @subject 		= @subjectName ;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
