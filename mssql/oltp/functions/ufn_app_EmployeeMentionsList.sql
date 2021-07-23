SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_EmployeeMentionsList] (@responseId INT)
RETURNS TABLE
AS
RETURN
	SELECT SUBSTRING(
	(
		SELECT ', ' + ta.employeeName, ': ' + CAST(COUNT(*) AS VARCHAR)
			FROM SurveyResponseAnswer sra 
				INNER JOIN Comment c ON c.surveyResponseAnswerObjectId = sra.objectId
				INNER JOIN TagAnnotation ta ON ta.commentId = c.objectId
			WHERE sra.surveyResponseObjectId = @responseId AND ta.employeeName IS NOT NULL
		GROUP BY ta.employeeName
		ORDER BY COUNT(*) DESC, ta.employeeName
		FOR XML PATH('')
    )
    , 3, 9999999) AS employeeNameCountList
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
