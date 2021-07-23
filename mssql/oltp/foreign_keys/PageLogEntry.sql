ALTER TABLE [dbo].[PageLogEntry] WITH CHECK ADD CONSTRAINT [FK_ReportLogEntry_ReportRunLogEntry]
   FOREIGN KEY([deliveryRunLogEntryId]) REFERENCES [dbo].[DeliveryRunLogEntry] ([objectId])

GO
ALTER TABLE [dbo].[PageLogEntry] WITH CHECK ADD CONSTRAINT [FK_PageLogEntry_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[PageLogEntry] WITH CHECK ADD CONSTRAINT [FK_PageLogEntry_PageSchedule]
   FOREIGN KEY([pageScheduleObjectId]) REFERENCES [dbo].[PageSchedule] ([objectId])

GO
