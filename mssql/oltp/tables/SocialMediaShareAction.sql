CREATE TABLE [dbo].[SocialMediaShareAction] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [socialType] [int] NOT NULL,
   [promptObjectId] [int] NULL,
   [promptPhraseObjectId] [int] NULL,
   [pageId] [varchar](500) NULL,
   [actionHeader] [varchar](500) NULL,
   [actionText] [nvarchar](max) NULL,
   [actionTextPlain] [bit] NOT NULL,
   [actionURL] [varchar](500) NULL,
   [headerImageObjectId] [int] NULL,
   [actionImageObjectId] [int] NULL,
   [emailSubject] [varchar](500) NULL,
   [shareButtonText] [varchar](200) NULL,
   [socialLocationObjectId] [int] NULL,
   [audioOptionObjectId] [int] NULL

   ,CONSTRAINT [PK_SocialMediaShareAction] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SocialMediaShareAction_AudioOption] ON [dbo].[SocialMediaShareAction] ([audioOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_SocialMediaShareAction_promptObjectId] ON [dbo].[SocialMediaShareAction] ([promptObjectId])
CREATE NONCLUSTERED INDEX [IX_SocialMediaShareAction_SocialLocation] ON [dbo].[SocialMediaShareAction] ([socialLocationObjectId])

GO
