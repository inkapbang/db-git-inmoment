CREATE TABLE [dbo].[TagAnnotation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [commentId] [int] NOT NULL,
   [annotation] [nvarchar](200) NULL,
   [beginIndex] [int] NOT NULL
       DEFAULT ((0)),
   [endIndex] [int] NOT NULL
       DEFAULT ((0)),
   [creationDate] [datetime] NOT NULL
       DEFAULT (getdate()),
   [version] [int] NOT NULL
       DEFAULT ((1)),
   [tagObjectId] [int] NOT NULL,
   [transcriptionConfidence] [float] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL,
   [sentiment] [float] NULL,
   [sentimentConfidence] [float] NULL,
   [employeeName] [nvarchar](200) NULL,
   [unfiltered] [tinyint] NULL,
   [translatedBeginIndex] [int] NULL,
   [translatedEndIndex] [int] NULL,
   [pearSource] [int] NULL,
   [pearModelObjectId] [int] NULL,
   [uuid] [nvarchar](36) NULL

   ,CONSTRAINT [PK_TagAnnotation] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_TagAnnotation_commentId] ON [dbo].[TagAnnotation] ([commentId]) INCLUDE ([beginIndex], [endIndex], [tagObjectId])
CREATE NONCLUSTERED INDEX [IX_TagAnnotation_commentId_include] ON [dbo].[TagAnnotation] ([commentId]) INCLUDE ([objectId], [annotation], [beginIndex], [endIndex], [creationDate], [version], [tagObjectId], [transcriptionConfidence], [transcriptionConfidenceLevel], [sentiment], [sentimentConfidence], [employeeName], [unfiltered], [translatedBeginIndex], [translatedEndIndex])
CREATE NONCLUSTERED INDEX [ix_Tagannotation_commentID2] ON [dbo].[TagAnnotation] ([commentId]) INCLUDE ([objectId], [annotation], [beginIndex], [endIndex], [creationDate], [version], [tagObjectId], [transcriptionConfidence], [transcriptionConfidenceLevel], [sentiment], [sentimentConfidence], [employeeName], [unfiltered])
CREATE NONCLUSTERED INDEX [IX_TagAnnotation_commentId3] ON [dbo].[TagAnnotation] ([commentId]) INCLUDE ([objectId], [annotation], [beginIndex], [endIndex], [creationDate], [version], [tagObjectId], [transcriptionConfidence], [transcriptionConfidenceLevel], [sentiment], [sentimentConfidence], [employeeName], [unfiltered], [translatedBeginIndex], [translatedEndIndex], [pearSource], [pearModelObjectId], [uuid])
CREATE NONCLUSTERED INDEX [IX_TagAnnotation_pearModelObjectId] ON [dbo].[TagAnnotation] ([pearModelObjectId])
CREATE NONCLUSTERED INDEX [IX_TagAnnotation_tagObjectId] ON [dbo].[TagAnnotation] ([tagObjectId])

GO
