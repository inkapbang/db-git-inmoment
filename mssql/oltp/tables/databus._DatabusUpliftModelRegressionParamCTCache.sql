CREATE TABLE [databus].[_DatabusUpliftModelRegressionParamCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [regressionObjectId] [int] NOT NULL,
   [paramType] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [ordinalLevel] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUpliftModelRegressionParamCTCache_regressionObjectId_paramType_dataFieldObjectId_ordinalLevel] PRIMARY KEY CLUSTERED ([regressionObjectId], [paramType], [dataFieldObjectId], [ordinalLevel])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUpliftModelRegressionParamCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUpliftModelRegressionParamCTCache] ([ctVersion], [ctSurrogateKey])

GO
