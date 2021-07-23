ALTER TABLE [dbo].[ReportHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMapValue_LocationCategoryType]
   FOREIGN KEY([levelObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[ReportHierarchyMapValue] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMapValue_ReportHierarchyMap]
   FOREIGN KEY([reportHierarchyMapObjectId]) REFERENCES [dbo].[ReportHierarchyMap] ([objectId])

GO
