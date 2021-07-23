ALTER TABLE [dbo].[FileStore] WITH CHECK ADD CONSTRAINT [FK_FileStore_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
