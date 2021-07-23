ALTER TABLE [dbo].[SystemAnnouncement] WITH CHECK ADD CONSTRAINT [FK_SystemAnnouncement_customMessage]
   FOREIGN KEY([customMessageObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[SystemAnnouncement] WITH CHECK ADD CONSTRAINT [FK_SystemAnnouncement_customTitle]
   FOREIGN KEY([customTitleObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
