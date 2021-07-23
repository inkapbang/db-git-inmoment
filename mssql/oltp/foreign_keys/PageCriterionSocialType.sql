ALTER TABLE [dbo].[PageCriterionSocialType] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSocialType_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
