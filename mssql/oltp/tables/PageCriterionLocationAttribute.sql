CREATE TABLE [dbo].[PageCriterionLocationAttribute] (
   [pageCriterionObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionLocationAttribute] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionLocationAttribute_attributeObjectId] ON [dbo].[PageCriterionLocationAttribute] ([attributeObjectId])

GO
