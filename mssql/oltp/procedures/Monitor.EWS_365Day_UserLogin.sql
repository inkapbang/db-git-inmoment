SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*****************************************************  Login Portion Below  *********************************************************************/
--DROP Procedure Monitor.EWS_365Day_UserLogin
CREATE Procedure Monitor.EWS_365Day_UserLogin
--ALTER Procedure Monitor.EWS_365Day_UserLogin
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
    WHERE [Date] > @Yesterday -365
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
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Monitor.EWS_365Day_UserLogin_Results') AND type = (N'U'))    DROP TABLE Monitor.EWS_365Day_UserLogin_Results
SELECT
		t100.OrganizationObjectId
		, t100.OrgName
		, t100.[Date]
		, ISNULL( t101.UniqueLogins, 0 )																				AS UniqueLogins
		, ISNULL( t102.Logins, 0 )																						AS [AccessLogins]
		, CAST( ISNULL( t102.Logins, 0 ) / CAST( NULLIF( t103.[Users], 0 )	 AS FLOAT )	as DECIMAL (10, 2)  )			AS [Logins/Users]
	
INTO Monitor.EWS_365Day_UserLogin_Results
	
FROM
		##EWS_DailyBase		t100
		
	LEFT JOIN
	
		(	
			--Unique Logins
			SELECT
					t20.OrganizationObjectId
					, t365.[Date]
					, COUNT(1)		AS UniqueLogins


			FROM
					UserAccount					t10 WITH (NOLOCK)
				JOIN
					OrganizationUserAccount		t20	WITH (NOLOCK)
						ON t10.objectId = t20.UserAccountObjectId
				JOIN
					(
						SELECT
								DISTINCT UserAccountObjectId
								, CAST( TimeStamp   as DATE )		AS [Date]


						FROM
								AccessEventLog			t10
						WHERE
								TimeStamp
											BETWEEN
													@StartUtcDateTime
												AND
													@EndUtcDateTime

					)	t365
							ON t20.UserAccountObjectId = t365.UserAccountObjectId

			GROUP BY
					t20.OrganizationObjectId
					, t365.Date		

		)	AS t101
				ON t100.OrganizationObjectId = t101.OrganizationObjectId AND t100.[Date] = t101.[Date]

				
	LEFT JOIN
	
		(	
			--Access/Logins
			SELECT
					t20.OrganizationObjectId
					, t365.[Date]
					, COUNT(1)		AS Logins


			FROM
					UserAccount					t10 WITH (NOLOCK)
				JOIN
					OrganizationUserAccount		t20	WITH (NOLOCK)
						ON t10.objectId = t20.UserAccountObjectId
				JOIN
					(
						SELECT
								UserAccountObjectId
								, CAST( TimeStamp   as DATE )		AS [Date]


						FROM
								AccessEventLog			t10
						WHERE
								TimeStamp
											BETWEEN
													@StartUtcDateTime
												AND
													@EndUtcDateTime

					)	t365
							ON t20.UserAccountObjectId = t365.UserAccountObjectId

			GROUP BY
					t20.OrganizationObjectId
					, t365.Date		

		)	AS t102
				ON t100.OrganizationObjectId = t102.OrganizationObjectId AND t100.[Date] = t102.[Date]
				
	LEFT JOIN
		(
			--Users
			SELECT
					OrganizationObjectId
					, COUNT(1)					AS [Users]
					
			FROM		
					OrganizationUserAccount
			GROUP BY
					OrganizationObjectId
					
		)	AS t103
				ON t100.OrganizationObjectId = t103.OrganizationObjectId 


ORDER BY
		t100.OrgName
		, t100.[Date]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
