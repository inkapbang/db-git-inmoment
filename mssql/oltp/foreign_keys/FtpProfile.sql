ALTER TABLE [dbo].[FtpProfile] WITH CHECK ADD CONSTRAINT [FK_FtpProfile_Blob_encryptionKey]
   FOREIGN KEY([encryptionKeyObjectId]) REFERENCES [dbo].[Blob] ([objectId])

GO
ALTER TABLE [dbo].[FtpProfile] WITH CHECK ADD CONSTRAINT [FK__FtpProfil__organ__0C7331B9]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[FtpProfile] WITH CHECK ADD CONSTRAINT [FK_FtpProfile_Blob_userKey]
   FOREIGN KEY([userKeyObjectId]) REFERENCES [dbo].[Blob] ([objectId])

GO
