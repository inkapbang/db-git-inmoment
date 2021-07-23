ALTER TABLE [dbo].[MetaDataField] WITH CHECK ADD CONSTRAINT [FK_MetaDataField_DataFieldObjectId]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[MetaDataField] WITH CHECK ADD CONSTRAINT [FK_MetaDataField_UpliftModelObjectId]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
