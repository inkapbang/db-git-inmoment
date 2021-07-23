ALTER TABLE [dbo].[PageCriterionTagTranscriptionConfidenceLevel] WITH CHECK ADD CONSTRAINT [FK_PageCriterionTagTranscriptionConfidenceLevel_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
