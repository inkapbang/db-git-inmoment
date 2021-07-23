ALTER TABLE [dbo].[OrganizationInboxExcludedChannel] WITH CHECK ADD CONSTRAINT [FK_OIEC_FeedbackChannel]
   FOREIGN KEY([feedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationInboxExcludedChannel] WITH CHECK ADD CONSTRAINT [FK_OIEC_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
