CREATE TABLE [dbo].[ReportHierarchyMap] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NOT NULL,
   [labelId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL,
   [includeLocations] [bit] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_ReportHierarchyMap] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMap_hierarchyObjectId_labelId] ON [dbo].[ReportHierarchyMap] ([hierarchyObjectId], [labelId])
CREATE NONCLUSTERED INDEX [IX_ReportHierarchyMap_Label_LocalizedString] ON [dbo].[ReportHierarchyMap] ([labelId])

GO
