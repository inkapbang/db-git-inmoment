CREATE TABLE [dbo].[PageCriterionLocationCategory] (
   [pageCriterionObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionLocationCategory] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [locationCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionLocationCategory_locationCategoryObjectId] ON [dbo].[PageCriterionLocationCategory] ([locationCategoryObjectId])

GO
