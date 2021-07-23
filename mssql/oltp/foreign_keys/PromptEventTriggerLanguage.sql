ALTER TABLE [dbo].[PromptEventTriggerLanguage] WITH CHECK ADD CONSTRAINT [FK_PromptEventTriggerLanguage_PromptEvent]
   FOREIGN KEY([promptEventObjectId]) REFERENCES [dbo].[PromptEvent] ([objectId])

GO
