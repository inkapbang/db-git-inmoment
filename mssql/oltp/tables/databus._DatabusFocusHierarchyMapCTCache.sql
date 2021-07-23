CREATE TABLE [databus].[_DatabusFocusHierarchyMapCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [settingsObjectId] [int] NOT NULL,
   [hierarchyMapObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusFocusHierarchyMapCTCache_settingsObjectId_hierarchyMapObjectId] PRIMARY KEY CLUSTERED ([settingsObjectId], [hierarchyMapObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusFocusHierarchyMapCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusFocusHierarchyMapCTCache] ([ctVersion], [ctSurrogateKey])

GO
