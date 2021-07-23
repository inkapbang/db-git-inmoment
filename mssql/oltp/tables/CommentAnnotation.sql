CREATE TABLE [dbo].[CommentAnnotation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [analyzerObjectId] [int] NULL,
   [commentId] [int] NOT NULL,
   [annotation] [nvarchar](200) NULL,
   [offset] [int] NULL
       DEFAULT ((0)),
   [length] [int] NULL
       DEFAULT ((0)),
   [creationDate] [datetime] NULL
       DEFAULT (getdate()),
   [version] [int] NOT NULL
       DEFAULT ((1)),
   [tagObjectId] [int] NULL,
   [transcriptionConfidence] [float] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL

   ,CONSTRAINT [PK_CommentAnnotation] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CommentAnnotation_commentId] ON [dbo].[CommentAnnotation] ([commentId]) INCLUDE ([offset], [length], [tagObjectId])
CREATE NONCLUSTERED INDEX [IX_CommentAnnotation_tagObjectId] ON [dbo].[CommentAnnotation] ([tagObjectId])

GO
