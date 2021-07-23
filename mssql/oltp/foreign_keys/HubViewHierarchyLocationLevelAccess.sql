ALTER TABLE [dbo].[HubViewHierarchyLocationLevelAccess] WITH CHECK ADD CONSTRAINT [FK_HubViewHierarchyLocationLevelAccess_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[HubViewHierarchyLocationLevelAccess] WITH CHECK ADD CONSTRAINT [FK_HubViewHierarchyLocationLevelAccess_HubView]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])

GO
