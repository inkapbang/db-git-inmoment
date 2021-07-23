ALTER TABLE [dbo].[ManualRecommendation] WITH CHECK ADD CONSTRAINT [FK_ManualRecommendation_AssignmentUserAccount]
   FOREIGN KEY([assignmentUserAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
ALTER TABLE [dbo].[ManualRecommendation] WITH CHECK ADD CONSTRAINT [FK_ManualRecommendation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[ManualRecommendation] WITH CHECK ADD CONSTRAINT [FK_ManualRecommendation_PerformanceAttribute]
   FOREIGN KEY([performanceAttributeObjectId]) REFERENCES [dbo].[UpliftModelPerformanceAttribute] ([objectId])

GO
