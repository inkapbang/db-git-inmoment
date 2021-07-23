CREATE TABLE [databus].[_DatabusWebServiceClientTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [webServiceClientObjectId] [int] NOT NULL,
   [clientType] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusWebServiceClientTypeCTCache_webServiceClientObjectId_clientType] PRIMARY KEY CLUSTERED ([webServiceClientObjectId], [clientType])
)

CREATE NONCLUSTERED INDEX [IX__DatabusWebServiceClientTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusWebServiceClientTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
