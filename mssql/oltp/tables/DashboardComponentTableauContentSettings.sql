CREATE TABLE [dbo].[DashboardComponentTableauContentSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [tableauViewComponentObjectId] [int] NOT NULL,
   [authType] [smallint] NOT NULL,
   [userName] [varchar](150) NULL,
   [siteName] [varchar](150) NULL,
   [workbookName] [varchar](150) NOT NULL,
   [viewName] [varchar](150) NOT NULL,
   [showTabs] [bit] NOT NULL,
   [showToolbar] [bit] NOT NULL,
   [version] [int] NOT NULL,
   [allowExternalFilters] [bit] NULL,
   [externalFiltersWorkbookName] [varchar](150) NULL

   ,CONSTRAINT [PK__Dashboar__5243E26A156CC6B4] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardComponentTableauContentSettings_DashboardComponent] ON [dbo].[DashboardComponentTableauContentSettings] ([tableauViewComponentObjectId])

GO
