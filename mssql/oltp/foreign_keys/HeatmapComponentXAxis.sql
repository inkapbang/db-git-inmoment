ALTER TABLE [dbo].[HeatmapComponentXAxis] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentXAxis_Component]
   FOREIGN KEY([componentId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HeatmapComponentXAxis] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentXAxis_Axis]
   FOREIGN KEY([heatmapComponentAxisId]) REFERENCES [dbo].[HeatmapComponentAxis] ([objectId])
   ON DELETE CASCADE

GO
