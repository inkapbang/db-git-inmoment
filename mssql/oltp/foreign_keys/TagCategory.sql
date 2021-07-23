ALTER TABLE [dbo].[TagCategory] WITH CHECK ADD CONSTRAINT [FK_TagCategory_Label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[TagCategory] WITH CHECK ADD CONSTRAINT [FK_TagCategory_Name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[TagCategory] WITH CHECK ADD CONSTRAINT [FK_TagCategory_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
