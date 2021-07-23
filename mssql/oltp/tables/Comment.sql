CREATE TABLE [dbo].[Comment] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [audio] [varbinary](max) NULL,
   [audioLengthBytes] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [encrypted] [bit] NULL
       DEFAULT ((0)),
   [encryptiontype] [tinyint] NULL
       DEFAULT ((0)),
   [surveyResponseAnswerObjectId] [bigint] NOT NULL,
   [commentType] [tinyint] NOT NULL
       DEFAULT ((1)),
   [commentText] [nvarchar](max) NULL,
   [commentTextLengthBytes] [int] NULL,
   [commentTextLengthChars] [int] NULL,
   [commentTextLengthWords] [int] NOT NULL
       DEFAULT ((-1)),
   [commentLanguage] [int] NULL,
   [audioTranscriptionDate] [datetime] NULL,
   [audioTranscriptionUserObjectId] [int] NULL,
   [transcriptionState] [tinyint] NOT NULL
       DEFAULT ((0)),
   [audioContentType] [smallint] NOT NULL
       DEFAULT ((0)),
   [offensiveText] [nvarchar](max) NULL,
   [transcriptionConfidence] [float] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL,
   [transcriptionJson] [nvarchar](max) NULL,
   [reprocess] [tinyint] NULL,
   [managerReply] [nvarchar](max) NULL,
   [vociUUID] [nvarchar](50) NULL,
   [translatedText] [nvarchar](max) NULL,
   [commentTranslatedTextLengthBytes] [int] NULL,
   [commentTranslatedTextLengthChars] [int] NULL,
   [commentTranslatedTextLengthWords] [int] NULL

   ,CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Comment_commentType_transcriptionState_surveyResponseAnswer] ON [dbo].[Comment] ([commentType], [transcriptionState], [surveyResponseAnswerObjectId])
CREATE NONCLUSTERED INDEX [IX_Comment_reprocess] ON [dbo].[Comment] ([reprocess])
CREATE NONCLUSTERED INDEX [ix_comment_reprocessObjectid] ON [dbo].[Comment] ([reprocess]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_Comment_SurveyResponseAnswer_commentType_transcriptionState] ON [dbo].[Comment] ([surveyResponseAnswerObjectId], [commentType], [transcriptionState])
CREATE NONCLUSTERED INDEX [IX_Comment_UserAccount] ON [dbo].[Comment] ([audioTranscriptionUserObjectId])

GO
