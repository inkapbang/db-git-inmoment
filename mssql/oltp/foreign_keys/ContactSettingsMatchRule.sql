ALTER TABLE [dbo].[ContactSettingsMatchRule] WITH CHECK ADD CONSTRAINT [FK_ContactSettingsMatchRule_contactSettingsObjectId]
   FOREIGN KEY([contactSettingsObjectId]) REFERENCES [dbo].[ContactSettings] ([objectId])

GO
