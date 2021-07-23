ALTER TABLE [dbo].[HeatmapComponentAxisDataFieldOptions] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentAxisDataFieldOptions_Option]
   FOREIGN KEY([dataFieldOptionId]) REFERENCES [dbo].[DataFieldOption] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[HeatmapComponentAxisDataFieldOptions] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentAxisDataFieldOptions_Axis]
   FOREIGN KEY([heatmapComponentAxisId]) REFERENCES [dbo].[HeatmapComponentAxis] ([objectId])
   ON DELETE CASCADE

GO
