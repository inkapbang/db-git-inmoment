ALTER TABLE [dbo].[DashboardFilterSelectedDayOfWeekOfService] WITH CHECK ADD CONSTRAINT [FK_DFSDayOfWeekOfService_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
