CREATE TABLE [dbo].[DashboardComponent] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [discriminator] [int] NOT NULL,
   [dashboardId] [int] NOT NULL,
   [titleId] [int] NOT NULL,
   [dashboardComponentType] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [serviceExceptionType] [int] NULL,
   [unstructuredFeedbackModelId] [int] NULL,
   [upliftModelId] [int] NULL,
   [periodId] [int] NULL,
   [renderedItemCount] [int] NULL,
   [feedbackChannelId] [int] NULL,
   [numberOfDays] [int] NULL,
   [optionalColumns] [varchar](max) NULL,
   [videoId] [varchar](32) NULL,
   [showInfo] [bit] NULL,
   [showAnnotations] [bit] NULL,
   [hd] [bit] NULL,
   [allowFullScreen] [bit] NULL,
   [delimitedConfigurationString] [nvarchar](max) NULL,
   [srcQuery] [nvarchar](max) NULL,
   [showProfileImages] [bit] NULL,
   [showUserScreenNames] [bit] NULL,
   [uuid] [uniqueidentifier] NULL,
   [scroll] [bit] NULL,
   [version] [int] NOT NULL,
   [showLocationNames] [tinyint] NULL,
   [refreshCurrentPeriod] [tinyint] NULL,
   [layout] [varchar](5000) NULL,
   [edLinkDisable] [bit] NULL,
   [periodId2] [int] NULL,
   [changeType] [int] NULL,
   [changePeriodType] [int] NULL,
   [visualization] [int] NULL,
   [responseCount] [int] NULL,
   [lockedDate] [bit] NULL,
   [lockedUnits] [bit] NULL,
   [beginDate] [datetime] NULL,
   [endDate] [datetime] NULL,
   [periodTypeId] [int] NULL,
   [lockedDate2] [bit] NULL,
   [beginDate2] [datetime] NULL,
   [endDate2] [datetime] NULL,
   [periodTypeId2] [int] NULL,
   [dateCriteriaType] [int] NULL,
   [watchlistId] [varchar](25) NULL,
   [changeOffset] [int] NULL,
   [minResponseCount] [int] NULL,
   [aggregationType] [int] NULL,
   [thresholdType] [int] NULL,
   [locationCategoryTypeId] [int] NULL,
   [dataSourceType] [int] NULL,
   [changePeriod] [int] NULL,
   [changeLocked] [bit] NULL,
   [targetEnabled] [bit] NULL

   ,CONSTRAINT [PK_DashboardComponent] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardComponent_ChangePeriodType] ON [dbo].[DashboardComponent] ([changePeriodType])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_feedbackChannelId_upliftModelId_unstructuredFeedbackModelId] ON [dbo].[DashboardComponent] ([feedbackChannelId], [upliftModelId], [unstructuredFeedbackModelId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_periodId_titleId] ON [dbo].[DashboardComponent] ([periodId], [titleId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_periodId2] ON [dbo].[DashboardComponent] ([periodId2])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_PeriodType] ON [dbo].[DashboardComponent] ([periodTypeId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_PeriodType2] ON [dbo].[DashboardComponent] ([periodTypeId2])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_Title_LocalizedString] ON [dbo].[DashboardComponent] ([titleId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_UnstructuredFeedbackModel] ON [dbo].[DashboardComponent] ([unstructuredFeedbackModelId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponent_UpliftModel] ON [dbo].[DashboardComponent] ([upliftModelId])
CREATE NONCLUSTERED INDEX [ix_IndexName] ON [dbo].[DashboardComponent] ([dashboardId])

GO
