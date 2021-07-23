SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/********************************/
CREATE FUNCTION [dbo].[ufn_app_ResponseStateHistory] (@responseId INT)
RETURNS TABLE
AS
RETURN
WITH src AS (
	SELECT
		surveyResponseObjectId,
		objectId responseStateObjectId,
		ROW_NUMBER() OVER (PARTITION BY surveyResponseObjectId ORDER BY datestamp) actionNum,
		COUNT(*) OVER (PARTITION BY surveyResponseObjectId) actionCount,
		datestamp,
		userAccountObjectId,
		stateType,
		comments
	FROM
		SurveyResponseNote
	WHERE
		surveyResponseObjectId = @responseId
)
SELECT
	s1.surveyResponseObjectId,
	s1.responseStateObjectId,
	s1.datestamp actionDate,
	s1.stateType,
	s1.actionNum,
	s1.actionCount,
	s2.dateStamp nextActionDate,
	DATEDIFF(day, s1.datestamp, s2.datestamp) ageDays,
	s1.userAccountObjectId,
	s1.comments
FROM
	src s1
	LEFT OUTER JOIN src s2
		ON s2.actionNum = s1.actionNum + 1
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
