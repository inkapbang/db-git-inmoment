CREATE TABLE [dbo].[FocusHierarchyMap] (
   [settingsObjectId] [int] NOT NULL,
   [hierarchyMapObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_FocusHierarchyMap] PRIMARY KEY CLUSTERED ([settingsObjectId], [hierarchyMapObjectId])
)

CREATE NONCLUSTERED INDEX [IX_FocusHierarchyMap_ReportHierarchyMap] ON [dbo].[FocusHierarchyMap] ([hierarchyMapObjectId])
CREATE NONCLUSTERED INDEX [IX_FocusHierarchyMap_settingsObjectId] ON [dbo].[FocusHierarchyMap] ([settingsObjectId])

GO
