ALTER TABLE [dbo].[OrganizationMetadata] WITH CHECK ADD CONSTRAINT [FK_OrganizationMetadata_OrganizationMetadataGroup]
   FOREIGN KEY([groupObjectId]) REFERENCES [dbo].[OrganizationMetadataGroup] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationMetadata] WITH CHECK ADD CONSTRAINT [FK_OrganizationMetadata_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
