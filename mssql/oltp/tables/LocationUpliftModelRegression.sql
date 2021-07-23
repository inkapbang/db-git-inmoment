CREATE TABLE [dbo].[LocationUpliftModelRegression] (
   [locationObjectId] [int] NOT NULL,
   [regressionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_LocationUpliftModelRegression] PRIMARY KEY CLUSTERED ([locationObjectId], [regressionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationUpliftModelRegression_Regression] ON [dbo].[LocationUpliftModelRegression] ([regressionObjectId])

GO
