CREATE TABLE [dbo].[SweepstakesInstantWinTextPreset] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [buttonText] [nvarchar](max) NULL,
   [processingText] [nvarchar](max) NULL,
   [loserText] [nvarchar](max) NULL,
   [winnerText] [nvarchar](max) NULL,
   [loserImageObjectId] [int] NULL,
   [winnerImageObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [loserMobileImageObjectId] [int] NULL,
   [winnerMobileImageObjectId] [int] NULL,
   [phraseObjectId] [int] NULL

   ,CONSTRAINT [PK_SweepstakesInstantWinTextPreset] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_loserImageObjectId] ON [dbo].[SweepstakesInstantWinTextPreset] ([loserImageObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_winnerImageObjectId] ON [dbo].[SweepstakesInstantWinTextPreset] ([winnerImageObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinTextPreset_LoserMobileImage] ON [dbo].[SweepstakesInstantWinTextPreset] ([loserMobileImageObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinTextPreset_WinnerMobileImage] ON [dbo].[SweepstakesInstantWinTextPreset] ([winnerMobileImageObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesText_Phrase] ON [dbo].[SweepstakesInstantWinTextPreset] ([phraseObjectId])

GO
