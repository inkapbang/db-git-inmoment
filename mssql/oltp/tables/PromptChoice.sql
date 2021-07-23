CREATE TABLE [dbo].[PromptChoice] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [promptObjectId] [int] NULL,
   [token] [nvarchar](2000) NOT NULL,
   [dtmf] [smallint] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [dataFieldOptionObjectId] [int] NULL,
   [voiceToken] [varchar](200) NULL,
   [sequence] [int] NULL,
   [drool] [varchar](4000) NULL,
   [naOption] [bit] NULL,
   [otherOption] [bit] NULL,
   [randomizeOption] [bit] NULL,
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [IX_PromptChoice_UniqueDtmf] UNIQUE NONCLUSTERED ([promptObjectId], [dtmf])
   ,CONSTRAINT [PK_PromptChoice] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptChoice_DataFieldOption] ON [dbo].[PromptChoice] ([dataFieldOptionObjectId])

GO
