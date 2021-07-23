ALTER TABLE [dbo].[PhoneAttemptSetting] WITH CHECK ADD CONSTRAINT [FK_PhoneAttemptSetting_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[PhoneAttemptSetting] WITH CHECK ADD CONSTRAINT [FK_PhoneAttemptSetting_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
