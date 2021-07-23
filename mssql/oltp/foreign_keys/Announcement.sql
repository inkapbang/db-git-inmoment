ALTER TABLE [dbo].[Announcement] WITH CHECK ADD CONSTRAINT [FK_Announcement_Content_LocalizedString]
   FOREIGN KEY([contentObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Announcement] WITH CHECK ADD CONSTRAINT [FK_Announcement_Name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Announcement] WITH CHECK ADD CONSTRAINT [FK_Announcement_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
