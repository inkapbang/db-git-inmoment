ALTER TABLE [dbo].[PageScheduleOptOut] WITH CHECK ADD CONSTRAINT [FK_PageScheduleOptOut_PageSchedule]
   FOREIGN KEY([pageScheduleObjectId]) REFERENCES [dbo].[PageSchedule] ([objectId])

GO
ALTER TABLE [dbo].[PageScheduleOptOut] WITH CHECK ADD CONSTRAINT [FK_PageScheduleOptOut_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
