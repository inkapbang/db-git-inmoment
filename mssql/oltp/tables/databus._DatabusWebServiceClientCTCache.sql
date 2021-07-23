CREATE TABLE [databus].[_DatabusWebServiceClientCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusWebServiceClientCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusWebServiceClientCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusWebServiceClientCTCache] ([ctVersion], [ctSurrogateKey])

GO
