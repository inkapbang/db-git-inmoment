ALTER TABLE [dbo].[TileGroup] WITH CHECK ADD CONSTRAINT [FK_TileGroup_LocalizedString]
   FOREIGN KEY([nameId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[TileGroup] WITH CHECK ADD CONSTRAINT [FK_TileGroup_PeerComparisonModel]
   FOREIGN KEY([peerComparisonModelId]) REFERENCES [dbo].[PeerComparisonModel] ([objectId])

GO
