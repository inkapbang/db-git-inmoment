SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  FUNCTION ResponseHasAlerts(@surveyResponseObjectId INT)  
RETURNS BIT  AS  
BEGIN
	DECLARE @count INT
	SELECT @count = count(*) FROM SurveyResponseAlert
		WHERE  SurveyResponseAlert.surveyResponseObjectId = @surveyResponseObjectId
	RETURN CASE @count WHEN 0 THEN 0 ELSE 1 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
