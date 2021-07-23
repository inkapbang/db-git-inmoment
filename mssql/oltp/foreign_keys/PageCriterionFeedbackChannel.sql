ALTER TABLE [dbo].[PageCriterionFeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_ReportCriterionFeedbackChannel_FeedbackChannel]
   FOREIGN KEY([feedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionFeedbackChannel] WITH CHECK ADD CONSTRAINT [FK_PageCriterionFeedbackChannel_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
