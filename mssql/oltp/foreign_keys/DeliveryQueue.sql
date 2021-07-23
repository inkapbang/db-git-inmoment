ALTER TABLE [dbo].[DeliveryQueue] WITH CHECK ADD CONSTRAINT [FK_DeliveryQueue_DeliveryFile]
   FOREIGN KEY([fileObjectId]) REFERENCES [dbo].[DeliveryFile] ([objectId])

GO
ALTER TABLE [dbo].[DeliveryQueue] WITH CHECK ADD CONSTRAINT [FK_DeliveryQueue_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[DeliveryQueue] WITH CHECK ADD CONSTRAINT [FK_DeliveryQueue_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[DeliveryQueue] WITH CHECK ADD CONSTRAINT [FK__DeliveryQ__pageS__3A9D1C78]
   FOREIGN KEY([pageScheduleObjectId]) REFERENCES [dbo].[PageSchedule] ([objectId])

GO
