ALTER TABLE [dbo].[KeyEntry] WITH CHECK ADD CONSTRAINT [FK_KeyEntry_KeyStore]
   FOREIGN KEY([keyStoreObjectId]) REFERENCES [dbo].[KeyStore] ([objectId])

GO
ALTER TABLE [dbo].[KeyEntry] WITH CHECK ADD CONSTRAINT [FK_KeyEntry_KeyEntry]
   FOREIGN KEY([signingCertificateObjectId]) REFERENCES [dbo].[KeyEntry] ([objectId])

GO
