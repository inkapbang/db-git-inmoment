ALTER TABLE [dbo].[DataFieldOrdinalModel] WITH CHECK ADD CONSTRAINT [FK_DataFieldOrdinalModel_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
