CREATE TABLE [dbo].[HubViewHierarchyLocationLevelAccess] (
   [hubViewObjectId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HubViewHierarchyLocationLevelAccess] PRIMARY KEY CLUSTERED ([hubViewObjectId], [hierarchyObjectId])
)


GO
