ALTER TABLE [dbo].[PageCriterionState] WITH CHECK ADD CONSTRAINT [FK_PageCriterionState_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
