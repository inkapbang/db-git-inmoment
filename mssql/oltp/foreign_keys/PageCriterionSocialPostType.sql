ALTER TABLE [dbo].[PageCriterionSocialPostType] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSocialPostType_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
