ALTER TABLE [dbo].[UpliftModelPerformanceAttribute] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttribute_AuditField]
   FOREIGN KEY([auditFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelPerformanceAttribute] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttribute_DiagnosticField]
   FOREIGN KEY([diagnosticFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelPerformanceAttribute] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttribute_Field]
   FOREIGN KEY([fieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelPerformanceAttribute] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttribute_Goal]
   FOREIGN KEY([goalObjectId]) REFERENCES [dbo].[Goal] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelPerformanceAttribute] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttribute_UpliftModel]
   FOREIGN KEY([modelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelPerformanceAttribute] WITH CHECK ADD CONSTRAINT [FK_UpliftModelPerformanceAttribute_TagCategory]
   FOREIGN KEY([tagCategoryObjectId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
