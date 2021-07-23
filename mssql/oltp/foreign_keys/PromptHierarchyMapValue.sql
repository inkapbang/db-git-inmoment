ALTER TABLE [dbo].[PromptHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_PromptHierarchyMapValue_LocationCategoryType]
   FOREIGN KEY([levelObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[PromptHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_PromptHierarchyMapValue_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[PromptHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_PromptHierarchyMapValue_PromptHierarchyMap]
   FOREIGN KEY([promptHierarchyMapObjectId]) REFERENCES [dbo].[PromptHierarchyMap] ([objectId])

GO
