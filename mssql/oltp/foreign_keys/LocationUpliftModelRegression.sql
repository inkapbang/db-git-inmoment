ALTER TABLE [dbo].[LocationUpliftModelRegression] WITH CHECK ADD CONSTRAINT [FK_LocationUpliftModelRegression_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[LocationUpliftModelRegression] WITH CHECK ADD CONSTRAINT [FK_LocationUpliftModelRegression_Regression]
   FOREIGN KEY([regressionObjectId]) REFERENCES [dbo].[UpliftModelRegression] ([objectId])

GO
