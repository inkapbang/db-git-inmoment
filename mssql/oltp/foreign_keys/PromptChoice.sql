ALTER TABLE [dbo].[PromptChoice] WITH CHECK ADD CONSTRAINT [FK_PromptChoice_DataFieldOption]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO
ALTER TABLE [dbo].[PromptChoice] WITH CHECK ADD CONSTRAINT [FK_PromptChoice_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])
   ON DELETE CASCADE

GO
