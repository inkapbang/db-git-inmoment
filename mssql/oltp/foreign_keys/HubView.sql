ALTER TABLE [dbo].[HubView] WITH CHECK ADD CONSTRAINT [FK_HubView_Period_CurrentYearPeriod]
   FOREIGN KEY([currentYearPeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[HubView] WITH CHECK ADD CONSTRAINT [FK_HubView_Hierarchy]
   FOREIGN KEY([defaultHierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[HubView] WITH CHECK ADD CONSTRAINT [FK_HubView_FeedbackChannel]
   FOREIGN KEY([feedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[HubView] WITH CHECK ADD CONSTRAINT [FK_HubView_Label]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[HubView] WITH CHECK ADD CONSTRAINT [FK_HubView_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[HubView] WITH CHECK ADD CONSTRAINT [FK_HubView_Period_Trend]
   FOREIGN KEY([trendPeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
