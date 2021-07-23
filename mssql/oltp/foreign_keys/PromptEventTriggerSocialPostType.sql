ALTER TABLE [dbo].[PromptEventTriggerSocialPostType] WITH CHECK ADD CONSTRAINT [FK_PromptEventTriggerSocialPostType_PromptEvent]
   FOREIGN KEY([promptEventObjectId]) REFERENCES [dbo].[PromptEvent] ([objectId])

GO
