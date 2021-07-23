ALTER TABLE [dbo].[PageCriteriaSet] WITH CHECK ADD CONSTRAINT [FK_PageCriteriaSet_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriteriaSet] WITH CHECK ADD CONSTRAINT [FK_PageCriteriaSet_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
