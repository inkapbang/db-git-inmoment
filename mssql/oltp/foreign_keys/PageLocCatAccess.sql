ALTER TABLE [dbo].[PageLocCatAccess] WITH CHECK ADD CONSTRAINT [FK_PageLocCatAccess_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[PageLocCatAccess] WITH CHECK ADD CONSTRAINT [FK_PageLocCatAccess_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
