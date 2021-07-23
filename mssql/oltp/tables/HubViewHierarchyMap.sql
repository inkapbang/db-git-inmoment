CREATE TABLE [dbo].[HubViewHierarchyMap] (
   [hubViewObjectId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HubViewID_HierarchyID] PRIMARY KEY CLUSTERED ([hubViewObjectId], [hierarchyObjectId])
)

CREATE NONCLUSTERED INDEX [IX_HubViewHierarchyMap_hierarchyObjectId] ON [dbo].[HubViewHierarchyMap] ([hierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_HubViewHierarchyMap_hubViewObjectId] ON [dbo].[HubViewHierarchyMap] ([hubViewObjectId])

GO
