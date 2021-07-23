CREATE TABLE [databus].[_DatabusUpliftModelRegressionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUpliftModelRegressionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUpliftModelRegressionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUpliftModelRegressionCTCache] ([ctVersion], [ctSurrogateKey])

GO
