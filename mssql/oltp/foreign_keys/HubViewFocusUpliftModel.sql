ALTER TABLE [dbo].[HubViewFocusUpliftModel] WITH CHECK ADD CONSTRAINT [FK_HubViewFocusUpliftModel_FocusUpliftModel]
   FOREIGN KEY([focusUpliftModelObjectId]) REFERENCES [dbo].[FocusUpliftModel] ([objectId])

GO
ALTER TABLE [dbo].[HubViewFocusUpliftModel] WITH CHECK ADD CONSTRAINT [FK_HubViewFocusUpliftModel_HubView]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])

GO
