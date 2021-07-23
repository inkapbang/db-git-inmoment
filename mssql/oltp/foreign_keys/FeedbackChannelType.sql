ALTER TABLE [dbo].[FeedbackChannelType] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannelType_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
