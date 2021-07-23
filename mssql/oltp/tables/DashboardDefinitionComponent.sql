CREATE TABLE [dbo].[DashboardDefinitionComponent] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [xPosition] [int] NOT NULL,
   [yPosition] [int] NOT NULL,
   [componentId] [int] NOT NULL,
   [dashboardDefinitionId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [titleObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardDefinitionComponent] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardDefinitionComponent_dashboardDefinitionId_titleObjectId] ON [dbo].[DashboardDefinitionComponent] ([dashboardDefinitionId], [titleObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardDefinitionComponent_titleObjectId] ON [dbo].[DashboardDefinitionComponent] ([titleObjectId])

GO
