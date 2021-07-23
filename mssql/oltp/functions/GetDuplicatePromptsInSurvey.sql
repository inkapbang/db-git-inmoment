SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[GetDuplicatePromptsInSurvey] (@surveyObjectId int)

/*
 * Returns a list of prompts and lineage that are used more than once in
 * a survey. This is being used to clean this up so it can go away
 *
 * Author: dnewbold
 * Date:   03/13/2007
 *
 * History
 * -------
 *
 * 03/13/2007	Created.
 */

returns table
as
return
(
   with PromptTreeCTE ( promptObjectId, path )
   as
   (
      select promptObjectId, path = cast( promptObjectId as varchar(300) )
      from SurveyStepPrompt
      where surveyStepObjectId in ( select objectId from SurveyStep where surveyObjectId = @surveyObjectId)
   
      union all
   
      select
         pep.promptObjectId,
         path = (cast(ptcte.path + ':' + convert(varchar,pep.promptObjectId) as varchar(300) ) )
      from PromptEventActionPrompt pep
      inner join PromptEventAction pea on pea.objectId = pep.promptEventActionObjectId
      inner join PromptEvent pe on pe.objectId = pea.promptEventObjectId
      inner join PromptTreeCTE ptcte on pe.promptObjectId = ptcte.promptObjectId
      where ptcte.path not like ( '%' + convert(varchar,pep.promptObjectId) + '%')
   )

	select 
		p.objectId as promptObjectId, pt.path as path, p.name as promptName, p.organizationObjectId as promptOrganizationObjectId, p.promptType as promptType
	from
		PromptTreeCTE as pt
		inner join Prompt p on pt.promptObjectId = p.objectId		
   where
		p.objectId in (select pt.promptObjectId from PromptTreeCTE pt group by pt.promptObjectId having count(pt.promptObjectId) > 1)
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
