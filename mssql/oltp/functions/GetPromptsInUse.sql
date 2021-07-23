SET QUOTED_IDENTIFIER ON 
GO
CREATE  FUNCTION GetPromptsInUse(@orgId INT) 
RETURNS @prompts TABLE (promptObjectId INT)
AS
BEGIN
	DECLARE @allPrompts TABLE (promptObjectId INT)
	DECLARE @surveyId INT
	DECLARE surveyCursor CURSOR LOCAL FOR
		SELECT objectId from Survey
		WHERE organizationObjectId = @orgId
		ORDER BY [name]

	OPEN surveyCursor
	FETCH NEXT FROM surveyCursor INTO @surveyId
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @allPrompts SELECT promptObjectId FROM dbo.GetSurveyPromptTree(@surveyId)
		FETCH NEXT FROM surveyCursor INTO @surveyId
	END
	CLOSE surveyCursor
	DEALLOCATE surveyCursor

	INSERT INTO @prompts SELECT distinct promptObjectId FROM @allPrompts

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO

GO
