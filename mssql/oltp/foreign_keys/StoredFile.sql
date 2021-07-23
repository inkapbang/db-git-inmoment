ALTER TABLE [dbo].[StoredFile] WITH CHECK ADD CONSTRAINT [FK_StoredFile_Blob]
   FOREIGN KEY([blobObjectId]) REFERENCES [dbo].[Blob] ([objectId])

GO
ALTER TABLE [dbo].[StoredFile] WITH CHECK ADD CONSTRAINT [FK_StoredFile_FileStore]
   FOREIGN KEY([fileStoreObjectId]) REFERENCES [dbo].[FileStore] ([objectId])

GO
