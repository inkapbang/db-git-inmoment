SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--use warehouse
--go

CREATE PROCEDURE [Monitor].[JobDuration_Opsview] (
@jobname varchar(1000),@warning int, @critical int
)
AS

declare @duration int

SELECT @duration = DATEDIFF(MINUTE,aj.start_execution_date,GetDate())
FROM msdb..sysjobactivity aj
JOIN msdb..sysjobs sj on sj.job_id = aj.job_id
WHERE aj.stop_execution_date IS NULL -- job hasn't stopped running
AND aj.start_execution_date IS NOT NULL -- job is currently running
AND sj.name = @jobname
and not exists( -- make sure this is the most recent run
    select 1
    from msdb..sysjobactivity new
    where new.job_id = aj.job_id
    and new.start_execution_date > aj.start_execution_date
)

IF @duration is null
Select @jobName+' is not running. | '''+@jobname+' duration''=0' as output, 0 as stateValue

IF (@duration > @warning and @duration < @critical)
Select @jobName +' duration: '+ cast(@duration as varchar)+' |  '''+@jobname+' duration''='+ cast(@duration as varchar) as output, 1 as stateValue

IF (@duration > @critical)
Select @jobName +' duration: '+ cast(@duration as varchar)+' |  '''+@jobname+' duration''='+ cast(@duration as varchar) as output, 2 as stateValue

IF (@duration < @warning)
Select @jobName +' duration: '+ cast(@duration as varchar)+' |  '''+@jobname+' duration''='+ cast(@duration as varchar) as output, 0 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
