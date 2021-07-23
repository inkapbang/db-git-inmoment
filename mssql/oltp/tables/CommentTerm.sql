CREATE TABLE [dbo].[CommentTerm] (
   [commentId] [bigint] NOT NULL,
   [termId] [bigint] NOT NULL,
   [beginOffset] [int] NOT NULL,
   [endOffset] [int] NOT NULL,
   [score] [float] NULL,
   [rawSentiment] [float] NULL,
   [evidence] [int] NULL,
   [sentiment] [int] NULL,
   [transcriptionConfidence] [float] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL

   ,CONSTRAINT [PK_CommentTerm] PRIMARY KEY CLUSTERED ([commentId], [termId], [beginOffset], [endOffset])
)


GO
