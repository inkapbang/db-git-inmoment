ALTER TABLE [dbo].[UpliftModelStrategy] WITH CHECK ADD CONSTRAINT [FK_UpliftModelStrategy_Period]
   FOREIGN KEY([VocRangePeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelStrategy] WITH CHECK ADD CONSTRAINT [FK_UpliftModelStrategy_AuditParticipantAttribute]
   FOREIGN KEY([auditParticipantAttributeObjectId]) REFERENCES [dbo].[LocationAttribute] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelStrategy] WITH CHECK ADD CONSTRAINT [FK_UpliftModelStrategy_AuditResponseSource]
   FOREIGN KEY([auditResponseSourceObjectId]) REFERENCES [dbo].[ResponseSource] ([objectId])

GO
