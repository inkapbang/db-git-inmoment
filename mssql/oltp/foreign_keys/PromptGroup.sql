ALTER TABLE [dbo].[PromptGroup] WITH CHECK ADD CONSTRAINT [FK_PromptGroup_GroupPrompt]
   FOREIGN KEY([promptGroupPromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[PromptGroup] WITH CHECK ADD CONSTRAINT [FK_PromptGroup_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
