ALTER TABLE [dbo].[UpliftModelPerformanceAttributeTag] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttributeTag_UpliftModelPerformanceAttribute]
   FOREIGN KEY([performanceAttributeObjectId]) REFERENCES [dbo].[UpliftModelPerformanceAttribute] ([objectId])

GO
