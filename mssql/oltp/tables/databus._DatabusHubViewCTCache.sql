CREATE TABLE [databus].[_DatabusHubViewCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewCTCache] ([ctVersion], [ctSurrogateKey])

GO
