ALTER TABLE [dbo].[GoRecommendText] WITH CHECK ADD CONSTRAINT [FK_GoRecommendText_PromptPhrase]
   FOREIGN KEY([phraseObjectId]) REFERENCES [dbo].[Phrase] ([objectId])
   ON DELETE CASCADE

GO
