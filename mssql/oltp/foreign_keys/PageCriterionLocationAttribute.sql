ALTER TABLE [dbo].[PageCriterionLocationAttribute] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLocationAttribute_LocationAttribute]
   FOREIGN KEY([attributeObjectId]) REFERENCES [dbo].[LocationAttribute] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionLocationAttribute] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLocationAttribute_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
