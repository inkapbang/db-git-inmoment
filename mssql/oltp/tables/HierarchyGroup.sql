CREATE TABLE [dbo].[HierarchyGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [reportHierarchyMapObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NULL,
   [name] [nvarchar](50) NOT NULL

   ,CONSTRAINT [PK_HierarchyGroup] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyGroup_LocationCategoryType] ON [dbo].[HierarchyGroup] ([locationCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyGroup_Organization] ON [dbo].[HierarchyGroup] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyGroup_ReportHierarchyMap] ON [dbo].[HierarchyGroup] ([reportHierarchyMapObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyGroup_UserAccount] ON [dbo].[HierarchyGroup] ([userAccountObjectId])

GO
