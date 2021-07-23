ALTER TABLE [dbo].[ResponseCriterionSource] WITH CHECK ADD CONSTRAINT [FK_ResponseCriterionSource_responseCriterionObjectId]
   FOREIGN KEY([responseCriterionObjectId]) REFERENCES [dbo].[ResponseCriterion] ([objectId])

GO
ALTER TABLE [dbo].[ResponseCriterionSource] WITH CHECK ADD CONSTRAINT [FK_ResponseCriterionSource_responseSourceObjectId]
   FOREIGN KEY([responseSourceObjectId]) REFERENCES [dbo].[ResponseSource] ([objectId])

GO
