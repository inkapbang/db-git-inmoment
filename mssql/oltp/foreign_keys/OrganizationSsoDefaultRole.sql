ALTER TABLE [dbo].[OrganizationSsoDefaultRole] WITH CHECK ADD CONSTRAINT [FK_OrganizationSsoDefaultRole_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
