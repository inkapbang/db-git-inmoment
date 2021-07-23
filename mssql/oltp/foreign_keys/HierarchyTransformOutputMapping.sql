ALTER TABLE [dbo].[HierarchyTransformOutputMapping] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformOutputMapping_HierarchyTransformRuleSet]
   FOREIGN KEY([hierarchyTransformRuleSetObjectId]) REFERENCES [dbo].[HierarchyTransformRuleSet] ([objectId])

GO
