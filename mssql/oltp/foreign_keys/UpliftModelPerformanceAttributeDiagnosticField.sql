ALTER TABLE [dbo].[UpliftModelPerformanceAttributeDiagnosticField] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttributeDiagnosticField_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelPerformanceAttributeDiagnosticField] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttributeDiagnosticField_PerformanceAttribute]
   FOREIGN KEY([performanceAttributeObjectId]) REFERENCES [dbo].[UpliftModelPerformanceAttribute] ([objectId])

GO
