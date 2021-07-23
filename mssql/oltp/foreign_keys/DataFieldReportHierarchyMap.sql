ALTER TABLE [dbo].[DataFieldReportHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_DataFieldReportHierarchyMap_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldReportHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_DataFieldReportHierarchyMap_ReportHierarchyMap]
   FOREIGN KEY([reportHierarchyMapObjectId]) REFERENCES [dbo].[ReportHierarchyMap] ([objectId])

GO
