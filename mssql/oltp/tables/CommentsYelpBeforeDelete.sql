CREATE TABLE [dbo].[CommentsYelpBeforeDelete] (
   [objectId] [int] NOT NULL,
   [audio] [varbinary](max) NULL,
   [audioLengthBytes] [int] NULL,
   [version] [int] NOT NULL,
   [encrypted] [bit] NULL,
   [encryptiontype] [tinyint] NULL,
   [surveyResponseAnswerObjectId] [bigint] NOT NULL,
   [commentType] [tinyint] NOT NULL,
   [commentText] [nvarchar](max) NULL,
   [commentTextLengthBytes] [int] NULL,
   [commentTextLengthChars] [int] NULL,
   [commentTextLengthWords] [int] NOT NULL,
   [commentLanguage] [int] NULL,
   [audioTranscriptionDate] [datetime] NULL,
   [audioTranscriptionUserObjectId] [int] NULL,
   [transcriptionState] [tinyint] NOT NULL,
   [audioContentType] [smallint] NOT NULL,
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
)


GO
