CREATE TABLE [databus].[_DatabusHubViewGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewGroupCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO
