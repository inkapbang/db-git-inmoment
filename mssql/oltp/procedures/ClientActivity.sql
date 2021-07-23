SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  PROCEDURE [dbo].[ClientActivity]
	@beginDate datetime,
	@endDate datetime AS

	SELECT O.objectId AS orgId, O.name AS org, L.name AS location,
		CONVERT(varchar(10), SR.beginDate, 101) AS callDate,
		SUM(CONVERT(int, SR.complete)) AS complete,
		COUNT(*) - SUM(CONVERT(int, SR.complete)) AS incomplete,
		COUNT(*) AS totalCalls,
		SUM(CASE SR.complete
			WHEN 1 THEN CAST(ROUND(minutes * 60, 0) AS INTEGER)
			ELSE 0
			END) AS completeTime,
		SUM(CASE SR.complete
			WHEN 0 THEN CAST(ROUND(minutes * 60, 0) AS INTEGER)
			ELSE 0
			END) AS incompleteTime,
		SUM(minutes) AS totalTime,
		AVG(CASE SR.complete
			WHEN 1 THEN CAST(ROUND(minutes * 60, 0) AS INTEGER)
			ELSE 0
			END) AS averageCompleteTime
	FROM Organization O
	INNER JOIN Location L ON L.organizationObjectId = O.objectId INNER JOIN SurveyResponse SR ON SR.locationObjectId = L.objectId
	WHERE SR.beginDate >= @beginDate AND SR.beginDate < DATEADD(day, 1, @endDate)
	GROUP BY O.name, L.name, CONVERT(varchar(10), SR.beginDate, 101), O.objectId
	ORDER BY O.name, L.name, CONVERT(varchar(10), SR.beginDate, 101)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
