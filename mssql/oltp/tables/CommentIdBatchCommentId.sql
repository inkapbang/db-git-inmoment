CREATE TABLE [dbo].[CommentIdBatchCommentId] (
   [batchObjectId] [int] NOT NULL,
   [commentObjectId] [int] NOT NULL,
   [sequence] [int] NULL

   ,CONSTRAINT [PK_CommentIdBatchCommentId] PRIMARY KEY CLUSTERED ([batchObjectId], [commentObjectId])
)


GO
