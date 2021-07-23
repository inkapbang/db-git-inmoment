ALTER TABLE [dbo].[HeatmapComponentAxis] WITH CHECK ADD CONSTRAINT [FK_HeatmapComponentAxis_DataField]
   FOREIGN KEY([dataFieldId]) REFERENCES [dbo].[DataField] ([objectId])
   ON DELETE CASCADE

GO
