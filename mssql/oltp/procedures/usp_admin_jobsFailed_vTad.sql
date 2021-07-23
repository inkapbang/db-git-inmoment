SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_jobsFailed_vTad]
	
AS
/*************************  Failed Jobs Notification Production  *************************
	Runs on Doctor Mindshare OLTP
		usp_admin_jobsFailed_vTad

*****************************************************************************************/

DECLARE @dTT01 TABLE
	(
		job_name			varchar(255)
		, execute_Date		varchar(20)
		, execute_Time		varchar(20)
		, run_duration		varchar(20)
		, next_start_date	varchar(20)
		, next_start_time	varchar(20)
		, server			varchar(50)
		, step_id			int
	)





-----Failed Jobs
INSERT INTO @dTT01
SELECT 
	--	*
		DISTINCT j.name 			AS job_name
		, convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101)									AS execute_Date
		, convert(char(8), CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 14 )									AS execute_Time
		--, run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4
		, run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6)
		, SUBSTRING(CAST(next_run_date as varchar), 5, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 7, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 1, 4) 		AS 	next_start_date
		, CAST((next_run_time / 10000) AS VARCHAR(10)) + ':' + RIGHT('00' + CAST((next_run_time % 10000) / 100 AS VARCHAR(10)),2) 												AS	next_start_time

		, server
		, step_id
FROM
		msdb.dbo.sysjobhistory h
	JOIN 
		msdb.dbo.sysjobs j
							ON h.job_id = j.job_id
	JOIN			
		msdb.dbo.sysjobschedules s
							ON h.job_id = s.job_id				


WHERE
		run_status = 0
	AND
		step_id = 0
	AND
		convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101) > DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))
	AND
		j.name NOT LIKE '%_alert%'
	AND
		j.name NOT LIKE 'serversHealth'


UNION ALL


SELECT 
	--	*
		DISTINCT j.name 			AS job_name
		, convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101)									AS execute_Date
		, convert(char(8), CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 14 )									AS execute_Time
		--, run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4
		, run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6)
		, SUBSTRING(CAST(next_run_date as varchar), 5, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 7, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 1, 4) 		AS 	next_start_date
		, CAST((next_run_time / 10000) AS VARCHAR(10)) + ':' + RIGHT('00' + CAST((next_run_time % 10000) / 100 AS VARCHAR(10)),2) 												AS	next_start_time

		, server
		, step_id
FROM
		Roy.msdb.dbo.sysjobhistory h
	JOIN 
		Roy.msdb.dbo.sysjobs j
							ON h.job_id = j.job_id
	JOIN			
		Roy.msdb.dbo.sysjobschedules s
							ON h.job_id = s.job_id				


WHERE
		run_status = 0
	AND
		step_id = 0
	AND
		convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101) > DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))
	AND
		j.name NOT LIKE '%_alert%'
	AND
		j.name NOT LIKE 'serversHealth'


--UNION ALL


--SELECT 
--	--	*
--		DISTINCT j.name 			AS job_name
--		, convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101)									AS execute_Date
--		, convert(char(8), CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 14 )									AS execute_Time
--		--, run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4
--		, run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6)
--		, SUBSTRING(CAST(next_run_date as varchar), 5, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 7, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 1, 4) 		AS 	next_start_date
--		, CAST((next_run_time / 10000) AS VARCHAR(10)) + ':' + RIGHT('00' + CAST((next_run_time % 10000) / 100 AS VARCHAR(10)),2) 												AS	next_start_time

--		, server
--		, step_id
--FROM
--		chest.msdb.dbo.sysjobhistory h
--	JOIN 
--		chest.msdb.dbo.sysjobs j
--							ON h.job_id = j.job_id
--	JOIN			
--		chest.msdb.dbo.sysjobschedules s
--							ON h.job_id = s.job_id				


--WHERE
--		run_status = 0
--	AND
--		step_id = 0
--	AND
--		convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101) > DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))
--	AND
--		j.name NOT LIKE '%_alert%'
--	AND
--		j.name NOT LIKE 'serversHealth'

/*
UNION ALL


SELECT 
	--	*
		DISTINCT j.name 			AS job_name
		, convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101)									AS execute_Date
		, convert(char(8), CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 14 )									AS execute_Time
		--, run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4
		, run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6)
		, SUBSTRING(CAST(next_run_date as varchar), 5, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 7, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 1, 4) 		AS 	next_start_date
		, CAST((next_run_time / 10000) AS VARCHAR(10)) + ':' + RIGHT('00' + CAST((next_run_time % 10000) / 100 AS VARCHAR(10)),2) 												AS	next_start_time

		, server
		, step_id
FROM
		Treasure.msdb.dbo.sysjobhistory h
	JOIN 
		Treasure.msdb.dbo.sysjobs j
							ON h.job_id = j.job_id
	JOIN			
		Treasure.msdb.dbo.sysjobschedules s
							ON h.job_id = s.job_id				


WHERE
		run_status = 0
	AND
		step_id = 0
	AND
		convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101) > DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))
	AND
		j.name NOT LIKE '%_alert%'
	AND
		j.name NOT LIKE 'serversHealth'

*/

--UNION ALL


--SELECT 
--	--	*
--		DISTINCT j.name 			AS job_name
--		, convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101)									AS execute_Date
--		, convert(char(8), CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 14 )									AS execute_Time
--		--, run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4
--		, run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6)
--		, SUBSTRING(CAST(next_run_date as varchar), 5, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 7, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 1, 4) 		AS 	next_start_date
--		, CAST((next_run_time / 10000) AS VARCHAR(10)) + ':' + RIGHT('00' + CAST((next_run_time % 10000) / 100 AS VARCHAR(10)),2) 												AS	next_start_time

--		, server
--		, step_id
--FROM
--		Cannonball.msdb.dbo.sysjobhistory h
--	JOIN 
--		Cannonball.msdb.dbo.sysjobs j
--							ON h.job_id = j.job_id
--	JOIN			
--		Cannonball.msdb.dbo.sysjobschedules s
--							ON h.job_id = s.job_id				


--WHERE
--		run_status = 0
--	AND
--		step_id = 0
--	AND
--		convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101) > DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))
--	AND
--		j.name NOT LIKE '%_alert%'
--	AND
--		j.name NOT LIKE 'serversHealth'
		

--UNION ALL


--SELECT 
--	--	*
--		DISTINCT j.name 			AS job_name
--		, convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101)									AS execute_Date
--		, convert(char(8), CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 14 )									AS execute_Time
--		--, run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4
--		, run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6)
--		, SUBSTRING(CAST(next_run_date as varchar), 5, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 7, 2) + '/' + SUBSTRING(CAST(next_run_date as varchar), 1, 4) 		AS 	next_start_date
--		, CAST((next_run_time / 10000) AS VARCHAR(10)) + ':' + RIGHT('00' + CAST((next_run_time % 10000) / 100 AS VARCHAR(10)),2) 												AS	next_start_time

--		, server
--		, step_id
--FROM
--		Bat.msdb.dbo.sysjobhistory h
--	JOIN 
--		Bat.msdb.dbo.sysjobs j
--							ON h.job_id = j.job_id
--	JOIN			
--		Bat.msdb.dbo.sysjobschedules s
--							ON h.job_id = s.job_id				


--WHERE
--		run_status = 0
--	AND
--		step_id = 0
--	AND
--		convert(varchar, CONVERT(DATETIME, RTRIM(run_date)) + (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4   , 101) > DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))
--	AND
--		j.name NOT LIKE '%_alert%'
--	AND
--		j.name NOT LIKE 'serversHealth'
		
		
		
		

-----Email Notification
DECLARE @count		int
SET 	@count	=  ( SELECT count(1)	FROM @dTT01)


--SELECT @count
		
		
IF @count > 0 
BEGIN
		-------Sends email regarding details of issue
		DECLARE @xml NVARCHAR(MAX)
		DECLARE @body NVARCHAR(MAX)


		SET @xml = CAST(( 



		SELECT 				
				job_name			AS 'td','',
				execute_Date		AS 'td','',
				execute_Time		AS 'td','',
				run_duration		AS 'td','',
				next_start_date		AS 'td','',
				next_start_time		AS 'td','',
				server				AS 'td','',
				step_id				AS 'td'
		FROM  
				@dTT01




		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))




		SET @body =
		'<html><body><H3>
		Failed Jobs For Yesterday	
								</H3><table border = 1><tr><th>  
		Job Name					</th><th> 
		Execution Date				</th><th> 
		Execution Time				</th><th> 
		Run Duration				</th><th> 
		Next Start Date				</th><th> 
		Next Start Time				</th><th> 
		Server Nave					</th><th> 
		Step Id 					</th></tr>
		'    

		 
		SET @body = @body + @xml +'</table></body></html>'


		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Notification' -- replace with your SQL Database Mail Profile 
		, @body = @body
		, @body_format ='HTML'
		, @recipients = 'tpeterson@mshare.net ; bluther@mshare.net; kmciff@mshare.net' -- replace with your email address
		, @subject = 'Failed Jobs For Yesterday' ;

END		
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
