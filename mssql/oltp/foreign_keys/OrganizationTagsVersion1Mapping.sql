ALTER TABLE [dbo].[OrganizationTagsVersion1Mapping] WITH CHECK ADD CONSTRAINT [FK_OrganizationTagsVersion1Mapping_Org]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
