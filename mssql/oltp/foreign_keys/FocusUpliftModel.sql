ALTER TABLE [dbo].[FocusUpliftModel] WITH CHECK ADD CONSTRAINT [FK_FocusUpliftModel_locationAttributeObjectId]
   FOREIGN KEY([locationAttributeObjectId]) REFERENCES [dbo].[LocationAttribute] ([objectId])

GO
ALTER TABLE [dbo].[FocusUpliftModel] WITH CHECK ADD CONSTRAINT [FK_FocusUpliftModel_upliftModelObjectId]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
