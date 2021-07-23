ALTER TABLE [dbo].[HierarchySnapshot] WITH CHECK ADD CONSTRAINT [FK_HierarchySnapshotCreatedUserObjectId_UserAccount]
   FOREIGN KEY([createdUserAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
ALTER TABLE [dbo].[HierarchySnapshot] WITH CHECK ADD CONSTRAINT [FK_HierarchySnapshot_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[HierarchySnapshot] WITH CHECK ADD CONSTRAINT [FK_HierarchySnapshotModifiedUserObjectId_UserAccount]
   FOREIGN KEY([modifiedUserAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
