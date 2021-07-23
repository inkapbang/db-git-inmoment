SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [Monitor].[TranscriptionToday_Opsview]
(@warning int, @critical int)
AS


IF EXISTS(     
        select * 
        from msdb.dbo.sysjobs_view job  
        inner join msdb.dbo.sysjobactivity activity on job.job_id = activity.job_id 
        where  
        activity.run_Requested_date is not null and
        activity.stop_execution_date is null and
        job.name in ('ReindexOLTPDaily','Maintain: Update All Stats')
        and activity.run_Requested_date > GETDATE() - 1
        ) 
BEGIN      
	Select 'Maintenance Job Running | ''Transcription Time''=0', 0 as stateValue
	RETURN   
END 

DECLARE @startTime datetime, @diffSecs int
Select @startTime = getdate()

declare @surveyResponseAnswers table (
      surveyResponseAnswerObjectId bigint not null primary key)
 
insert into @surveyResponseAnswers
    (
        surveyResponseAnswerObjectId
    )
    
select
    sra.objectId
from
    SurveyResponseAnswer sra
INNER JOIN
    SurveyResponse sr
        ON sra.surveyResponseObjectId = sr.objectId
INNER JOIN
    Location l
        ON l.objectid = sr.locationObjectid
where
  sr.begindate= CAST(GetDate() as date)  --Today
    and sr.complete = 1
	and sr.exclusionReason = 0
    and l.organizationObjectId = 418
    and sr.locationObjectId IN (
        select
            objectId
        from
            dbo.ufn_app_UserAccessibleLocationsForOrg(6829, 418)
    )
order by
    sr.beginDate,
    sr.beginTime
DECLARE @results table (id bigint)        
insert into @results        
select
    sra.surveyResponseAnswerObjectId objectId
from
    Comment c
INNER JOIN
    @surveyResponseAnswers sra
        on c.surveyResponseAnswerObjectId = sra.surveyResponseAnswerObjectId
where
    c.commentType = 1
    and c.transcriptionState = 0

Select @diffSecs = DATEDIFF(second,@startTime,getdate())

IF (@diffSecs < @warning)
Select 'Transcription Time: '+ cast(@diffSecs as varchar)+' |  ''Transcription Time''='+ cast(@diffSecs as varchar) as output, 0 as stateValue
IF (@diffSecs >= @warning and @diffSecs < @critical)
Select 'Transcription Time: '+ cast(@diffSecs as varchar)+' |  ''Transcription Time''='+ cast(@diffSecs as varchar) as output, 1 as stateValue
IF (@diffSecs >= @critical)
Select 'Transcription Time: '+ cast(@diffSecs as varchar)+' |  ''Transcription Time''='+ cast(@diffSecs as varchar) as output, 2 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
