SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE proc [Monitor].[SurveyStepWithoutPrompt_OpsView]
CREATE proc [Monitor].[SurveyStepWithoutPrompt_OpsView]

as

declare @count int
DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)

declare @results table(Org varchar(100),surveyname Varchar(100),SurveyObjectid int, SurveyStepObjectid int,SurveyStepName varchar(50))

insert into @results
select o.name ,s.name ,s.objectid ,ss.objectid ,ss.name 
from surveystep ss with (Nolock) join survey s with (Nolock)
on s.objectid=ss.surveyobjectid join organization o with (Nolock)
on s.organizationobjectid = o.objectid
where ss.objectid not in (
select surveystepobjectid from surveystepprompt)
and o.objectId not in (941)

select @count= count(*) from @results

--IF OBJECT_ID('tempdb..##SurveyStepWithoutPrompt_OpsView') IS NOT NULL DROP TABLE ##SurveyStepWithoutPrompt_OpsView		
--select * into ##SurveyStepWithoutPrompt_OpsView FROM @results


DECLARE @ForEmailCount int
SET		@ForEmailCount = ( SELECT COUNT(1)		FROM @results )

IF @ForEmailCount > 0
BEGIN

		-- Sending email notification
		DECLARE @xml   						nvarchar(Max)
		DECLARE @body   					nvarchar(Max)



		SET @xml = CAST(( 


		SELECT 	
				Org																			
												AS 'td',''
				, SurveyName
												AS 'td',''
				, SurveyObjectId
												AS 'td',''
				, SurveyStepObjectId
												AS 'td',''
				, SurveyStepName
												AS 'td'
		FROM 
				@results  
				  


				
		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


		-----Header Naming and Column Naming below

		SET @body =											
															'<html><body><H1><font color="#4040C5">
		Notification													
															</font></H1><br /><H4>													
		Survey Step Without Prompt
															</H4><table border = 2><tr><th>	
		Organization								
															</th><th>
		Survey Name	
															</th><th>
		Survey ObjectId	
															</th><th>
		Survey Step ObjectId
															</th><th>
		Survey Step Name			
															</th></tr>'    

		 
		SET @body = @body + @xml +'</table></body></html>'




		EXEC msdb.dbo.sp_send_dbmail
		@profile_name					= 'Notification'
		, @recipients					= 'OpsGlobal@InMoment.com'
		, @copy_recipients 				= 'dba@inmoment.com'
		, @reply_to						= 'dba@mshare.net'
		, @subject						= 'Survey Steps Without Prompt - PLEASE FIX'
		, @body_format					= 'HTML'
		, @body							= @body

END





if @count = 0

Select 'No Survey Steps without prompts |  ''Survey Step Without Prompts''=0' as output, 0 as stateValue
ELSE
Select 'Survey Steps without prompts: '+ cast(@count as varchar)+' |  ''Survey Step Without Prompts''='+ cast(@count as varchar) as output, 2 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
