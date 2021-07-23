ALTER TABLE [dbo].[HierarchyGroupItem] WITH CHECK ADD CONSTRAINT [FK_HierarchyGroup_OrganizationalUnit]
   FOREIGN KEY([organizationalUnitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])
   ON DELETE CASCADE

GO
