SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[GetSurveyFieldTree] (@surveyObjectId int, @fieldType int = null)
/*
 * Returns a complete list of datafield ids used by a survey.
 * Optionally, a datafield classtype can be provided, and only
 * the datafield ids of that classtype will be returned.
 *
 * Author: jmartin
 * Date:   5 Jan 2007
 *
 * History
 * -------
 *
 * 5 Jan 2007  Created to replace an earlier version which used a set
 *             of stored procs (GetSurveyPromptTree, GetPromptTree)
 *             which used cursors and recursion to retrieve data.
 *             The CTE also contains a statement to prevent infinite loops
 *             due to circular references in the prompts.
 */
returns table
as return
(
   with PromptTreeCTE ( promptObjectId, previous )
   as
   (
      select promptObjectId, previous = cast( '' as varchar(300) )
      from SurveyStepPrompt
      where surveyStepObjectId in ( select objectId from SurveyStep where surveyObjectId = @surveyObjectId)
   
      union all
   
      select
         pep.promptObjectId,
         previous = (cast(ptcte.previous + ':' + convert(varchar,pep.promptObjectId) as varchar(300) ) )
      from PromptEventActionPrompt pep
      inner join PromptEventAction pea on pea.objectId = pep.promptEventActionObjectId
      inner join PromptEvent pe on pe.objectId = pea.promptEventObjectId
      inner join PromptTreeCTE ptcte on pe.promptObjectId = ptcte.promptObjectId
      where ptcte.previous not like ( '%' + convert(varchar,pep.promptObjectId) + '%')
   )
 
   select distinct
      df.objectId
   from
      DataField df
   inner join Prompt p on p.dataFieldObjectId = df.objectId
   inner join PromptTreeCTE as ptcte on ptcte.promptObjectId = p.objectId
   where df.fieldType = coalesce(@fieldType, df.fieldType)   
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
