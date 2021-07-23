ALTER TABLE [dbo].[SystemAnnouncementUserAccount] WITH CHECK ADD CONSTRAINT [FK_SystemAnnouncementUserAccount_SystemAnnouncement]
   FOREIGN KEY([systemAnnouncementObjectId]) REFERENCES [dbo].[SystemAnnouncement] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[SystemAnnouncementUserAccount] WITH CHECK ADD CONSTRAINT [FK_SystemAnnouncementUserAccount_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])
   ON DELETE CASCADE

GO
