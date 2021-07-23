CREATE TABLE [databus].[_DatabusLocationUpliftModelRegressionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [locationObjectId] [int] NOT NULL,
   [regressionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationUpliftModelRegressionCTCache_locationObjectId_regressionObjectId] PRIMARY KEY CLUSTERED ([locationObjectId], [regressionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationUpliftModelRegressionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationUpliftModelRegressionCTCache] ([ctVersion], [ctSurrogateKey])

GO
