ALTER TABLE [dbo].[PromptHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_PromptHierarchyMap_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
