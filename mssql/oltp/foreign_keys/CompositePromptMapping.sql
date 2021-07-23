ALTER TABLE [dbo].[CompositePromptMapping] WITH CHECK ADD CONSTRAINT [FK_CompositePromptMapping_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[CompositePromptMapping] WITH CHECK ADD CONSTRAINT [FK_CompositePromptMapping_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
