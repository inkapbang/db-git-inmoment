CREATE TABLE [dbo].[PageCriterionPeriod] (
   [pageCriterionObjectId] [int] NOT NULL,
   [periodObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionPeriod] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [periodObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionPeriod_periodObjectId] ON [dbo].[PageCriterionPeriod] ([periodObjectId])

GO
