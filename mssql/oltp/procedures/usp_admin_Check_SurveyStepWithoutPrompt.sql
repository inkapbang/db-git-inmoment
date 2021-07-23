SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc usp_admin_Check_SurveyStepWithoutPrompt
as

declare @count int

declare @results table(
Org varchar(50),surveyname Varchar(50),SurveyObjectid int, SurveyStepObjectid int,
SurveyStepName varchar(50)
)
insert into @results
select o.name ,s.name ,s.objectid ,ss.objectid ,ss.name 
--select o.name Org,s.name SurveyName,s.objectid 'Surveyobjectid',ss.objectid SurveyStepObjectid,ss.name SurveyStepName
from surveystep ss with (Nolock) join survey s with (Nolock)
on s.objectid=ss.surveyobjectid join organization o with (Nolock)
on s.organizationobjectid = o.objectid
where ss.objectid not in (
select surveystepobjectid from surveystepprompt)
--and ss.objectid not in (
--20535,
--16556,
--18404,
--18406,
--18400,
--18402,
--18411,
--18412,
--21465,
--21523,
--20756,
--22893,
--23164,
--23196,
--25561)

select * from @results

--exec usp_admin_Check_SurveyStepWithoutPrompt
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
