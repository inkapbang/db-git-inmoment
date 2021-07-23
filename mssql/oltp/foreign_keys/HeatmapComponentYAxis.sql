ALTER TABLE [dbo].[HeatmapComponentYAxis] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentYAxis_Component]
   FOREIGN KEY([componentId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HeatmapComponentYAxis] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentYAxis_Axis]
   FOREIGN KEY([heatmapComponentAxisId]) REFERENCES [dbo].[HeatmapComponentAxis] ([objectId])
   ON DELETE CASCADE

GO
