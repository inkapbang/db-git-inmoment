SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--DROP Procedure Monitor.EWS_365Day_SurveyCompletion
CREATE Procedure Monitor.EWS_365Day_SurveyCompletion
--ALTER Procedure Monitor.EWS_365Day_SurveyCompletion
AS
/*****************************************  EWS Project  *****************************************

	Must be run on OLTP for now do to incompletes.

	History
		10.14.2013	Tad Peterson
			-- added surveyVolume 365 day table
			-- added login items 365 day table
			
			
*************************************************************************************************/
-- This creates a between for last hour, even when it crosses midnight.
DECLARE @UtcDateTime		dateTime
		, @StartUtcDateTime dateTime
		, @EndUtcDateTime	dateTime
		, @adjHour			int
		, @adjMinute		int
		, @adjSec			int
		, @adjMilsec		int



SET		@UtcDateTime		= ( SELECT GETUTCDATE() )
SET		@adjHour			= DATEPART( Hour		, @UtcDateTime )
SET		@adjMinute			= DATEPART( Minute		, @UtcDateTime )
SET		@adjSec				= DATEPART( Second		, @UtcDateTime )
SET		@adjMilsec			= DATEPART( Millisecond	, @UtcDateTime )


SET		@EndUtcDateTime		= DATEADD( Hour, -(@adjHour), DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) ) )
SET		@StartUtcDateTime	= DATEADD( Day, -365, @EndUtcDateTime )


--SELECT @StartUtcDateTime	AS StartUTCDateTime, @EndUtcDateTime	AS EndUTCDateTime





-- Builds Enabled Organiization 365 day table starting yesterday.
DECLARE @Yesterday		dateTime
SET		@Yesterday		= DATEADD( DAY, -1, GETDATE() )


IF OBJECT_ID('tempdb..##EWS_DailyBase') IS NOT NULL			DROP TABLE ##EWS_DailyBase
;WITH CTE AS
(
    SELECT convert(date,@Yesterday) [Date], DATENAME(DW, @Yesterday) [DayOfWeek]
    UNION ALL
    SELECT DATEADD(DAY,-1,[Date]), DATENAME(DW, DATEADD(DAY,-1,[Date]))
    FROM CTE
    WHERE [Date] > @Yesterday - 365
)		
SELECT
		ObjectId						AS OrganizationObjectId
		, Name							AS OrgName
		, t20.[Date]

INTO ##EWS_DailyBase

FROM
		Organization		t10
	CROSS JOIN
		CTE					t20
WHERE
		Enabled = 1


ORDER BY
		t10.ObjectId
		, t20.[Date]
OPTION (maxrecursion 0)		







-- Results Table
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Monitor.EWS_365Day_SurveyCompletion_Results') AND type = (N'U'))    DROP TABLE Monitor.EWS_365Day_SurveyCompletion_Results
SELECT
		t100.OrganizationObjectId
		, t100.OrgName
		, t100.[Date]
		, ISNULL( t101.Incomplete, 0 )		AS Incomplete
		, ISNULL( t101.Complete, 0 )		AS Complete

INTO Monitor.EWS_365Day_SurveyCompletion_Results	

FROM
		##EWS_DailyBase		t100
		
	LEFT JOIN
	
		(	
			SELECT
					t10.OrganizationObjectId
					, CAST( t20.BeginDate	as DATE)											AS [Date]
					, SUM( CASE WHEN t20.complete = 1	THEN 1		ELSE 0		END )			AS Complete
					, SUM( CASE WHEN t20.complete = 0	THEN 1		ELSE 0		END )			AS Incomplete

			FROM
					Survey				t10
				JOIN
					SurveyResponse		t20
						ON t10.objectId	= t20.surveyObjectId

			WHERE
					t20.beginDateUTC BETWEEN
											@StartUtcDateTime
										AND
											@EndUtcDateTime

				AND	
					t20.ExclusionReason = 0

			GROUP BY
					t10.OrganizationObjectId
					, t20.BeginDate

		) 	AS t101
				ON t100.OrganizationObjectId = t101.OrganizationObjectId AND t100.[Date] = t101.[Date]

ORDER BY
		t100.OrgName
		, t100.[Date]


		


		
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
