ALTER TABLE [dbo].[SsoEntityMetadata] WITH CHECK ADD CONSTRAINT [FK_SsoEntityMetadata_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
