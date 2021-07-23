ALTER TABLE [dbo].[DashboardFilterSelectedEnum] WITH CHECK ADD CONSTRAINT [FK_DFSEnum_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
