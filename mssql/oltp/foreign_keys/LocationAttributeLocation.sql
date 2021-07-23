ALTER TABLE [dbo].[LocationAttributeLocation] WITH CHECK ADD CONSTRAINT [FK_LocationAttributeLocation_LocationAttribute]
   FOREIGN KEY([attributeObjectId]) REFERENCES [dbo].[LocationAttribute] ([objectId])

GO
ALTER TABLE [dbo].[LocationAttributeLocation] WITH CHECK ADD CONSTRAINT [FK_LocationAttributeLocation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
