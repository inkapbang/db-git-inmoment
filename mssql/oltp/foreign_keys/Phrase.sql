ALTER TABLE [dbo].[Phrase] WITH CHECK ADD CONSTRAINT [FK_Phrase_PromptAudio_audio]
   FOREIGN KEY([audioObjectId]) REFERENCES [dbo].[PromptAudio] ([objectId])

GO
ALTER TABLE [dbo].[Phrase] WITH CHECK ADD CONSTRAINT [FK_PromptAudio_AudioOption]
   FOREIGN KEY([audioOptionObjectId]) REFERENCES [dbo].[AudioOption] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[Phrase] WITH CHECK ADD CONSTRAINT [FK_Phrase_ContestRulesConfig]
   FOREIGN KEY([contestRulesConfigObjectId]) REFERENCES [dbo].[ContestRulesConfig] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[Phrase] WITH CHECK ADD CONSTRAINT [FK__Phrase__promptCh__2C745649]
   FOREIGN KEY([promptChoiceObjectId]) REFERENCES [dbo].[PromptChoice] ([objectId])

GO
ALTER TABLE [dbo].[Phrase] WITH CHECK ADD CONSTRAINT [FK_PromptAudio_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])
   ON DELETE CASCADE

GO
