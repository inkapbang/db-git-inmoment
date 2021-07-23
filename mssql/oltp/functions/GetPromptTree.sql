SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
   replaces existing recursive GetPromptTree function with a CTE-based sql statement. This is *much* faster.
   tested on powderkeg, returns same results for every survey.
   replication *does not* update the function on skipper.
 
   updated 8 Jan 2007 by jmartin
   changed previous function to use a CTE, which is faster
   and contains code to prevent blowups due to circular references
 
   updated 20 June 2007 by jmartin
   changed to use nvarchars
*/
 
-- Update prompt tree function
CREATE FUNCTION [dbo].[GetPromptTree] (@promptObjectId INT)
RETURNS @prompts TABLE (promptObjectId INT)
AS
BEGIN
    
   INSERT INTO @prompts (promptObjectId) VALUES (@promptObjectId);
 
   with PromptTreeCTE ( promptObjectId, previous )
   as
   (
      --select promptObjectId, previous = cast( '' as varchar(200) )
      --from SurveyStepPrompt
      --where surveyStepObjectId in ( select objectId from SurveyStep where surveyObjectId = @surveyObjectId)
      SELECT
         PromptEventActionPrompt.promptObjectId, previous = cast( N'' as nvarchar(300) )
      FROM PromptEventActionPrompt
      JOIN PromptEventAction on PromptEventAction.objectId = PromptEventActionPrompt.promptEventActionObjectId
      JOIN PromptEvent on PromptEvent.objectId = PromptEventAction.promptEventObjectId
      WHERE PromptEvent.promptObjectId = @promptObjectId
      
      union all
   
      select
         pep.promptObjectId,
         previous = (cast(ptcte.previous + N':' + convert(nvarchar,pep.promptObjectId) as nvarchar(300) ) )
      from PromptEventActionPrompt pep
      inner join PromptEventAction pea on pea.objectId = pep.promptEventActionObjectId
      inner join PromptEvent pe on pe.objectId = pea.promptEventObjectId
      inner join PromptTreeCTE ptcte on pe.promptObjectId = ptcte.promptObjectId
      where ptcte.previous not like ( N'%' + convert(nvarchar,pep.promptObjectId) + N'%')
   )
   INSERT INTO @prompts select distinct promptObjectId from PromptTreeCTE
 
   RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
