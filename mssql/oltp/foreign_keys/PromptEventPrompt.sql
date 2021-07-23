ALTER TABLE [dbo].[PromptEventPrompt] WITH CHECK ADD CONSTRAINT [FK_PromptEventPrompt_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
