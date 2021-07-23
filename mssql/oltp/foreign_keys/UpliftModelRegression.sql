ALTER TABLE [dbo].[UpliftModelRegression] WITH CHECK ADD CONSTRAINT [FK_UpliftModelRegression_UpliftModel]
   FOREIGN KEY([modelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelRegression] WITH CHECK ADD CONSTRAINT [FK_UpliftModelRegression_DataFieldOrdinalModel]
   FOREIGN KEY([ordinalModelObjectId]) REFERENCES [dbo].[DataFieldOrdinalModel] ([objectId])

GO
