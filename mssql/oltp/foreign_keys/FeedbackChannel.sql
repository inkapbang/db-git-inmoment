ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_UnstructuredFeedbackModel]
   FOREIGN KEY([defaultUnstructuredFeedbackModelObjectId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_UpliftModel]
   FOREIGN KEY([defaultUpliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_FeedbackChannelType]
   FOREIGN KEY([feedbackChannelTypeObjectId]) REFERENCES [dbo].[FeedbackChannelType] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_PartOfDayField]
   FOREIGN KEY([partOfDayFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[FeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_FeedbackChannel_transactionCountField]
   FOREIGN KEY([transactionCountFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
