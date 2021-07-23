CREATE TABLE [dbo].[SweepstakesInstantWinPromptConfig] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [promptObjectId] [int] NULL,
   [sweepstakesInteraction] [int] NULL,
   [surveyId] [int] NULL,
   [clientId] [int] NULL,
   [brandName] [varchar](500) NULL,
   [certCodeDataFieldObjectId] [int] NULL,
   [firstNameDataFieldObjectId] [int] NULL,
   [lastNameDataFieldObjectId] [int] NULL,
   [emailDataFieldObjectId] [int] NULL,
   [phoneDataFieldObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [incentiveId] [int] NULL,
   [noThanksText] [nvarchar](255) NULL,
   [enteredSweepstakesPromptObjectId] [int] NULL

   ,CONSTRAINT [PK_SweepstakesInstantWinPromptConfig] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_certCodeDataFieldObjectId] ON [dbo].[SweepstakesInstantWinPromptConfig] ([certCodeDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_emailDataFieldObjectId] ON [dbo].[SweepstakesInstantWinPromptConfig] ([emailDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_EnteredSweepsPrompt] ON [dbo].[SweepstakesInstantWinPromptConfig] ([enteredSweepstakesPromptObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_firstNameDataFieldObjectId] ON [dbo].[SweepstakesInstantWinPromptConfig] ([firstNameDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_lastNameDataFieldObjectId] ON [dbo].[SweepstakesInstantWinPromptConfig] ([lastNameDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_phoneDataFieldObjectId] ON [dbo].[SweepstakesInstantWinPromptConfig] ([phoneDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_SweepstakesInstantWinPromptConfig_promptObjectId] ON [dbo].[SweepstakesInstantWinPromptConfig] ([promptObjectId])

GO
