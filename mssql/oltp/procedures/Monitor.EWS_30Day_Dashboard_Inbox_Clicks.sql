SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*****************************************************  Dashboard & Inbox Click Portion Below  *********************************************************************/
--DROP Procedure Monitor.EWS_30Day_Dashboard_Inbox_Clicks
--CREATE Procedure Monitor.EWS_30Day_Dashboard_Inbox_Clicks
CREATE Procedure Monitor.EWS_30Day_Dashboard_Inbox_Clicks
AS
/*****************************************  EWS Project  *****************************************

	Must be run on OLTP for now do to incompletes.

	History
		7.24.2013	Tad Peterson
			-- Create and added to EWS 30Day Project
		
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
OPTION (maxrecursion 0)		






-- Dashboard & Indox Clicks Info
IF OBJECT_ID('tempdb..##EWS_DashBoardInboxClicks') IS NOT NULL			DROP TABLE ##EWS_DashBoardInboxClicks
;WITH CTE AS
(
    SELECT convert(date,@Yesterday) [Date], DATENAME(DW, @Yesterday) [DayOfWeek]
    UNION ALL
    SELECT DATEADD(DAY,-1,[Date]), DATENAME(DW, DATEADD(DAY,-1,[Date]))
    FROM CTE
    WHERE [Date] > @Yesterday -30
)		
SELECT
		OrganizationId
		, Page
		, CAST(clickDate as Date )	AS ClickDate
		, Count(objectId)			AS ClickCount


INTO ##EWS_DashBoardInboxClicks


		 
FROM
		AppTracking			t10
	CROSS JOIN
		CTE					t20

WHERE
		page LIKE 'inbox/Inbox'
	OR
		page LIKE 'DashboardPage2'
	

GROUP BY
		OrganizationId
		, Page
		--, clickDate
		, CAST(clickDate as Date )


ORDER BY
		OrganizationId
		, CAST(clickDate as Date )
--OPTION (maxrecursion 0)		





-- Testing
--SELECT *	FROM ##EWS_DashboardInboxClicks


-- Results Table
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Monitor.EWS_30Day_DashboardInbox_Clicks_Results') AND type = (N'U'))    DROP TABLE Monitor.EWS_30Day_DashboardInbox_Clicks_Results
SELECT


		t100.OrganizationObjectId
		, t100.OrgName
		, t100.[Date]

		-- Dashboard
		, t110.ClickType			AS Dashboard_ClickType
		, t110.ClickCount			AS Dashboard_ClickCount

		-- Inbox
 		, t120.ClickType			AS Inbox_ClickType
		, t120.ClickCount			AS Inbox_ClickCount


INTO Monitor.EWS_30Day_DashboardInbox_Clicks_Results				

		
FROM

		##EWS_DailyBase		t100

	LEFT JOIN

		(
			-- Dashboard Clicks
			SELECT
					OrganizationId													AS OrganizationObjectId
					, CASE WHEN Page LIKE 'DashboardPage2' THEN 'Dashboard' END		AS ClickType
					, ClickDate	
					, ClickCount


			FROM

					##EWS_DashBoardInboxClicks

			WHERE
					page LIKE 'DashboardPage2'


		)	AS t110
				ON t100.OrganizationObjectId = t110.OrganizationObjectId AND t100.[Date] = t110.ClickDate

	LEFT JOIN
		
		(
			-- Inbox Clicks
			SELECT
					OrganizationId												AS OrganizationObjectId
					, CASE WHEN Page LIKE 'inbox/Inbox' THEN 'Inbox' END		AS ClickType
					, ClickDate	
					, ClickCount

			FROM

					##EWS_DashBoardInboxClicks

			WHERE
					page LIKE 'inbox/Inbox'

	)	AS t120
			ON t100.OrganizationObjectId = t120.OrganizationObjectId AND t100.[Date] = t120.ClickDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
