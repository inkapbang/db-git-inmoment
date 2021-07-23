ALTER TABLE [dbo].[AttemptSetting] WITH CHECK ADD CONSTRAINT [FK_AttemptSetting_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[AttemptSetting] WITH CHECK ADD CONSTRAINT [FK_AttemptSetting_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
