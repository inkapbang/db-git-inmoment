ALTER TABLE [dbo].[CombinedTextPromptMapping] WITH CHECK ADD CONSTRAINT [FK_CombinedTextPromptMapping_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[CombinedTextPromptMapping] WITH CHECK ADD CONSTRAINT [FK_CombinedTextPromptMapping_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
