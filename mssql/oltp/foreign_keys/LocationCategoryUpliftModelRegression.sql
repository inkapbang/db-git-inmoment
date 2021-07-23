ALTER TABLE [dbo].[LocationCategoryUpliftModelRegression] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryUpliftModelRegression_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategoryUpliftModelRegression] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryUpliftModelRegression_Regression]
   FOREIGN KEY([regressionObjectId]) REFERENCES [dbo].[UpliftModelRegression] ([objectId])

GO
