CREATE TABLE [dbo].[ReportColumnCriteriaSet] (
   [reportColumnObjectId] [int] NOT NULL,
   [reportCriterionObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_ReportColumnCriteriaSet] PRIMARY KEY CLUSTERED ([reportColumnObjectId], [reportCriterionObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_ReportColumnCriteriaSet_reportCriterionObjectId] ON [dbo].[ReportColumnCriteriaSet] ([reportCriterionObjectId])

GO
