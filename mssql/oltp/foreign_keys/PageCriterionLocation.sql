ALTER TABLE [dbo].[PageCriterionLocation] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLocation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionLocation] WITH CHECK ADD CONSTRAINT [FK_PageCriterionLocation_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
