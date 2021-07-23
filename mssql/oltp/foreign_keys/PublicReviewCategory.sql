ALTER TABLE [dbo].[PublicReviewCategory] WITH CHECK ADD CONSTRAINT [FK_PublicReviewCategory_ParentCategory]
   FOREIGN KEY([parentObjectId]) REFERENCES [dbo].[PublicReviewCategory] ([objectId])

GO
