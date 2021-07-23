ALTER TABLE [dbo].[HierarchyTransformRuleSet] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformRuleSet_HierarchyTransform]
   FOREIGN KEY([hierarchyTransformObjectId]) REFERENCES [dbo].[HierarchyTransform] ([objectId])

GO
