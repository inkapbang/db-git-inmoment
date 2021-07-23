ALTER TABLE [dbo].[PageCriterionMode] WITH CHECK ADD CONSTRAINT [FK_PageCriterionMode_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
