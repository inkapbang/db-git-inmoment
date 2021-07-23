ALTER TABLE [dbo].[HubViewHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_HubViewHierarchyMap_HierarchyID]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[HubViewHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_HubViewHierarchyMap_HubViewID]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])

GO
