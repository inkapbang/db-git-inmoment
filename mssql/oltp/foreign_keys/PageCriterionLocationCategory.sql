ALTER TABLE [dbo].[PageCriterionLocationCategory] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLocationCategory_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionLocationCategory] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLocationCategory_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
