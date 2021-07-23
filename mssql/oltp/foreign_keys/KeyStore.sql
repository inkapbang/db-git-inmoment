ALTER TABLE [dbo].[KeyStore] WITH CHECK ADD CONSTRAINT [FK_KeyStore_KeyEntry_defaultAltCredential]
   FOREIGN KEY([defaultAltCredentialObjectId]) REFERENCES [dbo].[KeyEntry] ([objectId])

GO
ALTER TABLE [dbo].[KeyStore] WITH CHECK ADD CONSTRAINT [FK_KeyStore_KeyEntry_defaultCredential]
   FOREIGN KEY([defaultCredentialObjectId]) REFERENCES [dbo].[KeyEntry] ([objectId])

GO
