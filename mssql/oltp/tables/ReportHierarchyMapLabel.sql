CREATE TABLE [dbo].[ReportHierarchyMapLabel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [reportHierarchyMapObjectId] [int] NOT NULL,
   [levelObjectId] [int] NULL,
   [labelObjectId] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_ReportHierarchyMapLabel] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_ReportHierarchyMapLabel_ReportHierarchyMapLocationCategory] UNIQUE NONCLUSTERED ([reportHierarchyMapObjectId], [levelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMapLabel_LocalizedString] ON [dbo].[ReportHierarchyMapLabel] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMapLabel_LocationCategoryType] ON [dbo].[ReportHierarchyMapLabel] ([levelObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMapLabel_ReportHierarchyMap] ON [dbo].[ReportHierarchyMapLabel] ([reportHierarchyMapObjectId])

GO
