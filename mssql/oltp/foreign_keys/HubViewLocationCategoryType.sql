ALTER TABLE [dbo].[HubViewLocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_HubViewLocationCategoryType_HubView]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])

GO
ALTER TABLE [dbo].[HubViewLocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_HubViewLocationCategoryType_LocationCategoryType]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
