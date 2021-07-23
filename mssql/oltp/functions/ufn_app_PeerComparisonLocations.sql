SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_PeerComparisonLocations](
      @locationCategoryId INT,                  -- The category to find locations in
      @minResponseCount INT,                    -- The minimum response count for locations to be considered (null value = zero)
      @minResponseCountBeginDate DATETIME,      -- The begin date to find min response counts for
      @minResponseCountEndDate DATETIME,        -- The end date to find min response counts for
      @feedbackChannelId INT)                   -- The feedback channel the data is contained in
RETURNS TABLE
AS RETURN (
	SELECT
		cl.locationObjectId,
		COUNT(sr.objectId) AS responseCount
	FROM
		dbo.GetCategoryLocations(@locationCategoryId) cl
		JOIN Location l -- filter the Hidden Locations
			ON l.objectId = cl.locationObjectId
			AND l.hidden = 0
		LEFT OUTER JOIN ( -- outer join responses
			SurveyResponse sr
			JOIN Offer o
				ON o.objectId = sr.offerObjectId
				AND channelObjectId = @feedbackChannelId
				AND sr.beginDate BETWEEN @minResponseCountBeginDate AND @minResponseCountEndDate
				AND sr.complete = 1
				AND sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results 
		) ON sr.locationObjectId = cl.locationObjectId
	GROUP BY
		cl.locationObjectId
	HAVING
		COUNT(sr.objectId) >= COALESCE(@minResponseCount, 0)
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
