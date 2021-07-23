ALTER TABLE [dbo].[PageCriterionSelectMode] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSelectMode_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
