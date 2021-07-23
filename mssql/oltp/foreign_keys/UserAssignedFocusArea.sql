ALTER TABLE [dbo].[UserAssignedFocusArea] WITH CHECK ADD CONSTRAINT [FK_UserAssignedFocusArea_locationObjectId]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[UserAssignedFocusArea] WITH CHECK ADD CONSTRAINT [FK_UserAssignedFocusArea_performanceAttributeObjectId]
   FOREIGN KEY([performanceAttributeObjectId]) REFERENCES [dbo].[UpliftModelPerformanceAttribute] ([objectId])

GO
