CREATE TABLE [databus].[_DatabusOfferCodeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOfferCodeCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOfferCodeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOfferCodeCTCache] ([ctVersion], [ctSurrogateKey])

GO
