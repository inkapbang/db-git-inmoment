CREATE TABLE [dbo].[HeatmapComponentAxis] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [type] [int] NOT NULL,
   [version] [int] NOT NULL,
   [dataFieldId] [int] NULL

   ,CONSTRAINT [PK_HeatmapComponentAxis] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HeatmapComponentAxis_dataFieldId] ON [dbo].[HeatmapComponentAxis] ([dataFieldId])

GO
