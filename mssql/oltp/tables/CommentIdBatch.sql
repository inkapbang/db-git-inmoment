CREATE TABLE [dbo].[CommentIdBatch] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [timestamp] [datetime] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NULL

   ,CONSTRAINT [PK_CommentIdBatch] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CommentIdBatch_organizationObjectId] ON [dbo].[CommentIdBatch] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_CommentIdBatch_timestamp] ON [dbo].[CommentIdBatch] ([timestamp])

GO
