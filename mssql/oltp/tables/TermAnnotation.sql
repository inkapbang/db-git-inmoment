CREATE TABLE [dbo].[TermAnnotation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [commentId] [int] NOT NULL,
   [termId] [bigint] NOT NULL,
   [beginIndex] [int] NOT NULL
       DEFAULT ((0)),
   [endIndex] [int] NOT NULL
       DEFAULT ((0)),
   [score] [float] NULL,
   [rawSentiment] [float] NULL,
   [evidence] [int] NULL,
   [sentiment] [int] NULL,
   [creationDate] [datetime] NULL
       DEFAULT (getdate()),
   [version] [int] NOT NULL
       DEFAULT ((1)),
   [transcriptionConfidence] [float] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL,
   [unfiltered] [tinyint] NULL,
   [fieldSentiment] [float] NULL,
   [uuid] [nvarchar](36) NULL

   ,CONSTRAINT [PK_TermAnnotation] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_TermAnnotation_CommentId] ON [dbo].[TermAnnotation] ([commentId]) INCLUDE ([beginIndex], [endIndex], [termId])
CREATE NONCLUSTERED INDEX [IX_TermAnnotation_commentId_include] ON [dbo].[TermAnnotation] ([commentId]) INCLUDE ([objectId], [termId], [beginIndex], [endIndex], [score], [rawSentiment], [evidence], [sentiment], [creationDate], [version], [transcriptionConfidence], [transcriptionConfidenceLevel], [unfiltered], [fieldSentiment])
CREATE NONCLUSTERED INDEX [IX_TermAnnotation_Term] ON [dbo].[TermAnnotation] ([termId])

GO
