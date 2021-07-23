ALTER TABLE [dbo].[DataFieldTranscriptionPrompt] WITH CHECK ADD CONSTRAINT [FK_DataFieldTranscriptionPrompt_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldTranscriptionPrompt] WITH CHECK ADD CONSTRAINT [FK_DataFieldTranscriptionPrompt_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
