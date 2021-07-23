ALTER TABLE [dbo].[OrganizationNotificationSettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationNotificationSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
