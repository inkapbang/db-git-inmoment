ALTER TABLE [dbo].[HierarchyTransformBinding] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformBinding_HierarchyTransformRule]
   FOREIGN KEY([hierarchyTransformRuleObjectId]) REFERENCES [dbo].[HierarchyTransformRule] ([objectId])

GO
