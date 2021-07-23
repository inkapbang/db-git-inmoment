ALTER TABLE [dbo].[DashboardFilterSelectedFeedbackChannels] WITH CHECK ADD CONSTRAINT [FK_DFSFeedbackChannels_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedFeedbackChannels] WITH CHECK ADD CONSTRAINT [FK_DFSFeedbackChannels_FeedbackChannel]
   FOREIGN KEY([feedbackChannelId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])
   ON DELETE CASCADE

GO
