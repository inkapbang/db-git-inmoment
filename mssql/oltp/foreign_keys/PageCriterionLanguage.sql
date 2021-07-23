ALTER TABLE [dbo].[PageCriterionLanguage] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLanguage_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
