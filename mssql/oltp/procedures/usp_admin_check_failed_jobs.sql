SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- CREATE PROCEDURE 

CREATE PROC [dbo].[usp_admin_check_failed_jobs] @NumDays int
AS

SET NOCOUNT ON
PRINT 	'Checking for all jobs that have failed in the last ' + CAST(@NumDays AS char(2)) +' days.......'
PRINT	' '

SELECT 	run_date	AS 'Failure Date',
--CAST(CONVERT(datetime,CAST(run_date AS char(8)),101) AS char(120))	AS 'Failure Date',
	SUBSTRING(T2.name,1,40)							AS 'Job Name',
	T1.step_id 								AS 'Step #',
	T1.step_name								AS 'Step Name',
	T1.message								AS 'Message'

FROM	msdb..sysjobhistory 	T1
JOIN	msdb..sysjobs		T2
	ON T1.job_id = T2.job_id

WHERE		T1.run_status != 1
	AND	T1.step_id != 0
	AND	run_date >= CONVERT(char(8), (select dateadd (day,(-1*@NumDays), getdate())), 112)
	and t2.name not like 'LS%'

--exec [dbo].[usp_admin_check_failed_jobs] 1
--select * from msdb..sysjobhistory
--select * from msdb..sysjobs
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
