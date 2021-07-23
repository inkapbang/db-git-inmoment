ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_CertCodeDataField]
   FOREIGN KEY([certCodeDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_EmailDataField]
   FOREIGN KEY([emailDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_EnteredSweepsPrompt]
   FOREIGN KEY([enteredSweepstakesPromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_FirstNameDataField]
   FOREIGN KEY([firstNameDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_LastNameDataField]
   FOREIGN KEY([lastNameDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_PhoneDataField]
   FOREIGN KEY([phoneDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinPromptConfig] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinPromptConfig_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])
   ON DELETE CASCADE

GO
