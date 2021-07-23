CREATE TABLE [dbo].[GlobalSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [voiceSurveyEnabled] [bit] NOT NULL,
   [webSurveyEnabled] [bit] NOT NULL,
   [reportingEnabled] [bit] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [webServicesEnabled] [bit] NOT NULL,
   [outboundEnabled] [bit] NOT NULL,
   [inboxEnabled] [bit] NOT NULL,
   [dashboardEnabled] [bit] NOT NULL,
   [surveyErrorLoggingEnabled] [bit] NOT NULL,
   [reportDigestEnabled] [bit] NOT NULL
      CONSTRAINT [DF_GlobalSettings_reportDigestEnabled] DEFAULT ((1)),
   [webServiceSyncMillis] [int] NOT NULL,
   [reviewAppEnabled] [bit] NOT NULL,
   [analysisEnabled] [bit] NOT NULL,
   [manualReportingConsumersEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [inMaintenance] [bit] NULL,
   [releaseInProgress] [bit] NOT NULL
       DEFAULT ((0)),
   [oltp] [int] NULL,
   [platformEnabled] [bit] NOT NULL
      CONSTRAINT [DF_GlobalSettings_platformEnabled] DEFAULT ((1)),
   [pushConsumerEnabled] [bit] NOT NULL
      CONSTRAINT [DF_GlobalSettings_pushConsumerEnabled] DEFAULT ((1))

   ,CONSTRAINT [PK_GlobalSettings] PRIMARY KEY CLUSTERED ([objectId])
)


GO
