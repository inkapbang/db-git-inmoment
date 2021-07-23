CREATE TABLE [dbo].[UpliftModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [minimumDiagnosticCount] [int] NOT NULL,
   [numDiagnosticsToShow] [int] NOT NULL,
   [version] [int] NOT NULL,
   [channelObjectId] [int] NOT NULL,
   [performanceIndicatorFieldObjectId] [int] NOT NULL,
   [regressionPerformanceIndicatorFieldObjectId] [int] NOT NULL,
   [upliftModelStrategyObjectId] [int] NOT NULL,
   [reviewRatingFieldObjectId] [int] NULL,
   [reviewCommentFieldObjectId] [int] NULL,
   [periodObjectId] [int] NULL,
   [ptdLabelObjectId] [int] NULL,
   [performanceIndicatorGoalObjectId] [int] NULL,
   [recommendationOption] [tinyint] NULL,
   [numAutoFocusAssignments] [int] NOT NULL
      CONSTRAINT [DF_UpliftModel_numAutoFocusAssignments] DEFAULT ((0)),
   [maxFocusAssignments] [int] NOT NULL
      CONSTRAINT [DF_UpliftModel_maxFocusAssignments] DEFAULT ((3)),
   [dashboardThresholding] [tinyint] NULL,
   [numManualFocusAssignments] [int] NULL
      CONSTRAINT [DF_UpliftModel_NumManualFocusAssignments] DEFAULT ((0)),
   [surveyLegendLabelObjectId] [int] NULL,
   [auditLegendLabelObjectId] [int] NULL,
   [labelObjectId] [int] NULL,
   [pageObjectId] [int] NULL,
   [reportOutputFormat] [nvarchar](100) NULL

   ,CONSTRAINT [PK_UpliftModel] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UN_UpliftModel_Name_Channel] UNIQUE NONCLUSTERED ([channelObjectId], [name])
)

CREATE NONCLUSTERED INDEX [IX_UpliftModel_FeedbackChannel] ON [dbo].[UpliftModel] ([channelObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_LocalizedString_AuditLegendLabel] ON [dbo].[UpliftModel] ([auditLegendLabelObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_LocalizedString_SurveyLegendLabel] ON [dbo].[UpliftModel] ([surveyLegendLabelObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_organizationObjectId] ON [dbo].[UpliftModel] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_pageObjectId] ON [dbo].[UpliftModel] ([pageObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_performanceIndicatorFieldObjectId] ON [dbo].[UpliftModel] ([performanceIndicatorFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_PerformanceIndicatorGoal] ON [dbo].[UpliftModel] ([performanceIndicatorGoalObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_ptdLabel_LocalizedString] ON [dbo].[UpliftModel] ([ptdLabelObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_regressionPerformanceIndicatorFieldObjectId] ON [dbo].[UpliftModel] ([regressionPerformanceIndicatorFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_reviewRatingFieldObjectId] ON [dbo].[UpliftModel] ([reviewRatingFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModel_upliftModelStrategyObjectId] ON [dbo].[UpliftModel] ([upliftModelStrategyObjectId])

GO
