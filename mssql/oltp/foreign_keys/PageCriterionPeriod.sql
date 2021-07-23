ALTER TABLE [dbo].[PageCriterionPeriod] WITH CHECK ADD CONSTRAINT [FK_PageCriterionPeriod_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionPeriod] WITH CHECK ADD CONSTRAINT [FK_PageCriterionPeriod_Period]
   FOREIGN KEY([periodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
