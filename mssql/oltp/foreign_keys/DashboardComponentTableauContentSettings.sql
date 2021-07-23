ALTER TABLE [dbo].[DashboardComponentTableauContentSettings] WITH CHECK ADD CONSTRAINT [FK_DashboardComponentTableauContentSettings_DashboardComponent]
   FOREIGN KEY([tableauViewComponentObjectId]) REFERENCES [dbo].[DashboardComponent] ([objectId])

GO
