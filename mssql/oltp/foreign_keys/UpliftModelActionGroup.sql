ALTER TABLE [dbo].[UpliftModelActionGroup] WITH CHECK ADD CONSTRAINT [FK_UpliftModelActionGroup_ActionGroup]
   FOREIGN KEY([actionGroupObjectId]) REFERENCES [dbo].[ActionGroup] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModelActionGroup] WITH CHECK ADD CONSTRAINT [FK_UpliftModelActionGroup_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
