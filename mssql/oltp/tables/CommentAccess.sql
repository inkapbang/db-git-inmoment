CREATE TABLE [dbo].[CommentAccess] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [commentObjectId] [int] NOT NULL,
   [time] [datetime] NOT NULL,
   [userAccountObjectId] [int] NULL,
   [accessType] [int] NULL,
   [version] [int] NULL

   ,CONSTRAINT [PK_CommentAccess] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_BinaryContentAccess_by_BinaryContentObjectid] ON [dbo].[CommentAccess] ([commentObjectId])
CREATE NONCLUSTERED INDEX [IX_BinaryContentAccess_userAccountObjectId] ON [dbo].[CommentAccess] ([userAccountObjectId])

GO
