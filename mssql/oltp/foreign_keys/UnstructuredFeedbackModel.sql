ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_DataFieldAutoSentiment]
   FOREIGN KEY([autosentimentFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_FeedbackChannel]
   FOREIGN KEY([channelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_OOVList]
   FOREIGN KEY([oovListObjectId]) REFERENCES [dbo].[OOVList] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_DataField]
   FOREIGN KEY([sentimentFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_SentimentPear]
   FOREIGN KEY([sentimentPearObjectId]) REFERENCES [dbo].[Pear] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackModel] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackModel_TranscribeCustomLanguageModel]
   FOREIGN KEY([transcribeCustomLanguageModelObjectId]) REFERENCES [dbo].[TranscribeCustomLanguageModel] ([objectId])

GO
