SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION ResponseHasBinaryContent(@surveyResponseObjectId INT)  
RETURNS BIT  AS  
BEGIN
	DECLARE @count INT
	SELECT @count = count(*) FROM SurveyResponseAnswer
		WHERE  SurveyResponseAnswer.surveyResponseObjectId = @surveyResponseObjectId AND
			SurveyResponseAnswer.binaryContentObjectId IS NOT NULL
	RETURN CASE @count WHEN 0 THEN 0 ELSE 1 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
