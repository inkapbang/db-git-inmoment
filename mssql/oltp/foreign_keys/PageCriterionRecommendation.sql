ALTER TABLE [dbo].[PageCriterionRecommendation] WITH CHECK ADD CONSTRAINT [FK_PageCriterionRecommendation_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionRecommendation] WITH CHECK ADD CONSTRAINT [FK_PageCriterionRecommendation_PerformanceAttribute]
   FOREIGN KEY([performanceAttributeObjectId]) REFERENCES [dbo].[UpliftModelPerformanceAttribute] ([objectId])

GO
