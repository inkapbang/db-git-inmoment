CREATE TABLE [databus].[_DatabusHubViewFilterDataFieldOptionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [hubViewFilterObjectId] [bigint] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewFilterDataFieldOptionCTCache_hubViewFilterObjectId_dataFieldOptionObjectId] PRIMARY KEY CLUSTERED ([hubViewFilterObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewFilterDataFieldOptionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewFilterDataFieldOptionCTCache] ([ctVersion], [ctSurrogateKey])

GO
