CREATE TABLE [databus].[_DatabusLocationAttributeLocationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [locationObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationAttributeLocationCTCache_locationObjectId_attributeObjectId] PRIMARY KEY CLUSTERED ([locationObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationAttributeLocationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationAttributeLocationCTCache] ([ctVersion], [ctSurrogateKey])

GO
