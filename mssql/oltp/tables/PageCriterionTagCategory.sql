CREATE TABLE [dbo].[PageCriterionTagCategory] (
   [pageCriterionObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionTagCategory] PRIMARY KEY CLUSTERED ([pageCriterionObjectId] DESC, [tagCategoryObjectId] DESC)
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionTagCategory_tagCategoryObjectId] ON [dbo].[PageCriterionTagCategory] ([tagCategoryObjectId])

GO
