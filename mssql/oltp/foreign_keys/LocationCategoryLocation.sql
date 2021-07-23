ALTER TABLE [dbo].[LocationCategoryLocation] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryLocation_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[LocationCategoryLocation] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryLocation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
