CREATE TABLE [dbo].[ProgramProgressComponentEntry] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [dashboardComponentObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [feedbackChannelId] [int] NULL,
   [upliftModelId] [int] NULL,
   [leftChangePeriodEnabled] [bit] NULL,
   [leftChangePeriodType] [int] NULL,
   [leftChangeChangeType] [int] NULL,
   [leftPeriodOffset] [int] NULL,
   [rightChangePeriodEnabled] [bit] NULL,
   [rightChangePeriodType] [int] NULL,
   [rightChangeChangeType] [int] NULL,
   [rightPeriodOffset] [int] NULL,
   [minResponseCount] [int] NULL,
   [aggregationType] [int] NULL,
   [thresholdType] [int] NULL,
   [dataFieldId] [int] NULL,
   [aggregateFunction] [int] NULL,
   [titleOverrideId] [int] NULL,
   [sparklineEnabled] [bit] NULL,
   [leftCompareType] [int] NULL,
   [rightCompareType] [int] NULL,
   [leftChangePeriod] [int] NULL,
   [rightChangePeriod] [int] NULL,
   [leftChangeLocked] [bit] NULL,
   [rightChangeLocked] [bit] NULL

   ,CONSTRAINT [PK_ProgramProgressComponentEntry] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ProgramProgressComponentEntry_dashboardComponentObjectId] ON [dbo].[ProgramProgressComponentEntry] ([dashboardComponentObjectId])
CREATE NONCLUSTERED INDEX [IX_ProgramProgressComponentEntry_feedbackChannelId] ON [dbo].[ProgramProgressComponentEntry] ([feedbackChannelId])
CREATE NONCLUSTERED INDEX [IX_ProgramProgressComponentEntry_upliftModelId] ON [dbo].[ProgramProgressComponentEntry] ([upliftModelId])

GO
