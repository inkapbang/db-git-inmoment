ALTER TABLE [dbo].[FocusHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_FocusHierarchyMap_ReportHierarchyMap]
   FOREIGN KEY([hierarchyMapObjectId]) REFERENCES [dbo].[ReportHierarchyMap] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[FocusHierarchyMap] WITH CHECK ADD CONSTRAINT [FK_FocusHierarchyMap_OrganizationFocusSettings]
   FOREIGN KEY([settingsObjectId]) REFERENCES [dbo].[OrganizationFocusSettings] ([objectId])
   ON DELETE CASCADE

GO
