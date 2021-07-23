ALTER TABLE [dbo].[UserAccountLocationSnapshot] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocationSnapshot_hierarchySnapshotObjectId]
   FOREIGN KEY([hierarchySnapshotObjectId]) REFERENCES [dbo].[HierarchySnapshot] ([objectId])

GO
ALTER TABLE [dbo].[UserAccountLocationSnapshot] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocationSnapshot_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[UserAccountLocationSnapshot] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocationSnapshot_UserAccountObjectId]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
