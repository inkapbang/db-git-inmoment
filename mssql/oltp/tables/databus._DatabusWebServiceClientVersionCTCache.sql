CREATE TABLE [databus].[_DatabusWebServiceClientVersionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusWebServiceClientVersionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusWebServiceClientVersionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusWebServiceClientVersionCTCache] ([ctVersion], [ctSurrogateKey])

GO
