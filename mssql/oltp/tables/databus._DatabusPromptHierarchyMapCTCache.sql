CREATE TABLE [databus].[_DatabusPromptHierarchyMapCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptHierarchyMapCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptHierarchyMapCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptHierarchyMapCTCache] ([ctVersion], [ctSurrogateKey])

GO
