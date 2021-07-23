ALTER TABLE [dbo].[DataFieldGroup] WITH CHECK ADD CONSTRAINT [FK_DataFieldGroup_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldGroup] WITH CHECK ADD CONSTRAINT [FK_DataFieldGroup_DataField2]
   FOREIGN KEY([memberDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
