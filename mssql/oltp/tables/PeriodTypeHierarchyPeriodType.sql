CREATE TABLE [dbo].[PeriodTypeHierarchyPeriodType] (
   [periodTypeHierarchyObjectId] [int] NOT NULL,
   [periodTypeObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK__PeriodTy__16C8AD652F299D25] PRIMARY KEY CLUSTERED ([periodTypeHierarchyObjectId], [periodTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PeriodTypeHierarchyPeriodType_PeriodType] ON [dbo].[PeriodTypeHierarchyPeriodType] ([periodTypeObjectId])

GO
