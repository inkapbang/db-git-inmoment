ALTER TABLE [dbo].[UpliftModelRegressionParam] WITH CHECK ADD CONSTRAINT [FK_UpliftModelRegressionParam_UpliftModelRegression]
   FOREIGN KEY([regressionObjectId]) REFERENCES [dbo].[UpliftModelRegression] ([objectId])

GO
