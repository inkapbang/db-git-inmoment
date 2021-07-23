CREATE TABLE [dbo].[Page] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NULL,
   [showDetail] [bit] NULL,
   [orientation] [int] NULL,
   [hideNoResponsePrompts] [bit] NULL,
   [benchmarkEnabled] [bit] NULL,
   [publicWebAccess] [bit] NOT NULL,
   [folderObjectId] [int] NULL,
   [includeHiddenLocations] [bit] NOT NULL
       DEFAULT (0),
   [version] [int] NOT NULL
       DEFAULT (0),
   [pageType] [int] NOT NULL,
   [maxGraphsPerPage] [int] NULL,
   [crossTabIndyFieldObjectId] [int] NULL,
   [topLocationPercent] [int] NULL,
   [showScoreWeight] [bit] NULL,
   [showTopLocationPercent] [bit] NULL,
   [trendPeriodObjectId] [int] NULL,
   [groupWidthPercent] [int] NULL,
   [nameObjectId] [int] NOT NULL,
   [descriptionObjectId] [int] NOT NULL,
   [hideLegend] [bit] NULL,
   [showSurveyCount] [bit] NOT NULL
       DEFAULT ((0)),
   [benchmarkObjectId] [int] NULL,
   [jasperReportDefinitionObjectId] [int] NULL,
   [hidden] [bit] NOT NULL
       DEFAULT ((0)),
   [upliftModelObjectId] [int] NULL,
   [periodObjectId] [int] NULL,
   [dashboardDefinitionId] [int] NULL,
   [unstructuredFeedbackObjectId] [int] NULL,
   [editableContentObjectId] [int] NULL,
   [netezzaRunner] [int] NULL,
   [hideEmptyColumns] [bit] NULL,
   [excelTemplateObjectId] [int] NULL,
   [periodCount] [int] NULL,
   [layoutType] [int] NULL,
   [dashboardObjectId] [int] NULL,
   [percentageResponsePrecision] [int] NULL,
   [hideDetailLinks] [bit] NOT NULL
      CONSTRAINT [DF__Page__hideDetail__2B796F95] DEFAULT ((0)),
   [delimiter] [tinyint] NOT NULL
      CONSTRAINT [DF_Page_Delimiter] DEFAULT ((0)),
   [detailLevel] [tinyint] NULL,
   [usePeriodToDateGoal] [tinyint] NOT NULL
      CONSTRAINT [DF_UpliftModel_usePeriodToDateGoal] DEFAULT ((0)),
   [benchmarkType] [tinyint] NULL,
   [textAnalyticsCacheEnabled] [tinyint] NOT NULL
       DEFAULT ((0)),
   [brandObjectId] [int] NULL,
   [summaryOption] [tinyint] NULL,
   [aggregationType] [int] NULL,
   [responseCountThreshold] [int] NULL,
   [showPrimaryScore] [tinyint] NULL,
   [ratingView] [bit] NULL,
   [outstandingThreshold] [int] NULL,
   [zeroBased] [bit] NULL,
   [alternateTextFormat] [tinyint] NULL,
   [roundingPlace] [int] NULL,
   [includeZeroResponse] [bit] NOT NULL
      CONSTRAINT [DF_Page_includeZeroResponse] DEFAULT ((0)),
   [showNAForBlankScores] [bit] NOT NULL
      CONSTRAINT [DF_Page_showNAForBlankScores] DEFAULT ((0)),
   [benchmarkDepth] [int] NULL
      CONSTRAINT [DefaultBenchmarkDepthConstraint] DEFAULT ((1)),
   [enablePeriodToDate] [bit] NULL
      CONSTRAINT [DF_Page_EnablePeriodToDate] DEFAULT ((0)),
   [periodToDateColLabelObjectId] [int] NULL,
   [periodToDatePeriodTypeObjectId] [int] NULL,
   [periodToDatePeriodOffset] [int] NULL
      CONSTRAINT [DF_Page_PeriodToDatePeriodOffset] DEFAULT ((0)),
   [periodToDatePeriodCount] [int] NULL
      CONSTRAINT [DF_Page_PeriodToDatePeriodCount] DEFAULT ((0)),
   [periodToDateCutoffPeriodTypeObjectId] [int] NULL,
   [periodToDateAppendDate] [bit] NULL
      CONSTRAINT [DF_Page_PeriodToDateAppendDate] DEFAULT ((0)),
   [privacyFilterEnabled] [tinyint] NULL,
   [thresholdType] [int] NULL,
   [defaultOutputFormatType] [varchar](100) NULL,
   [overrideDataSourceType] [smallint] NULL,
   [disableEDLink] [bit] NULL,
   [includeCriteriaSheet] [bit] NULL,
   [pivotTableName] [nvarchar](50) NULL,
   [excludeTrafficBuildingPlan] [bit] NULL,
   [defaultReportAction] [tinyint] NOT NULL
      CONSTRAINT [DF_Page_defaultReportAction] DEFAULT ((1)),
   [showResponseCounts] [bit] NOT NULL
       DEFAULT ((0)),
   [userCanOverrideResponseCountThreshold] [bit] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_Page_Description] UNIQUE NONCLUSTERED ([descriptionObjectId])
   ,CONSTRAINT [UK_Page_Name] UNIQUE NONCLUSTERED ([nameObjectId])
)

CREATE NONCLUSTERED INDEX [ix_IndexName] ON [dbo].[Page] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_Blob] ON [dbo].[Page] ([excelTemplateObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_brandObjectId] ON [dbo].[Page] ([brandObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_crossTabIndyFieldObjectId] ON [dbo].[Page] ([crossTabIndyFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_Dashboard] ON [dbo].[Page] ([dashboardObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_DashboardDefinintion] ON [dbo].[Page] ([dashboardDefinitionId])
CREATE NONCLUSTERED INDEX [IX_Page_editableContentObjectId] ON [dbo].[Page] ([editableContentObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_folderObjectId] ON [dbo].[Page] ([folderObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_JasperReportDefinition] ON [dbo].[Page] ([jasperReportDefinitionObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_LocalizedString_PeriodToDateColumnLabel] ON [dbo].[Page] ([periodToDateColLabelObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_Organization_pageType] ON [dbo].[Page] ([organizationObjectId], [pageType]) INCLUDE ([nameObjectId], [dashboardDefinitionId], [publicWebAccess], [upliftModelObjectId], [periodObjectId], [unstructuredFeedbackObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_organizationObjectId] ON [dbo].[Page] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_organizationObjectId_pageType] ON [dbo].[Page] ([organizationObjectId], [pageType])
CREATE NONCLUSTERED INDEX [ix_Page_orgid] ON [dbo].[Page] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_pageType] ON [dbo].[Page] ([pageType]) INCLUDE ([objectId], [organizationObjectId], [benchmarkType], [publicWebAccess], [folderObjectId], [includeHiddenLocations], [version], [crossTabIndyFieldObjectId], [topLocationPercent], [showScoreWeight], [showTopLocationPercent], [nameObjectId], [descriptionObjectId], [hideLegend], [showSurveyCount], [benchmarkObjectId], [hidden], [netezzaRunner])
CREATE NONCLUSTERED INDEX [IX_Page_periodObjectId] ON [dbo].[Page] ([periodObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_PeriodType_PeriodToDateCutoffPeriodType] ON [dbo].[Page] ([periodToDateCutoffPeriodTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_PeriodType_PeriodToDatePeriodType] ON [dbo].[Page] ([periodToDatePeriodTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_trendPeriodObjectId] ON [dbo].[Page] ([trendPeriodObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_unstructuredFeedbackObjectId] ON [dbo].[Page] ([unstructuredFeedbackObjectId])
CREATE NONCLUSTERED INDEX [IX_Page_upliftModelObjectId] ON [dbo].[Page] ([upliftModelObjectId])

GO
