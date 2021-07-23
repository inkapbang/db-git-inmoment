CREATE TABLE [dbo].[DataFieldReportHierarchyMap] (
   [dataFieldObjectId] [int] NOT NULL,
   [reportHierarchyMapObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK__DataFiel__51BBF5724F75A5CF] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [reportHierarchyMapObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldReportHierarchyMap_ReportHierarchyMap] ON [dbo].[DataFieldReportHierarchyMap] ([reportHierarchyMapObjectId])

GO
