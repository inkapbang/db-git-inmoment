ALTER TABLE [dbo].[LocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryType_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryType_HierarchySnapshot]
   FOREIGN KEY([hierarchySnapshotObjectId]) REFERENCES [dbo].[HierarchySnapshot] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryType_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
