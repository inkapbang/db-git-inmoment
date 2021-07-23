CREATE TABLE [dbo].[AppRouteMap] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [hierarchyObjectId] [int] NOT NULL,
   [locationAppRoute] [tinyint] NOT NULL,
   [sequence] [tinyint] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_AppRouteMap] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AppRouteMap_by_hierarchyObjectId] ON [dbo].[AppRouteMap] ([hierarchyObjectId])

GO
