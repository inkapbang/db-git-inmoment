CREATE TABLE [databus].[_DatabusHierarchyCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHierarchyCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHierarchyCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHierarchyCTCache] ([ctVersion], [ctSurrogateKey])

GO
