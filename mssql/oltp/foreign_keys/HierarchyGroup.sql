ALTER TABLE [dbo].[HierarchyGroup] WITH CHECK ADD CONSTRAINT [FK_HierarchyGroup_LocationCategoryType]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HierarchyGroup] WITH CHECK ADD CONSTRAINT [FK_HierarchyGroup_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HierarchyGroup] WITH CHECK ADD CONSTRAINT [FK_HierarchyGroup_ReportHierarchyMap]
   FOREIGN KEY([reportHierarchyMapObjectId]) REFERENCES [dbo].[ReportHierarchyMap] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HierarchyGroup] WITH CHECK ADD CONSTRAINT [FK_HierarchyGroup_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])
   ON DELETE CASCADE

GO
