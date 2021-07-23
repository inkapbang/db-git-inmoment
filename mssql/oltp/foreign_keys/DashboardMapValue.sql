ALTER TABLE [dbo].[DashboardMapValue] WITH CHECK ADD CONSTRAINT [FK_DashboardMapValue_DashboardMap]
   FOREIGN KEY([dashboardMapObjectId]) REFERENCES [dbo].[DashboardMap] ([objectId])

GO
ALTER TABLE [dbo].[DashboardMapValue] WITH CHECK ADD CONSTRAINT [FK_DashboardMapValue_Dashboard]
   FOREIGN KEY([dashboardObjectId]) REFERENCES [dbo].[Dashboard] ([objectId])

GO
ALTER TABLE [dbo].[DashboardMapValue] WITH CHECK ADD CONSTRAINT [FK_DashboardMapValue_LocationCategoryType]
   FOREIGN KEY([levelObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
