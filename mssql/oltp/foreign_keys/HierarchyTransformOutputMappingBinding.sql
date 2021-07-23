ALTER TABLE [dbo].[HierarchyTransformOutputMappingBinding] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformOutputMappingBinding_HierarchyTransformBinding]
   FOREIGN KEY([hierarchyTransformBindingObjectId]) REFERENCES [dbo].[HierarchyTransformBinding] ([objectId])

GO
ALTER TABLE [dbo].[HierarchyTransformOutputMappingBinding] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformOutputMappingBinding_HierarchyTransformOutputMapping]
   FOREIGN KEY([hierarchyTransformOutputMappingObjectId]) REFERENCES [dbo].[HierarchyTransformOutputMapping] ([objectId])

GO
