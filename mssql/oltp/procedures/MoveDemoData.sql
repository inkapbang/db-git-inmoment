SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[MoveDemoData] (@months INT)
AS
BEGIN
	UPDATE SurveyResponse SET
		beginDate = DateAdd(month, @months, beginDate),
		dateOfService = DateAdd(month, @months, dateOfService),
		beginDateUTC = DateAdd(month, @months, beginDateUTC)
	WHERE objectId IN 
		(select SurveyResponse.objectId
			FROM SurveyResponse INNER JOIN Survey
				ON SurveyResponse.surveyObjectId = Survey.objectId
			WHERE Survey.organizationObjectId = 171)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
