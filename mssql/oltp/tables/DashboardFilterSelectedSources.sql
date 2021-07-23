CREATE TABLE [dbo].[DashboardFilterSelectedSources] (
   [dashboardFilterId] [int] NOT NULL,
   [responseSourceId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedSources] PRIMARY KEY CLUSTERED ([dashboardFilterId], [responseSourceId])
)

CREATE NONCLUSTERED INDEX [IX_DFSSources_DashboardFilterId] ON [dbo].[DashboardFilterSelectedSources] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSSources_ResponseSourceId] ON [dbo].[DashboardFilterSelectedSources] ([responseSourceId])

GO
