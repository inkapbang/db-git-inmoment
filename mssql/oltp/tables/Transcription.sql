CREATE TABLE [dbo].[Transcription] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [userAccountObjectId] [int] NOT NULL,
   [transcriptionTime] [datetime] NOT NULL,
   [transcript] [nvarchar](max) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [encrypted] [bit] NULL
       DEFAULT ((0)),
   [encryptiontype] [tinyint] NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_Transcription] PRIMARY KEY NONCLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Transcription_userAccountObjectId] ON [dbo].[Transcription] ([userAccountObjectId])

GO
