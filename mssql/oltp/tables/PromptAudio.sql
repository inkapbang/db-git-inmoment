CREATE TABLE [dbo].[PromptAudio] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](250) NULL,
   [contentType] [int] NOT NULL,
   [content] [varbinary](max) NULL,
   [length] [int] NOT NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [secure] [tinyint] NULL
      CONSTRAINT [promptaudio_secure_default] DEFAULT ((0)),
   [blobUuid] [varchar](36) NULL
      CONSTRAINT [promptaudio_blobuuid_default] DEFAULT (CONVERT([varchar](36),newid(),0))

   ,CONSTRAINT [PK_PromptAudio1] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IXNC_PromptAudio_objectId_INCLUDE_contentType_lastModifiedDate_length_name_version] ON [dbo].[PromptAudio] ([objectId]) INCLUDE ([contentType], [lastModifiedDate], [length], [name], [version])
CREATE UNIQUE NONCLUSTERED INDEX [UK_PromptAudio_blobUuid] ON [dbo].[PromptAudio] ([blobUuid]) WHERE ([blobUuid] IS NOT NULL)

GO
