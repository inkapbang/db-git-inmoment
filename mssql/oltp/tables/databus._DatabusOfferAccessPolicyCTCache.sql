CREATE TABLE [databus].[_DatabusOfferAccessPolicyCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOfferAccessPolicyCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOfferAccessPolicyCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOfferAccessPolicyCTCache] ([ctVersion], [ctSurrogateKey])

GO
