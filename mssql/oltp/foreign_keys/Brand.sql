ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_Image_Banner]
   FOREIGN KEY([bannerObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_Image_Logo]
   FOREIGN KEY([logoObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_by_logotypeObjectId]
   FOREIGN KEY([logotypeObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_ParentBrand]
   FOREIGN KEY([parentObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_Image_ReviewBanner]
   FOREIGN KEY([reviewBannerObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[Brand] WITH CHECK ADD CONSTRAINT [FK_Brand_Image_ReviewDefaultLocation]
   FOREIGN KEY([reviewDefaultLocationObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
