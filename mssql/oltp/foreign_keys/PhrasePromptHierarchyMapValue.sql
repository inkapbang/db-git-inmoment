ALTER TABLE [dbo].[PhrasePromptHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_PhrasePromptHierarchyMapValue_Phrase]
   FOREIGN KEY([phraseObjectId]) REFERENCES [dbo].[Phrase] ([objectId])

GO
ALTER TABLE [dbo].[PhrasePromptHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_PhrasePromptHierarchyMapValue_PromptHierachyMapValue]
   FOREIGN KEY([promptHierarchyMapValueObjectId]) REFERENCES [dbo].[PromptHierarchyMapValue] ([objectId])

GO
