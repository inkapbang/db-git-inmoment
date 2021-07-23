ALTER TABLE [dbo].[ContactSettings] WITH CHECK ADD CONSTRAINT [FK_ContactSettings_organizationObjectId]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
