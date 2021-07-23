CREATE TABLE [dbo].[HierarchyGroupItem] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [hierarchyGroupObjectId] [int] NOT NULL,
   [organizationalUnitObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HierarchyGroupItem] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyGroupItem_FK_HierarchyGroup_OrganizationalUnit] ON [dbo].[HierarchyGroupItem] ([organizationalUnitObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyGroupItem_hierarchyGroupObjectId] ON [dbo].[HierarchyGroupItem] ([hierarchyGroupObjectId])

GO
