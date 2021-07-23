ALTER TABLE [dbo].[PublicReviewURL] WITH CHECK ADD CONSTRAINT [FK_PublicReviewURL_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewURL] WITH CHECK ADD CONSTRAINT [FK_PublicReviewURL_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
