ALTER TABLE [dbo].[Location] WITH CHECK ADD CONSTRAINT [FK_Location_Address]
   FOREIGN KEY([addressObjectId]) REFERENCES [dbo].[Address] ([objectId])

GO
ALTER TABLE [dbo].[Location] WITH CHECK ADD CONSTRAINT [FK_BrandObjectId_Brand]
   FOREIGN KEY([brandObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[Location] WITH CHECK ADD CONSTRAINT [FK_Location_ContactInfo]
   FOREIGN KEY([contactInfoObjectId]) REFERENCES [dbo].[ContactInfo] ([objectId])

GO
ALTER TABLE [dbo].[Location] WITH CHECK ADD CONSTRAINT [FK_Location_Image_logo]
   FOREIGN KEY([logoObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[Location] WITH CHECK ADD CONSTRAINT [FK_Location_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
