ALTER TABLE [dbo].[ChildFieldListFieldMapping] WITH CHECK ADD CONSTRAINT [FK_ChildFieldListFieldMapping_List]
   FOREIGN KEY([childFieldListObjectId]) REFERENCES [dbo].[ChildFieldList] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[ChildFieldListFieldMapping] WITH CHECK ADD CONSTRAINT [FK_ChildFieldListFieldMapping_Field]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])
   ON DELETE CASCADE

GO
