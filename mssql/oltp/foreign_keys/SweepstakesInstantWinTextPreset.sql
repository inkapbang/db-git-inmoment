ALTER TABLE [dbo].[SweepstakesInstantWinTextPreset] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinTextPreset_LoserImage]
   FOREIGN KEY([loserImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinTextPreset] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinTextPreset_LoserMobileImage]
   FOREIGN KEY([loserMobileImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinTextPreset] WITH CHECK ADD CONSTRAINT [FK_SweepstakesText_Phrase]
   FOREIGN KEY([phraseObjectId]) REFERENCES [dbo].[Phrase] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinTextPreset] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinTextPreset_WinnerImage]
   FOREIGN KEY([winnerImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[SweepstakesInstantWinTextPreset] WITH CHECK ADD CONSTRAINT [FK_SweepstakesInstantWinTextPreset_WinnerMobileImage]
   FOREIGN KEY([winnerMobileImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
