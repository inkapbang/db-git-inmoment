ALTER TABLE [dbo].[TagCategoryGlobalMapping] WITH CHECK ADD CONSTRAINT [FK_TagCategoryGlobalMapping_globalCat]
   FOREIGN KEY([globalTagCategoryObjectId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
ALTER TABLE [dbo].[TagCategoryGlobalMapping] WITH CHECK ADD CONSTRAINT [FK_TagCategoryGlobalMapping_orgCat]
   FOREIGN KEY([orgTagCategoryObjectId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
