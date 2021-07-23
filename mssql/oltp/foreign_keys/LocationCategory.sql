ALTER TABLE [dbo].[LocationCategory] WITH CHECK ADD CONSTRAINT [FK_LocationCategory_LocationCategoryType]
   FOREIGN KEY([LocationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategory] WITH CHECK ADD CONSTRAINT [FK_LocationCategory_Brand]
   FOREIGN KEY([brandObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategory] WITH CHECK ADD CONSTRAINT [FK_LocationCategory_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategory] WITH CHECK ADD CONSTRAINT [FK_LocationCategory_ParentLocationCategory]
   FOREIGN KEY([parentObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategory] WITH CHECK ADD CONSTRAINT [FK_LocationCategory_rootObjectId]
   FOREIGN KEY([rootObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
