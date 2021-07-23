CREATE TABLE [dbo].[AppRouteMapEntry] (
   [mapObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL,
   [appRoute] [tinyint] NOT NULL

   ,CONSTRAINT [PK_AppRouteMapEntry] PRIMARY KEY CLUSTERED ([mapObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_AppRouteMapEntrey_by_mapObjectId_locationCategoryTypeObjectId] ON [dbo].[AppRouteMapEntry] ([mapObjectId], [locationCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_AppRouteMapEntry_by_locationCategoryTypeObjectId] ON [dbo].[AppRouteMapEntry] ([locationCategoryTypeObjectId])

GO
