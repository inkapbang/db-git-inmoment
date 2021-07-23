ALTER TABLE [dbo].[DashboardOptions] WITH CHECK ADD CONSTRAINT [FK_DashboardOptions_Dashboard]
   FOREIGN KEY([dashboardObjectId]) REFERENCES [dbo].[Dashboard] ([objectId])
   ON DELETE CASCADE

GO
