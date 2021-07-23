SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*****************************************************  InboxEnabled & Dashboard Portion Below  *********************************************************************/
--DROP Procedure Monitor.EWS_30Day_InboxEnabled_Dashboard
--CREATE Procedure Monitor.EWS_30Day_InboxEnabled_Dashboard
CREATE Procedure Monitor.EWS_30Day_InboxEnabled_Dashboard
AS
/*****************************************  EWS Project  *****************************************

	Must be run on OLTP for now do to incompletes.

	History
		6.19.2013	Tad Peterson
			-- Create and added to EWS 30Day Project
		
		8.13.2013	Tad Peterson
			-- Changed to 30 days
			-- added OPTION (maxrecursion 0)

		10.14.2013	Tad Peterson
			-- changed back to 30 days
			-- added surveyVolume 365 day table
			-- added login items 365 day table
			
			
*************************************************************************************************/
-- Results Table
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'Monitor.EWS_30Day_InboxEnabled_Dashboard_Results') AND type = (N'U'))    DROP TABLE Monitor.EWS_30Day_InboxEnabled_Dashboard_Results
SELECT


		t100.OrganizationObjectId
		, t100.OrgName
		, t100.OrgEnabled

		--Inbox
		, CASE WHEN t100.InboxEnabled = 1					THEN 1	ELSE 0	END										AS InboxEnabled

		--Dashboard
		, CASE WHEN t109.DashboadQnty IS NOT NULL			THEN 1	ELSE 0	END										AS DashboadQnty

INTO Monitor.EWS_30Day_InboxEnabled_Dashboard_Results				
		
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

		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
