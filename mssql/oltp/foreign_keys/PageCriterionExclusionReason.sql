ALTER TABLE [dbo].[PageCriterionExclusionReason] WITH CHECK ADD CONSTRAINT [FK_PageCriterionExclusionReason_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
