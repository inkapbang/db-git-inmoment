SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE PROCEDURE Monitor.ClientEngagement_v2
CREATE PROCEDURE [Monitor].[ClientEngagement_v2]
AS

/*********************************************  Client Engagement  *********************************************

	Runs on DOCTOR for pearModel query and incompletes.

	Requested by: 	Jon Grover


	History:		
		3.11.2013 	Tad Peterson	
			-- created and written
			
		3.21.2013	Tad Peterson
			-- changed query for warehouse execution, via Doctor.Mindshare.dbo.PearModel
			
		4.10.2013	Tad Peterson			
			-- added removal of secondary account managers
			-- added the testOrg Flag
			-- removed emailCampaign column
			
		5.1.2013	Tad Peterson
			-- moved to stored procedure on Doctor as Monitor.ClientEngagement_v2

***************************************************************************************************************/

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


SELECT @StartUtcDateTime	AS StartUTCDateTime, @EndUtcDateTime	AS EndUTCDateTime






IF OBJECT_ID('tempdb..##ClientEngagement') IS NOT NULL			DROP TABLE ##ClientEngagement		
SELECT
		ROW_NUMBER() OVER(ORDER BY t100.OrgName ASC)		AS RowId
		
		--Organization Information
		, t100.OrganizationObjectId
		, t100.OrgName
		, CAST( t100.OrgEnabled AS INT )					AS OrgEnabled


		--AccountManager
		, t101.AccountManager


		--Enabled Locations & Size
		, ISNULL( t102.ActiveLocationQnty, 0 )											AS ActiveLocationQnty
		, ISNULL( t102.Size, 0 )														AS Size


		--VoiceQnty, WebQnty, Complete, Incomplete, CompleteRate
		, ISNULL( t103.VoiceSurveyQnty, 0 )												AS VoiceSurveyQnty
		, ISNULL( t103.WebSurveyQnty, 0 )												AS WebSurveyQnty
		, ISNULL( t103.Complete, 0 )													AS Complete
		, ISNULL( t103.Incomplete, 0 )													AS Incomplete
		, ISNULL( t103.CompleteRate, 0 )												AS CompleteRate
		, ISNULL( CAST( t103.AverageQntySurveysPerDay	AS DECIMAL (10,2) ), 0)			AS AverageQntySurveysPerDay
		

		--Unique Logins
		, ISNULL( t104.UniqueLogins, 0 )												AS UniqueLogins

		
		--Users
		, ISNULL( t105.Users, 0 )														AS Users


		--PercentOfLogins
		, CAST(	ISNULL( t104.UniqueLogins, 0) /  CAST( NULLIF( t105.Users, 0)		AS FLOAT)		AS DECIMAL ( 10, 2 ) )		AS PercentOfLogins


		--AvgLoginsPerDay
		, CAST( ISNULL( t104.UniqueLogins, 0) / CAST( 30	AS FLOAT)	AS DECIMAL ( 10, 2 ) )									AS AvgUniqueLoginsPerDay
		

		--Automated, Manual Reports Qnty 
		, ISNULL( t106.AutomatedReportsQnty, 0 )										AS AutomatedReportsQnty
		, ISNULL( t106.ManualReportsQnty, 0 )											AS ManualReportsQnty


		--Manual to User Ratio
		, CAST( ISNULL( t106.ManualReportsQnty, 0 ) / CAST( NULLIF( t105.Users, 0 )  AS FLOAT )		AS DECIMAL ( 10, 2 ) )		AS [ManualReports/Users]


		--Incindent
		, ISNULL( t107.TotalOpenIncident, 0 )																					AS TotalOpenIncident
		, ISNULL( t107.TotalClosedIncident, 0 )																					AS TotalClosedIncident
		, ISNULL( t107.TotalIncident, 0 )																						AS TotalIncident
		, CAST( ISNULL(	t107.TotalOpenIncident  /	CAST( NULLIF( t107.TotalIncident, 0 ) 	 AS FLOAT ), 0)	as DECIMAL (5, 2)  )			AS PercentOfOpenIncidents		


		--Inbox
		, CASE WHEN t100.InboxEnabled = 1					THEN 1	ELSE 0	END										AS InboxEnabled


		--Coach
		, CASE WHEN t108.OrganizationObjectId IS NOT NULL 	THEN 1	ELSE 0	END										AS Coach


		--ReportDigest
		, CASE WHEN t100.ReportDigest = 1					THEN 1	ELSE 0	END										AS ReportDigest


		--Dashboard
		, CASE WHEN t109.DashboadQnty IS NOT NULL			THEN 1	ELSE 0	END										AS DashboadQnty


		--Tagging
		, CAST( t100.TaggingEnabled		AS INT )																	AS TaggingEnabled
		
		
		--Voci
		, CASE WHEN t110.VociEnabledQnty > 0				THEN 1 	ELSE 0 	END										AS VociEnabledQnty
		
		
		--Monitor
		, CASE WHEN t111.OrganizationObjectId IS NOT NULL	THEN 1 	ELSE 0	END										AS Monitor

		
		--Campaign
		----, CASE WHEN t112.EmailCampaign IS NOT NULL			THEN 1	ELSE 0	END										AS EmailCampaign
		, CASE WHEN t112.OutboundCampaign IS NOT NULL		THEN 1	ELSE 0	END										AS OutboundCampaign

		
		--OfferAccessBlocking
		, CASE WHEN t113.OrganizationObjectId IS NOT NULL	THEN 1 	ELSE 0	END										AS OfferAccessBlocking
		
		
INTO ##ClientEngagement
		
FROM
		(
			--Enabled Organization
			SELECT
					t10.ObjectId								AS OrganizationObjectId
					, t10.Name 									AS OrgName
					, t10.Enabled								AS OrgEnabled
					, t10.InboxEnabled
					, t10.DisplayReportDigest					AS ReportDigest
					, t10.TaggingEnabled						

			FROM
					Organization						t10		WITH (NOLOCK)

			WHERE
					t10.Enabled = 1	
				AND
					t10.TestOrganization = 0


			--ORDER BY t10.Name

		)	AS t100

	LEFT JOIN

		(	
			--AccountManager
			SELECT
					t10.ObjectId								AS OrganizationObjectId
					, t30.FirstName + ' ' + t30.LastName		AS AccountManager

			FROM
					Organization						t10		WITH (NOLOCK)
				JOIN
					OrganizationAccountManagers			t20		WITH (NOLOCK)
						ON t10.ObjectId = t20.OrganizationObjectId
				JOIN
					UserAccount							t30		WITH (NOLOCK)
						ON t20.userAccountObjectId = t30.ObjectId		

			--ORDER BY 2

		)	AS t101
				ON t100.OrganizationObjectId = t101.OrganizationObjectId

	LEFT JOIN

		(	
			--Enabled Locations & Size
			SELECT
					t10.OrganizationObjectId
					, t10.Enabled
					, COUNT(1)															AS ActiveLocationQnty
					, CASE	WHEN COUNT(1) < 100					THEN 'Bronze'
							WHEN COUNT(1) BETWEEN 100 AND 1000	THEN 'Silver' 
							WHEN COUNT(1) > 1000				THEN 'Gold'
						END
																						AS Size

			FROM
					Location							t10		WITH (NOLOCK)

			WHERE
					t10.Enabled = 1	


			GROUP BY
					t10.OrganizationObjectId
					, t10.Enabled
		)	AS t102
				ON t100.OrganizationObjectId = t102.OrganizationObjectId

	LEFT JOIN

		(	
			--VoiceQnty, WebQnty, Complete, Incomplete, CompleteRate
			SELECT
					t10.OrganizationObjectId
					, SUM( CASE WHEN t20.ModeType = 1	THEN 1					ELSE 0	END )						AS VoiceSurveyQnty
					, SUM( CASE WHEN t20.ModeType = 2	THEN 1					ELSE 0	END )						AS WebSurveyQnty
					, ISNULL( SUM( CASE WHEN t20.complete = 1	THEN 1			ELSE 0	END ), 0)					AS Complete
					, ISNULL( SUM( CASE WHEN t20.complete = 0	THEN 1			ELSE 0	END ), 0)					AS Incomplete
					, CAST( ISNULL(	(SUM( CASE WHEN t20.complete = 1	THEN 1	ELSE 0	END ) /	CAST( COUNT(1) AS FLOAT )	), 0)	AS DECIMAL (5, 2)  )		
																													AS CompleteRate
					, ISNULL( COUNT(1), 0 )	/	CAST( 30 		AS FLOAT  )											AS AverageQntySurveysPerDay

			FROM
				
					Survey								t10		WITH (NOLOCK)
				JOIN
					SurveyResponse						t20		WITH (NOLOCK)
						ON t10.objectId = t20.SurveyObjectId
						
			WHERE
					t20.beginDateUTC BETWEEN
												@StartUtcDateTime
											AND
												@EndUtcDateTime

			GROUP BY
					t10.OrganizationObjectId
		)	AS t103
				ON t100.OrganizationObjectId = t103.OrganizationObjectId

	LEFT JOIN

		(	
			--Unique Logins
			SELECT
					t20.OrganizationObjectId
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
						FROM
								AccessEventLog
						WHERE
								TimeStamp
											BETWEEN
														@StartUtcDateTime
													AND
														@EndUtcDateTime
					)	t30
							ON t20.UserAccountObjectId = t30.UserAccountObjectId

			GROUP BY
					t20.OrganizationObjectId		
		)	AS t104
				ON t100.OrganizationObjectId = t104.OrganizationObjectId
				
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
		)	AS t105
				ON t100.OrganizationObjectId = t105.OrganizationObjectId

	LEFT JOIN

		(	
			--Automated Manual Reports
			SELECT
					t10.OrganizationObjectId
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
		)	AS t106
				ON t100.OrganizationObjectId = t106.OrganizationObjectId
				
	LEFT JOIN

		(
			SELECT
					t10.OrganizationObjectId
					, t10.TotalIncident
					, t20.TotalOpenIncident
					, t30.TotalClosedIncident

			FROM

					(
						--Total Incidents
						SELECT
								t10.OrganizationObjectId
								, SUM( t10.TotalIncident )				AS TotalIncident

						FROM
								(

									SELECT
											t70.OrganizationObjectId
											, COUNT(1)					AS TotalIncident
				

									FROM
											SurveyResponse				t50
										JOIN
											SurveyResponseNote			t60
												ON t50.objectId = t60.surveyResponseObjectId
										JOIN
											Survey						t70
												ON t50.surveyObjectId = t70.objectId


									WHERE
											beginDateUTC BETWEEN
																		@StartUtcDateTime
																	AND	
																		@EndUtcDateTime
										--AND
										--	t70.OrganizationObjectId IN ( 714, 503 )
				


									GROUP BY
											t70.OrganizationObjectId
											, t60.surveyResponseObjectId
											--, t60.stateType

									HAVING
											MAX(stateType) < 3		--Total

								)	AS t10

						GROUP BY
								t10.OrganizationObjectId
					)	AS t10


				LEFT JOIN

					(
						--Total Open Incidents
						SELECT
								t10.OrganizationObjectId
								, SUM( t10.IncidentOpenOrInprogress )	AS TotalOpenIncident

						FROM
								(

									SELECT
											t70.OrganizationObjectId
											, COUNT(1)					AS IncidentOpenOrInprogress
					

									FROM
											SurveyResponse				t50
										JOIN
											SurveyResponseNote			t60
												ON t50.objectId = t60.surveyResponseObjectId
										JOIN
											Survey						t70
												ON t50.surveyObjectId = t70.objectId


									WHERE
											beginDateUTC BETWEEN
																		@StartUtcDateTime
																	AND	
																		@EndUtcDateTime
										--AND
										--	t70.OrganizationObjectId IN ( 714, 503 )
					


									GROUP BY
											t70.OrganizationObjectId
											, t60.surveyResponseObjectId
											--, t60.stateType

									HAVING
											MAX(stateType) < 2		--Open or In Progress

								)	AS t10

						GROUP BY
								t10.OrganizationObjectId

					)	AS t20
							ON t10.OrganizationObjectId = t20.OrganizationObjectId

				LEFT JOIN

					(
						--Total Closed Incidents
						SELECT
								t10.OrganizationObjectId
								, SUM( t10.ClosedIncident )				AS TotalClosedIncident

						FROM
								(

									SELECT
											t70.OrganizationObjectId
											, COUNT(1)					AS ClosedIncident
					

									FROM
											SurveyResponse				t50
										JOIN
											SurveyResponseNote			t60
												ON t50.objectId = t60.surveyResponseObjectId
										JOIN
											Survey						t70
												ON t50.surveyObjectId = t70.objectId


									WHERE
											beginDateUTC BETWEEN
																		@StartUtcDateTime
																	AND	
																		@EndUtcDateTime
					

									GROUP BY
											t70.OrganizationObjectId
											, t60.surveyResponseObjectId
											--, t60.stateType

									HAVING
											MAX(stateType) = 2		--Closed

								)	AS t10

						GROUP BY
								t10.OrganizationObjectId

					)	AS t30
							ON t10.OrganizationObjectId = t30.OrganizationObjectId


		)	AS t107
				ON t100.OrganizationObjectId = t107.OrganizationObjectId
				
	LEFT JOIN
	
		(
			--Coach
			SELECT
					DISTINCT
					t10.OrganizationObjectId
			FROM
					Folder			t10
				JOIN
					Page			t20
						ON t10.ObjectId = t20.FolderObjectId
			WHERE
					t20.JasperReportDefinitionObjectId = 1

		)	AS t108
				ON t100.OrganizationObjectId = t108.OrganizationObjectId
				
	LEFT JOIN
	
		(
			--Dashboard
			SELECT
					organizationId		AS OrganizationObjectId
					, COUNT(1)			AS DashboadQnty



			FROM
					Dashboard

			GROUP BY
					organizationId



		)	AS t109
				ON t100.OrganizationObjectId = t109.OrganizationObjectId
				
	LEFT JOIN

		(
			--Voci
			SELECT
					OrganizationObjectId
					, SUM( CASE WHEN EnableVoci = 1		THEN 1	ELSE 0	END )		AS VociEnabledQnty

			FROM
					UnstructuredFeedbackModel

			GROUP BY
					OrganizationObjectId


		)	AS t110
				ON t100.OrganizationObjectId = t110.OrganizationObjectId

	LEFT JOIN

		(
			--Monitor
			SELECT
					DISTINCT
					t10.OrganizationObjectId
			FROM
					Doctor.Mindshare.dbo.PearModel			t10

		)	AS t111
				ON t100.OrganizationObjectId = t111.OrganizationObjectId

	LEFT JOIN

		(
			--Campaign
			SELECT
					OrganizationObjectId
					, SUM( CASE WHEN campaignType = 1	THEN 1	ELSE 0	END		)	AS EmailCampaign
					, SUM( CASE WHEN campaignType = 2	THEN 1	ELSE 0	END		)	AS OutboundCampaign


			FROM
					Campaign


			GROUP BY
					OrganizationObjectId

		)	AS t112
				ON t100.OrganizationObjectId = t112.OrganizationObjectId
				
	LEFT JOIN

		(
			--Offer Access Blocking
			SELECT
					DISTINCT
					OrganizationObjectId
			FROM
					Offer					t10
				JOIN
					OfferAccessPolicy		t20
						ON t10.objectId = t20.offerObjectId

		)	AS t113
				ON t100.OrganizationObjectId = t113.OrganizationObjectId
				



ORDER BY
		t100.OrgName




-- Removes Secondary Account Managers
DELETE
FROM
		##ClientEngagement
WHERE
		RowId NOT IN
									(
										SELECT 
												MIN(RowId)

										FROM 
												##ClientEngagement
										GROUP BY 
												OrgName
									)


--SELECT *	FROM ##ClientEngagement		ORDER BY OrgName


-- Dumps modified result set into persistant table for tableau
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Monitor.ClientEngagement_v2_Results') AND type = (N'U'))    DROP TABLE Monitor.ClientEngagement_v2_Results
SELECT
		OrganizationObjectId
		, OrgName
		, OrgEnabled
		, AccountManager
		, ActiveLocationQnty
		, Size
		, VoiceSurveyQnty
		, WebSurveyQnty
		, Complete
		, Incomplete
		, CompleteRate
		, AverageQntySurveysPerDay
		, UniqueLogins
		, Users
		, PercentOfLogins
		, AvgUniqueLoginsPerDay
		, AutomatedReportsQnty
		, ManualReportsQnty
		, [ManualReports/Users]
		, TotalOpenIncident
		, TotalClosedIncident
		, TotalIncident
		, PercentOfOpenIncidents
		, InboxEnabled
		, Coach
		, ReportDigest
		, DashboadQnty
		, TaggingEnabled
		, VociEnabledQnty
		, Monitor
		, OutboundCampaign
		, OfferAccessBlocking
		
INTO Monitor.ClientEngagement_v2_Results		

FROM
		##ClientEngagement

ORDER BY
		OrgName		
		
		
		
		
		
/* 
--select * from Monitor.ClientEngagement_v2_Results	
-- Visual Validation
SELECT 
		OrganizationObjectId
		, COUNT(1) 		AS TotalCount
FROM 
		##ClientEngagement
GROUP BY 
		OrganizationObjectId
HAVING 
		COUNT(1) > 1
ORDER BY 
		COUNT(1) DESC




*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
