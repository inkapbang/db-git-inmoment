ALTER TABLE [dbo].[PromptEventTriggerDeviceType] WITH CHECK ADD CONSTRAINT [FK_PromptEventTriggerDeviceType_PromptEvent]
   FOREIGN KEY([promptEventObjectId]) REFERENCES [dbo].[PromptEvent] ([objectId])

GO
