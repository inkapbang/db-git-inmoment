SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_ProductionStatsDatabaseSizeEmail_vTad]
AS 

/**********************  Production Stats Database Daily Email  *******************************
		Executes on OLTP
		
		usp_admin_ProductionStatsDatabaseSizeEmail_vTad

		1. Daily values
		3. 7 day 
		4. 30 day 
		5. 90 day 
		6. 180 day 

*************************************************************************************/


DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)

DECLARE @subjectName 	varchar(max)
DECLARE @recipientList	varchar(max)
DECLARE @dbProfileName	varchar(max)

SET @dbProfileName 	= 'Notification'
--SET @recipientList	= 'tpeterson@mshare.net'	--use this for testing
SET @recipientList	= 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- use this for live results
SET @subjectName	= 'Production Database Size'



-----Place query statment below

SET @xml = CAST(( 



SELECT
		t01.dbn
																																	AS 'td',''
		, CONVERT( varchar(20), CAST(	(		t01Total					/CAST( POWER(1024, 1)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t03Total		)	/CAST( POWER(1024, 1)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t04Total		)	/CAST( POWER(1024, 1)	as FLOAT) ) AS money), 1	) 
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t05Total		)	/CAST( POWER(1024, 1)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		
		, '          '																												
																																	AS 'td',''

		
		, CONVERT( varchar(20), CAST( 	(		t01Total					/CAST( POWER(1024, 2)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t03Total		)	/CAST( POWER(1024, 2)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t04Total		)	/CAST( POWER(1024, 2)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t05Total		)	/CAST( POWER(1024, 2)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		

		, '          '																												
																																	AS 'td',''

		, CONVERT( varchar(20), CAST( 	(		t01Total					/CAST( POWER(1024, 3)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t03Total		)	/CAST( POWER(1024, 3)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td',''		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t04Total		)	/CAST( POWER(1024, 3)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td'			-- <--This will need to be modified when bringing on the 90 day		
		, CONVERT( varchar(20), CAST(	(	(	t01Total - t05Total		)	/CAST( POWER(1024, 3)	as FLOAT) ) AS money), 1	) 	
																																	AS 'td'
		



		
FROM
		(
			SELECT
					'Mindshare'			AS dbn
					, SUM(total)		AS t01Total
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = CAST(FLOOR(CAST(getDate() as float)) as dateTime)
		)	as t01
	LEFT JOIN
		(
			SELECT 
					'Mindshare'			AS dbn
					, SUM(total)		AS t02Total
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -1, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t02
						ON t01.dbn = t02.dbn	
	LEFT JOIN
		(
			SELECT 
					'Mindshare'			AS dbn
					, SUM(total)		AS t03Total
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -7, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t03
						ON t01.dbn = t02.dbn	
	LEFT JOIN
		(
			SELECT 
					'Mindshare'			AS dbn
					, SUM(total)		AS t04Total
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -30, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t04
						ON t01.dbn = t02.dbn	
	LEFT JOIN
		(
			SELECT 
					'Mindshare'			AS dbn
					, SUM(total)		AS t05Total
			FROM
					ProductionStats		WITH (NOLOCK)
					
			WHERE
					date = DATEADD( dd, -90, CAST(FLOOR(CAST(getDate() as float)) as dateTime)   )
		)	as t05
						ON t01.dbn = t02.dbn	

























FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))





-----Header Naming and Column Naming below

SET @body =											
													'<html><body><H1><font color="#4040C5">
Greetings From Alert Monitoring Engine													
													</font></H1><br /><H4>
													
Production Database Size
	
													</H4><table border = 2><tr><th> 
Database Name							
													</th><th> 
Current Size  MB							
													</th><th> 
Chg 7 Day Size  MB								
													</th><th> 
Chg 30 Day Size  MB								
													</th><th>
Chg 90 Day Size  MB								
													</th><th>													
spacer									
													</th><th>
Current Size  GB										
													</th><th>
Chg 7 Day Size  GB								
													</th><th>
Chg 30 Day Size  GB								
													</th><th>
Chg 90 Day Size  GB								
													</th><th>													
spacer									
													</th><th>
Current Size  TB										
													</th><th>																										
Chg 7 Day Size  TB								
													</th><th>
Chg 30 Day Size  TB	
													</th><th>
Chg 90 Day Size  TB															
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
