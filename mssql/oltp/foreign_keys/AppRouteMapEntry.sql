ALTER TABLE [dbo].[AppRouteMapEntry] WITH CHECK ADD CONSTRAINT [FK_AppRouteMapEntry_by_locationCategoryTypeObjectId]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[AppRouteMapEntry] WITH CHECK ADD CONSTRAINT [FK_AppRouteMapEntry_by_mapObjectId]
   FOREIGN KEY([mapObjectId]) REFERENCES [dbo].[AppRouteMap] ([objectId])

GO
