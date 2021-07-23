ALTER TABLE [dbo].[OrganizationTagSettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationTagSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
