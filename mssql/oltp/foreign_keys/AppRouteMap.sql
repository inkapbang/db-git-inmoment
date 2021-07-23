ALTER TABLE [dbo].[AppRouteMap] WITH CHECK ADD CONSTRAINT [FK_AppRouteMap_by_hierarchyObjectId]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
