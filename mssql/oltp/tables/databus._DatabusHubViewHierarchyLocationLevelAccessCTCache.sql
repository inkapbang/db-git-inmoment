CREATE TABLE [databus].[_DatabusHubViewHierarchyLocationLevelAccessCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [hubViewObjectId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewHierarchyLocationLevelAccessCTCache_hubViewObjectId_hierarchyObjectId] PRIMARY KEY CLUSTERED ([hubViewObjectId], [hierarchyObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewHierarchyLocationLevelAccessCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewHierarchyLocationLevelAccessCTCache] ([ctVersion], [ctSurrogateKey])

GO
