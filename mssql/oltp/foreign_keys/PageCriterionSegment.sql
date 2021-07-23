ALTER TABLE [dbo].[PageCriterionSegment] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSegment_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionSegment] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSegment_Segment]
   FOREIGN KEY([segmentObjectId]) REFERENCES [dbo].[Segment] ([objectId])

GO
