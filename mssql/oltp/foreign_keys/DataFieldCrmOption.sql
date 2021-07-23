ALTER TABLE [dbo].[DataFieldCrmOption] WITH CHECK ADD CONSTRAINT [FK_DataFieldCrmOption_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldCrmOption] WITH CHECK ADD CONSTRAINT [FK_DataFieldCrmOption_Label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
