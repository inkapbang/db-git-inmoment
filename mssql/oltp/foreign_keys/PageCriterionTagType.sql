ALTER TABLE [dbo].[PageCriterionTagType] WITH CHECK ADD CONSTRAINT [FK_PageCriterionTagType_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
