CREATE TABLE [databus].[_DatabusOfferCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOfferCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOfferCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOfferCTCache] ([ctVersion], [ctSurrogateKey])

GO
