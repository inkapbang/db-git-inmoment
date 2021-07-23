ALTER TABLE [dbo].[HeatmapComponentAxisDayOfWeek] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentAxisDayOfWeek_Axis]
   FOREIGN KEY([heatmapComponentAxisId]) REFERENCES [dbo].[HeatmapComponentAxis] ([objectId])
   ON DELETE CASCADE

GO
