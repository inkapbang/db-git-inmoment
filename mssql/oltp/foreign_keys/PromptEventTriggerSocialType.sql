ALTER TABLE [dbo].[PromptEventTriggerSocialType] WITH CHECK ADD CONSTRAINT [FK_PromptEventTriggerSocialType_PromptEvent]
   FOREIGN KEY([promptEventObjectId]) REFERENCES [dbo].[PromptEvent] ([objectId])

GO
