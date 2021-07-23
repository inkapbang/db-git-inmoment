ALTER TABLE [dbo].[DashboardFilterSelectedSources] WITH CHECK ADD CONSTRAINT [FK_DFSSources_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedSources] WITH CHECK ADD CONSTRAINT [FK_DFSSources_ResponseSource]
   FOREIGN KEY([responseSourceId]) REFERENCES [dbo].[ResponseSource] ([objectId])
   ON DELETE CASCADE

GO
