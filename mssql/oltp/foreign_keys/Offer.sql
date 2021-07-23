ALTER TABLE [dbo].[Offer] WITH CHECK ADD CONSTRAINT [FK_Offer_FeedbackChannel]
   FOREIGN KEY([channelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[Offer] WITH CHECK ADD CONSTRAINT [FK_Offer_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
