CREATE TABLE [dbo].[SentimentAnnotation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
      CONSTRAINT [DF_SentimentAnnotation_Version] DEFAULT ((0)),
   [beginIndex] [int] NOT NULL,
   [endIndex] [int] NOT NULL,
   [sentiment] [float] NOT NULL,
   [commentObjectId] [int] NOT NULL,
   [isTranslated] [bit] NOT NULL,
   [creationDate] [datetime] NOT NULL,
   [isEnglish] [bit] NOT NULL,
   [transientid] [int] NULL,
   [uuid] [nvarchar](36) NULL

   ,CONSTRAINT [PK_SentimentAnnotation] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SentimentAnnotation_commentObjectId] ON [dbo].[SentimentAnnotation] ([commentObjectId]) INCLUDE ([objectId])

GO
