ALTER TABLE [dbo].[HubViewLocationAttribute] WITH CHECK ADD CONSTRAINT [FK_HubViewLocationAttribute_HubView]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])

GO
ALTER TABLE [dbo].[HubViewLocationAttribute] WITH CHECK ADD CONSTRAINT [FK_HubViewLocationAttribute_LocationAttribute]
   FOREIGN KEY([locationAttributeObjectId]) REFERENCES [dbo].[LocationAttribute] ([objectId])

GO
