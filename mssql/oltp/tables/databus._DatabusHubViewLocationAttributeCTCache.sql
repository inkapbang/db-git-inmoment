CREATE TABLE [databus].[_DatabusHubViewLocationAttributeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [hubViewObjectId] [int] NOT NULL,
   [locationAttributeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewLocationAttributeCTCache_hubViewObjectId_locationAttributeObjectId] PRIMARY KEY CLUSTERED ([hubViewObjectId], [locationAttributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewLocationAttributeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewLocationAttributeCTCache] ([ctVersion], [ctSurrogateKey])

GO
