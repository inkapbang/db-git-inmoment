CREATE TABLE [databus].[_DatabusLocationCategoryUpliftModelRegressionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [locationCategoryObjectId] [int] NOT NULL,
   [regressionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationCategoryUpliftModelRegressionCTCache_locationCategoryObjectId_regressionObjectId] PRIMARY KEY CLUSTERED ([locationCategoryObjectId], [regressionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationCategoryUpliftModelRegressionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationCategoryUpliftModelRegressionCTCache] ([ctVersion], [ctSurrogateKey])

GO
