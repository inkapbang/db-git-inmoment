CREATE TABLE [Monitor].[ClientEngagement_v2_Results] (
   [OrganizationObjectId] [int] NOT NULL,
   [OrgName] [varchar](100) NOT NULL,
   [OrgEnabled] [int] NULL,
   [AccountManager] [nvarchar](101) NULL,
   [ActiveLocationQnty] [int] NOT NULL,
   [Size] [varchar](6) NOT NULL,
   [VoiceSurveyQnty] [int] NOT NULL,
   [WebSurveyQnty] [int] NOT NULL,
   [Complete] [int] NOT NULL,
   [Incomplete] [int] NOT NULL,
   [CompleteRate] [decimal](5,2) NOT NULL,
   [AverageQntySurveysPerDay] [decimal](10,2) NOT NULL,
   [UniqueLogins] [int] NOT NULL,
   [Users] [int] NOT NULL,
   [PercentOfLogins] [decimal](10,2) NULL,
   [AvgUniqueLoginsPerDay] [decimal](10,2) NULL,
   [AutomatedReportsQnty] [int] NOT NULL,
   [ManualReportsQnty] [int] NOT NULL,
   [ManualReports/Users] [decimal](10,2) NULL,
   [TotalOpenIncident] [int] NOT NULL,
   [TotalClosedIncident] [int] NOT NULL,
   [TotalIncident] [int] NOT NULL,
   [PercentOfOpenIncidents] [decimal](5,2) NULL,
   [InboxEnabled] [int] NOT NULL,
   [Coach] [int] NOT NULL,
   [ReportDigest] [int] NOT NULL,
   [DashboadQnty] [int] NOT NULL,
   [TaggingEnabled] [int] NULL,
   [VociEnabledQnty] [int] NOT NULL,
   [Monitor] [int] NOT NULL,
   [OutboundCampaign] [int] NOT NULL,
   [OfferAccessBlocking] [int] NOT NULL
)


GO