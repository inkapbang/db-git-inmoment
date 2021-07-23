ALTER TABLE [dbo].[PageScheduleSubscription] WITH CHECK ADD CONSTRAINT [FK_PageScheduleSubscription_LocationCategoryType]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[PageScheduleSubscription] WITH CHECK ADD CONSTRAINT [FK_PageScheduleSubscription_PageSchedule]
   FOREIGN KEY([pageScheduleObjectId]) REFERENCES [dbo].[PageSchedule] ([objectId])

GO
