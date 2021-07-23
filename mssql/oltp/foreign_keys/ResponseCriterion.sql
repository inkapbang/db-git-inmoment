ALTER TABLE [dbo].[ResponseCriterion] WITH CHECK ADD CONSTRAINT [FK_ResponseCriterion_dataFieldObjectId]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[ResponseCriterion] WITH CHECK ADD CONSTRAINT [FK_ResponseCriterion_feedbackChannelObjectId]
   FOREIGN KEY([feedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
