ALTER TABLE [dbo].[SocialLocation] WITH CHECK ADD CONSTRAINT [FK_SocialLocation_Image_actionImageId]
   FOREIGN KEY([actionImageId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[SocialLocation] WITH CHECK ADD CONSTRAINT [FK_SocialLocation_Image_headerImageId]
   FOREIGN KEY([headerImageId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[SocialLocation] WITH CHECK ADD CONSTRAINT [FK_SocialLocation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])
   ON DELETE CASCADE

GO
