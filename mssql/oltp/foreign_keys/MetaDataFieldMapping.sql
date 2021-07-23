ALTER TABLE [dbo].[MetaDataFieldMapping] WITH CHECK ADD CONSTRAINT [FK_MetaDataFieldMapping_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[MetaDataFieldMapping] WITH CHECK ADD CONSTRAINT [FK_MetaDataFieldMapping_ChannelMetaData]
   FOREIGN KEY([metaDataObjectId]) REFERENCES [dbo].[ChannelMetaData] ([objectId])

GO
