SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*****************************************************  Manual Reports Portion Below  *********************************************************************/
--DROP Procedure Monitor.EWS_30Day_ManualReports
--CREATE Procedure Monitor.EWS_30Day_ManualReports
CREATE Procedure Monitor.EWS_30Day_ManualReports
AS
/*****************************************  EWS Project  *****************************************

	Must be run on OLTP for now do to incompletes.

	History
		4.8.2013	Tad Peterson
			-- Created
		
		4.25.213	Tad Peterson
			-- Converted to Stored Procedure, Job refreshses data daily

		8.13.2013	Tad Peterson
			-- Changed to 30 days
			-- added OPTION (maxrecursion 0)

		10.14.2013	Tad Peterson
			-- changed back to 30 days
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
SET		@StartUtcDateTime	= DATEADD( Day, -30, @EndUtcDateTime )


--SELECT @StartUtcDateTime	AS StartUTCDateTime, @EndUtcDateTime	AS EndUTCDateTime





-- Builds Enabled Organiization 30 day table starting yesterday.
DECLARE @Yesterday		dateTime
SET		@Yesterday		= DATEADD( DAY, -1, GETDATE() )


IF OBJECT_ID('tempdb..##EWS_DailyBase') IS NOT NULL			DROP TABLE ##EWS_DailyBase
;WITH CTE AS
(
    SELECT convert(date,@Yesterday) [Date], DATENAME(DW, @Yesterday) [DayOfWeek]
    UNION ALL
    SELECT DATEADD(DAY,-1,[Date]), DATENAME(DW, DATEADD(DAY,-1,[Date]))
    FROM CTE
    WHERE [Date] > @Yesterday -30
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
--OPTION (maxrecursion 0)		







-- Results Table
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Monitor.EWS_30Day_ManualReports_Results') AND type = (N'U'))    DROP TABLE Monitor.EWS_30Day_ManualReports_Results
SELECT
		t100.OrganizationObjectId
		, t100.OrgName
		, t100.[Date]

		--Manual Reports Qnty 
		, ISNULL( t102.ManualReportsQnty, 0 )											AS ManualReportsQnty


		--Manual to User Ratio
		, CAST( ISNULL( t102.ManualReportsQnty, 0 ) / CAST( NULLIF( t101.Users, 0 )  AS FLOAT )		AS DECIMAL ( 10, 2 ) )		AS [ManualReports/Users]

INTO Monitor.EWS_30Day_ManualReports_Results		

FROM
		##EWS_DailyBase		t100

	LEFT JOIN

		(	
			--Users
			SELECT
					t20.OrganizationObjectId
					, COUNT(1)					AS Users

			FROM
					UserAccount					t10 WITH (NOLOCK)
				JOIN
					OrganizationUserAccount		t20	WITH (NOLOCK)
						ON t10.objectId = t20.UserAccountObjectId

			GROUP BY
					t20.OrganizationObjectId		
		)	AS t101
				ON t100.OrganizationObjectId = t101.OrganizationObjectId

		
	LEFT JOIN

		(	
			--Automated Manual Reports
			SELECT
					t10.OrganizationObjectId
					, CAST( t20.creationDateTime	AS DATE )											AS [Date]
					, SUM( CASE WHEN PageScheduleObjectId IS NOT NULL	THEN 1 ELSE 0	END )			AS AutomatedReportsQnty
					, SUM( CASE WHEN PageScheduleObjectId IS NULL		THEN 1 ELSE 0	END )			AS ManualReportsQnty

			FROM
					page							t10 WITH (NOLOCK)
				JOIN 
					pageLogEntry					t20 WITH (NOLOCK)
							ON t10.objectId = t20.pageObjectId
			WHERE
					t20.creationDateTime
											BETWEEN 
													@StartUtcDateTime 
												AND	
													@EndUtcDateTime
			GROUP BY 
					t10.OrganizationObjectId
					, CAST( t20.creationDateTime	AS DATE )
		)	AS t102
				ON t100.OrganizationObjectId = t102.OrganizationObjectId AND t100.[Date] = t102.[Date]


ORDER BY
		t100.OrgName
		, t100.[Date]



		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
