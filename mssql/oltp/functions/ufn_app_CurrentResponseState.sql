SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_CurrentResponseState](@responseId INT)
RETURNS TABLE AS
RETURN
	SELECT TOP 1 
		srn.[objectId], 
		srn.[datestamp], 
		srn.[userAccountObjectId], 
		srn.[surveyResponseObjectId], 
		srn.[stateType], 
		srn.[comments]
	FROM 
		SurveyResponseNote srn
	WHERE 
		srn.[surveyResponseObjectId] = @responseId
	ORDER BY 
		srn.[datestamp] DESC;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
