ALTER TABLE [dbo].[PearModelCategoryTagMapping] WITH CHECK ADD CONSTRAINT [FK_PearModelCategoryTagMapping_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[PearModelCategoryTagMapping] WITH CHECK ADD CONSTRAINT [FK_PearModelCategoryTagMapping_TagCategory]
   FOREIGN KEY([tagCategoryObjectId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
ALTER TABLE [dbo].[PearModelCategoryTagMapping] WITH CHECK ADD CONSTRAINT [FK_PearModelCategoryTagMapping_TagList]
   FOREIGN KEY([tagListHolderObjectId]) REFERENCES [dbo].[TagListHolder] ([objectId])

GO
