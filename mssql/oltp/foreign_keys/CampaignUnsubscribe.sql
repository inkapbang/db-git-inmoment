ALTER TABLE [dbo].[CampaignUnsubscribe] WITH CHECK ADD CONSTRAINT [FK_CampaignUnsubscribe_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])
   ON DELETE CASCADE

GO
