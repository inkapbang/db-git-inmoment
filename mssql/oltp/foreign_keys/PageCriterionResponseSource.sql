ALTER TABLE [dbo].[PageCriterionResponseSource] WITH CHECK ADD CONSTRAINT [FK_PageCriterionResponseSource_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionResponseSource] WITH CHECK ADD CONSTRAINT [FK_PageCriterionResponseSource_ResponseSource]
   FOREIGN KEY([responseSourceObjectId]) REFERENCES [dbo].[ResponseSource] ([objectId])

GO
