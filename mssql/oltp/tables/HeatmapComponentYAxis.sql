CREATE TABLE [dbo].[HeatmapComponentYAxis] (
   [componentId] [int] NOT NULL,
   [heatmapComponentAxisId] [int] NOT NULL

   ,CONSTRAINT [PK_HeatmapComponentYAxis] PRIMARY KEY CLUSTERED ([componentId], [heatmapComponentAxisId])
)


GO
