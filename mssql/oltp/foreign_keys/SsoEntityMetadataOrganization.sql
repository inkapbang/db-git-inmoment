ALTER TABLE [dbo].[SsoEntityMetadataOrganization] WITH CHECK ADD CONSTRAINT [FK_SsoEntityMetadataOrganization_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[SsoEntityMetadataOrganization] WITH CHECK ADD CONSTRAINT [FK_SsoEntityMetadataOrganization_SsoEntityMetadata]
   FOREIGN KEY([ssoEntityMetadataObjectId]) REFERENCES [dbo].[SsoEntityMetadata] ([objectId])

GO
