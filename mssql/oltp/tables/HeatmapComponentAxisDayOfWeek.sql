CREATE TABLE [dbo].[HeatmapComponentAxisDayOfWeek] (
   [heatmapComponentAxisId] [int] NOT NULL,
   [dayOfWeek] [int] NOT NULL

   ,CONSTRAINT [PK_HeatmapComponentAxisDayOfWeek] PRIMARY KEY CLUSTERED ([heatmapComponentAxisId], [dayOfWeek])
)


GO
