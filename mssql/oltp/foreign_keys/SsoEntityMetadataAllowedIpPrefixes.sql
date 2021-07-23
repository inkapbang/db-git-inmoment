ALTER TABLE [dbo].[SsoEntityMetadataAllowedIpPrefixes] WITH CHECK ADD CONSTRAINT [FK_SsoEntityMetadataAllowedIpPrefixes_SsoEntityMetadata]
   FOREIGN KEY([ssoEntityMetadataObjectId]) REFERENCES [dbo].[SsoEntityMetadata] ([objectId])

GO
