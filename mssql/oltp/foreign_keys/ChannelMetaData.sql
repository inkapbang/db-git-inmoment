ALTER TABLE [dbo].[ChannelMetaData] WITH CHECK ADD CONSTRAINT [FK_ChannelMetaData_FeedbackChannel]
   FOREIGN KEY([channelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[ChannelMetaData] WITH CHECK ADD CONSTRAINT [FK_ChannelMetaData_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
