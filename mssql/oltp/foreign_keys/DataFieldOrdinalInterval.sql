ALTER TABLE [dbo].[DataFieldOrdinalInterval] WITH CHECK ADD CONSTRAINT [FK_DataFieldOrdinalInterval_DataFieldOrdinalModel]
   FOREIGN KEY([dataFieldOrdinalModelObjectId]) REFERENCES [dbo].[DataFieldOrdinalModel] ([objectId])

GO
