ALTER TABLE [dbo].[DataFieldOption] WITH CHECK ADD CONSTRAINT [FK_DataFieldOption_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldOption] WITH CHECK ADD CONSTRAINT [FK_DataFieldOption_Label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
