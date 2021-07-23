ALTER TABLE [dbo].[PageCriterionCommentCriterionEnum] WITH CHECK ADD CONSTRAINT [FK_PageCriterionCommentCriterionEnum_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
