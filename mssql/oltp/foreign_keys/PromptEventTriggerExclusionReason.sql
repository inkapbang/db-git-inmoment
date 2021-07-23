ALTER TABLE [dbo].[PromptEventTriggerExclusionReason] WITH CHECK ADD CONSTRAINT [FK_PromptEventTriggerExclusionReason_PromptEvent]
   FOREIGN KEY([promptEventObjectId]) REFERENCES [dbo].[PromptEvent] ([objectId])

GO
