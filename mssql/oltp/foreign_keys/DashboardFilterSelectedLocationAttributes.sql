ALTER TABLE [dbo].[DashboardFilterSelectedLocationAttributes] WITH CHECK ADD CONSTRAINT [FK_DFSLocationAttributes_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedLocationAttributes] WITH CHECK ADD CONSTRAINT [FK_DFSLocationAttributes_LocationAttribute]
   FOREIGN KEY([locationAttributeId]) REFERENCES [dbo].[LocationAttribute] ([objectId])
   ON DELETE CASCADE

GO
