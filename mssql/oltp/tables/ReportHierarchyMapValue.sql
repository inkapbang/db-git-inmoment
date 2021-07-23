CREATE TABLE [dbo].[ReportHierarchyMapValue] (
   [reportHierarchyMapObjectId] [int] NOT NULL,
   [levelObjectId] [int] NOT NULL,
   [isVisibleInReport] [bit] NOT NULL

   ,CONSTRAINT [PK_ReportHierarchyMapValue] PRIMARY KEY CLUSTERED ([reportHierarchyMapObjectId], [levelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMapValue_LocationCategoryType] ON [dbo].[ReportHierarchyMapValue] ([levelObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMapValue_reportHierarchyMapObjectId] ON [dbo].[ReportHierarchyMapValue] ([reportHierarchyMapObjectId])

GO
