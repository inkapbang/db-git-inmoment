CREATE TABLE [databus].[_DatabusOfferSurveyCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOfferSurveyCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOfferSurveyCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOfferSurveyCTCache] ([ctVersion], [ctSurrogateKey])

GO
