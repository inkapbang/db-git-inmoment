ALTER TABLE [dbo].[PushDestinationEntitySettings] WITH CHECK ADD CONSTRAINT [FK_PushDestinationEntitySettings_PushDestination]
   FOREIGN KEY([pushDestinationObjectId]) REFERENCES [dbo].[PushDestination] ([objectId])

GO
