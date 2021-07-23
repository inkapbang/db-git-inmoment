ALTER TABLE [dbo].[DashboardFilterSelectedBooleans] WITH CHECK ADD CONSTRAINT [FK_DFSBooleanValue_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
