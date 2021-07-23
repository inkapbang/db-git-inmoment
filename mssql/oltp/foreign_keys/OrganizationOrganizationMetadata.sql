ALTER TABLE [dbo].[OrganizationOrganizationMetadata] WITH CHECK ADD CONSTRAINT [RK_OrganizationOrganizationMetadata_OrganizationMetadata]
   FOREIGN KEY([metadataObjectId]) REFERENCES [dbo].[OrganizationMetadata] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationOrganizationMetadata] WITH CHECK ADD CONSTRAINT [FK_OrganizationOrganizationMetadata_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
