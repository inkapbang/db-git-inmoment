ALTER TABLE [dbo].[HierarchyTransformRule] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformRuleConditional_HierarchyTransformBinding]
   FOREIGN KEY([conditionalBindingObjectId]) REFERENCES [dbo].[HierarchyTransformBinding] ([objectId])

GO
ALTER TABLE [dbo].[HierarchyTransformRule] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformRule_HierarchyTransformRuleSet]
   FOREIGN KEY([hierarchyTransformRuleSetObjectId]) REFERENCES [dbo].[HierarchyTransformRuleSet] ([objectId])

GO
ALTER TABLE [dbo].[HierarchyTransformRule] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransformRuleInput_HierarchyTransformBinding]
   FOREIGN KEY([inputBindingObjectId]) REFERENCES [dbo].[HierarchyTransformBinding] ([objectId])

GO
