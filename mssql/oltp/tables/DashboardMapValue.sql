CREATE TABLE [dbo].[DashboardMapValue] (
   [dashboardMapObjectId] [int] NOT NULL,
   [levelObjectId] [int] NOT NULL,
   [dashboardObjectId] [int] NULL

   ,CONSTRAINT [PK_DashboardMapValue] PRIMARY KEY CLUSTERED ([dashboardMapObjectId], [levelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardMapValue_Dashboard] ON [dbo].[DashboardMapValue] ([dashboardObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardMapValue_dashboardMapObjectId] ON [dbo].[DashboardMapValue] ([dashboardMapObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardMapValue_LocationCategoryType] ON [dbo].[DashboardMapValue] ([levelObjectId])

GO
