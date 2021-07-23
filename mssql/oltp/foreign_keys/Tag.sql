ALTER TABLE [dbo].[Tag] WITH CHECK ADD CONSTRAINT [FK_Tag_name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Tag] WITH CHECK ADD CONSTRAINT [FK_Tag_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[Tag] WITH CHECK ADD CONSTRAINT [FK_Tag_TagCategory]
   FOREIGN KEY([tagCategoryObjectId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
