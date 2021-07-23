ALTER TABLE [dbo].[PageScheduleCriterion] WITH CHECK ADD CONSTRAINT [FK_PageScheduleCriterion_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageScheduleCriterion] WITH CHECK ADD CONSTRAINT [FK_PageScheduleCriterion_Page]
   FOREIGN KEY([pageScheduleObjectId]) REFERENCES [dbo].[PageSchedule] ([objectId])

GO
