ALTER TABLE [dbo].[FeedbackChannelResponseFilterDataField] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannelResponseFilterDataField_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannelResponseFilterDataField] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannelResponseFilterDataField_FeedbackChannel]
   FOREIGN KEY([feedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
