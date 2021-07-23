ALTER TABLE [dbo].[HubViewTagMap] WITH CHECK ADD CONSTRAINT [FK_HubViewTagMap_dashboardObjectId]
   FOREIGN KEY([dashboardObjectId]) REFERENCES [dbo].[Dashboard] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HubViewTagMap] WITH CHECK ADD CONSTRAINT [FK_HubViewTagMap_organizationObjectId]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[HubViewTagMap] WITH CHECK ADD CONSTRAINT [FK_HubViewTagMap_viewObjectId]
   FOREIGN KEY([viewObjectId]) REFERENCES [dbo].[HubView] ([objectId])
   ON DELETE CASCADE

GO
