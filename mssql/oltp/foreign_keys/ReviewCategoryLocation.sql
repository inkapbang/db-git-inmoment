ALTER TABLE [dbo].[ReviewCategoryLocation] WITH CHECK ADD CONSTRAINT [RK_ReviewCategoryLocation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[ReviewCategoryLocation] WITH CHECK ADD CONSTRAINT [FK_ReviewCategoryLocation_PublicReviewCategory]
   FOREIGN KEY([reviewCategoryObjectId]) REFERENCES [dbo].[PublicReviewCategory] ([objectId])
   ON DELETE CASCADE

GO
