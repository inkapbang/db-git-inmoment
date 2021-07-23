SET QUOTED_IDENTIFIER ON 
GO
CREATE            FUNCTION GetSurveyPromptTree (@surveyObjectId INT)
RETURNS @prompts TABLE (promptObjectId int)
AS
BEGIN

	DECLARE @stepId INT, @promptObjectId INT, @loyalPromptObjectId INT
	DECLARE @swingPromptObjectId INT, @upsetPromptObjectId INT
	
	DECLARE componentCursor CURSOR LOCAL FOR
		SELECT objectId
		FROM SurveyStep
		WHERE surveyObjectId = @surveyObjectId
		ORDER BY Sequence

	OPEN componentCursor

	FETCH NEXT FROM componentCursor INTO @stepId
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		DECLARE promptCursor CURSOR LOCAL FOR
			SELECT promptObjectId
			FROM SurveyStepPrompt
			WHERE surveyStepObjectId = @stepId
			ORDER BY Sequence

		OPEN promptCursor
	
		FETCH NEXT FROM promptCursor INTO @promptObjectId
		WHILE @@FETCH_STATUS = 0
		BEGIN

			IF @promptObjectId IS NOT NULL 
			BEGIN
				INSERT INTO @prompts SELECT promptObjectId FROM dbo.GetPromptTree(@promptObjectId)
			END
			
			FETCH NEXT FROM promptCursor INTO @promptObjectId
		END

		CLOSE promptCursor
		DEALLOCATE promptCursor

		FETCH NEXT FROM componentCursor INTO @stepId
	END
	
	CLOSE componentCursor
	DEALLOCATE componentCursor

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO

GO
