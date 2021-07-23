CREATE TABLE [dbo].[HeatmapComponentXAxis] (
   [componentId] [int] NOT NULL,
   [heatmapComponentAxisId] [int] NOT NULL

   ,CONSTRAINT [PK_HeatmapComponentXAxis] PRIMARY KEY CLUSTERED ([componentId], [heatmapComponentAxisId])
)


GO
