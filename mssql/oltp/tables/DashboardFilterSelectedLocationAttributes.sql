CREATE TABLE [dbo].[DashboardFilterSelectedLocationAttributes] (
   [dashboardFilterId] [int] NOT NULL,
   [locationAttributeId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedLocationAttributes] PRIMARY KEY CLUSTERED ([dashboardFilterId], [locationAttributeId])
)

CREATE NONCLUSTERED INDEX [IX_DFSLocationAttributes_DashboardFilterId] ON [dbo].[DashboardFilterSelectedLocationAttributes] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSLocationAttributes_LocationAttributeId] ON [dbo].[DashboardFilterSelectedLocationAttributes] ([locationAttributeId])

GO
