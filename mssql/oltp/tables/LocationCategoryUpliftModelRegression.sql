CREATE TABLE [dbo].[LocationCategoryUpliftModelRegression] (
   [locationCategoryObjectId] [int] NOT NULL,
   [regressionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_LocationCategoryUpliftModelRegression] PRIMARY KEY CLUSTERED ([locationCategoryObjectId], [regressionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationCategoryUpliftModelRegression_regressionObjectId] ON [dbo].[LocationCategoryUpliftModelRegression] ([regressionObjectId])

GO
