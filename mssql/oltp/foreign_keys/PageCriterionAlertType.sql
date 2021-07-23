ALTER TABLE [dbo].[PageCriterionAlertType] WITH CHECK ADD CONSTRAINT [FK_PageCriterionAlertType_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
