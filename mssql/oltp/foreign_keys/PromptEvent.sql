ALTER TABLE [dbo].[PromptEvent] WITH CHECK ADD CONSTRAINT [FK_PromptEvent_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])
   ON DELETE CASCADE

GO
