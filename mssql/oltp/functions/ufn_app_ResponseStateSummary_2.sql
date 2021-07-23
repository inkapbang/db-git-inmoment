SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_ResponseStateSummary_2] (@responseId INT, @localeKey VARCHAR(25))
RETURNS TABLE
AS
RETURN
SELECT
	surveyResponseObjectId,
	firstActionDate,
	firstActionAge,
	lastActionDate,
	secondActionDate,
	actionCount,
	CASE WHEN lastStateType = 2 THEN totalAge
		ELSE DATEDIFF(day, firstActionDate, GETDATE()) END totalAge,
	lastUserAccountObjectId,
	lastStateType,
	lastComment
FROM(
	SELECT
		surveyResponseObjectId,
		MIN(actionDate) firstActionDate,
		MAX(CASE WHEN actionNum = 1 THEN ageDays END) firstActionAge,
		MAX(actionDate) lastActionDate,
		MAX(CASE WHEN actionNum = 2 THEN actionDate END) secondActionDate,
		MAX(actionCount) actionCount,
		SUM(ageDays) totalAge,
		MAX(CASE WHEN actionNum = actionCount THEN userAccountObjectId END) lastUserAccountObjectId,
		MAX(CASE WHEN actionNum = actionCount THEN stateType END) lastStateType,
		MAX(CASE WHEN actionNum = actionCount THEN comments END) lastComment
	FROM
		dbo.ufn_app_ResponseStateHistory_2(@responseId, @localeKey)
	GROUP BY
		surveyResponseObjectId
	) summary
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
