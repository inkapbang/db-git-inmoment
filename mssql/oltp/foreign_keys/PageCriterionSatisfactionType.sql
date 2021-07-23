ALTER TABLE [dbo].[PageCriterionSatisfactionType] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSatisfactionType_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
