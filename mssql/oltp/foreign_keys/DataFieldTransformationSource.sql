ALTER TABLE [dbo].[DataFieldTransformationSource] WITH CHECK ADD CONSTRAINT [FK_DataFieldTransformationSource_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldTransformationSource] WITH CHECK ADD CONSTRAINT [FK_DataFieldTransformationSource_DataField2]
   FOREIGN KEY([sourceDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
