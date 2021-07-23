SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
---------------------------


CREATE  FUNCTION [dbo].[GetResponseComment] (@surveyResponseObjectId INT)
RETURNS VARCHAR(500) AS  
BEGIN 
	DECLARE @idList VARCHAR(500)
	DECLARE commentCursor CURSOR LOCAL FOR
		SELECT 
			Comment.objectId commentObjectId 
		FROM Comment
		JOIN SurveyResponseAnswer
			ON Comment.surveyResponseAnswerObjectId = SurveyResponseAnswer.objectId
		WHERE 
			SurveyResponseAnswer.surveyResponseObjectId = @surveyResponseObjectId
	OPEN commentCursor
	DECLARE @commentObjectId INT
	DECLARE @delim AS VARCHAR(2)
	SET @delim = ''
	FETCH NEXT FROM commentCursor INTO @commentObjectId
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @idList IS NULL
			SET @idList = ''
		SET @idList = @idList + @delim + CAST(@commentObjectId AS VARCHAR(15))
		SET @delim = ', '
		FETCH NEXT FROM commentCursor INTO @commentObjectId
	END
	CLOSE commentCursor
	DEALLOCATE commentCursor

	RETURN @idList
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
