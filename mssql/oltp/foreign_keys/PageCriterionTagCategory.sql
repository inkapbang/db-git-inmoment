ALTER TABLE [dbo].[PageCriterionTagCategory] WITH CHECK ADD CONSTRAINT [FK_PageCriterionTagCategory_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionTagCategory] WITH CHECK ADD CONSTRAINT [FK_PageCriterionTagCategory_TagCategory]
   FOREIGN KEY([tagCategoryObjectId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
