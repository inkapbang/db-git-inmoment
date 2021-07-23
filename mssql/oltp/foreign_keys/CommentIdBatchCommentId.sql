ALTER TABLE [dbo].[CommentIdBatchCommentId] WITH CHECK ADD CONSTRAINT [FK_CommentIdBatch_CommentIdBatchCommentId]
   FOREIGN KEY([batchObjectId]) REFERENCES [dbo].[CommentIdBatch] ([objectId])

GO
