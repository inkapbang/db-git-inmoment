CREATE TABLE [databus].[_DatabusHubViewFilterCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [bigint] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewFilterCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewFilterCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewFilterCTCache] ([ctVersion], [ctSurrogateKey])

GO
