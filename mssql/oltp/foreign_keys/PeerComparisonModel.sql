ALTER TABLE [dbo].[PeerComparisonModel] WITH CHECK ADD CONSTRAINT [FK_PeerComparisonModel_LocationCategoryType_compareType]
   FOREIGN KEY([compareTypeId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[PeerComparisonModel] WITH CHECK ADD CONSTRAINT [FK_PeerComparisonModel_LocationCategoryType_peerType]
   FOREIGN KEY([peerTypeId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[PeerComparisonModel] WITH CHECK ADD CONSTRAINT [FK_PeerComparisonModel_UpliftModel]
   FOREIGN KEY([upliftModelId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
