CREATE TABLE [dbo].[_uplift8928] (
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
   [numAutoFocusAssignments] [int] NOT NULL,
   [maxFocusAssignments] [int] NOT NULL,
   [dashboardThresholding] [tinyint] NULL,
   [numManualFocusAssignments] [int] NULL,
   [surveyLegendLabelObjectId] [int] NULL,
   [auditLegendLabelObjectId] [int] NULL,
   [labelObjectId] [int] NULL,
   [pageObjectId] [int] NULL,
   [reportOutputFormat] [nvarchar](100) NULL
)


GO
