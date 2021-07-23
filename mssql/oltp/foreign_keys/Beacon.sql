ALTER TABLE [dbo].[Beacon] WITH CHECK ADD CONSTRAINT [FK_Beacon_EnterBeaconAction]
   FOREIGN KEY([enterBeaconActionObjectId]) REFERENCES [dbo].[BeaconAction] ([objectId])

GO
ALTER TABLE [dbo].[Beacon] WITH CHECK ADD CONSTRAINT [FK_Beacon_ExitBeaconAction]
   FOREIGN KEY([exitBeaconActionObjectId]) REFERENCES [dbo].[BeaconAction] ([objectId])

GO
ALTER TABLE [dbo].[Beacon] WITH CHECK ADD CONSTRAINT [FK_Beacon_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[Beacon] WITH CHECK ADD CONSTRAINT [FK_Beacon_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
