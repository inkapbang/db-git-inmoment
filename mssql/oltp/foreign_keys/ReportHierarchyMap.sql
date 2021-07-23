ALTER TABLE [dbo].[ReportHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMap_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[ReportHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_ReportHierarchyMap_Label_LocalizedString]
   FOREIGN KEY([labelId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
