CREATE TABLE [dbo].[ReportColumnLinkedReportParam] (
   [columnObjectId] [int] NOT NULL,
   [paramCriterionObjectId] [int] NOT NULL,
   [valueColumnObjectId] [int] NOT NULL,
   [originalValueColumnObjectId] [int] NULL

   ,CONSTRAINT [PK_ReportColumnLinkedReportParam] PRIMARY KEY CLUSTERED ([columnObjectId], [paramCriterionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportColumnLinkedReportnParam_paramCriterionObjectId] ON [dbo].[ReportColumnLinkedReportParam] ([paramCriterionObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumnLinkedReportParam_valueColumnObjectId] ON [dbo].[ReportColumnLinkedReportParam] ([valueColumnObjectId])

GO
