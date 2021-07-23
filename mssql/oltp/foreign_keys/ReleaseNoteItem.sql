ALTER TABLE [dbo].[ReleaseNoteItem] WITH CHECK ADD CONSTRAINT [FK_ReleaseNoteItem_ReleaseNote]
   FOREIGN KEY([releaseObjectId]) REFERENCES [dbo].[ReleaseNote] ([objectId])

GO
