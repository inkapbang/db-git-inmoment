CREATE TABLE [dbo].[Phrase] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [audioScript] [varchar](3000) NULL,
   [promptObjectId] [int] NULL,
   [audioObjectId] [int] NULL,
   [audioOptionObjectId] [int] NOT NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF__PromptAud__versi__48517AE8] DEFAULT (0),
   [webText] [nvarchar](max) NULL,
   [phraseType] [int] NOT NULL
      CONSTRAINT [DF__Phrase__phraseTy__2997E99E] DEFAULT (0),
   [promptChoiceObjectId] [int] NULL,
   [usageType] [int] NOT NULL,
   [hierarchyLocationWebText] [nvarchar](max) NULL,
   [hierarchyLocationPlaceholderText] [nvarchar](max) NULL,
   [contestRulesConfigObjectId] [int] NULL,
   [ghostText] [nvarchar](255) NULL,
   [customDatePattern] [varchar](100) NULL

   ,CONSTRAINT [PK_PromptAudio] PRIMARY KEY NONCLUSTERED ([objectId])
   ,CONSTRAINT [UQC_Prompt_AudioOption_UsageType_Choice_Rules] UNIQUE NONCLUSTERED ([promptObjectId], [audioOptionObjectId], [usageType], [promptChoiceObjectId], [contestRulesConfigObjectId])
)

CREATE NONCLUSTERED INDEX [IX_Phrase_audioObjectId] ON [dbo].[Phrase] ([audioObjectId])
CREATE NONCLUSTERED INDEX [IX_Phrase_AudioOption_phraseType] ON [dbo].[Phrase] ([audioOptionObjectId], [phraseType]) INCLUDE ([audioScript], [audioObjectId], [version], [webText], [usageType])
CREATE NONCLUSTERED INDEX [IX_Phrase_audioOptionObjectId_phraseType] ON [dbo].[Phrase] ([audioOptionObjectId], [phraseType]) INCLUDE ([objectId], [audioScript], [audioObjectId], [version], [webText], [usageType])
CREATE CLUSTERED INDEX [IX_Phrase_by_Prompt] ON [dbo].[Phrase] ([promptObjectId])
CREATE NONCLUSTERED INDEX [IX_Phrase_contestRulesConfigObjectId] ON [dbo].[Phrase] ([contestRulesConfigObjectId])
CREATE NONCLUSTERED INDEX [IX_Phrase_PromptChoice] ON [dbo].[Phrase] ([promptChoiceObjectId])

GO
