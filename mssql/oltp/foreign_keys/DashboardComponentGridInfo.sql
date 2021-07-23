ALTER TABLE [dbo].[DashboardComponentGridInfo] WITH CHECK ADD CONSTRAINT [FK_DashboardComponentGridInfo_Component]
   FOREIGN KEY([dashboardComponentObjectId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
