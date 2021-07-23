ALTER TABLE [dbo].[ReportHierarchyMapLabel] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMapLabel_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[ReportHierarchyMapLabel] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMapLabel_LocationCategoryType]
   FOREIGN KEY([levelObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[ReportHierarchyMapLabel] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMapLabel_ReportHierarchyMap]
   FOREIGN KEY([reportHierarchyMapObjectId]) REFERENCES [dbo].[ReportHierarchyMap] ([objectId])

GO
