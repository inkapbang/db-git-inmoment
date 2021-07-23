ALTER TABLE [dbo].[CommentIdBatch] WITH CHECK ADD CONSTRAINT [FK_CommentIdBatch_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
