CREATE TABLE [dbo].[DashboardFilterSelectedBooleans] (
   [dashboardFilterId] [int] NOT NULL,
   [booleanValue] [bit] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedBooleans] PRIMARY KEY CLUSTERED ([dashboardFilterId], [booleanValue])
)

CREATE NONCLUSTERED INDEX [IX_DFSBooleanValue_DashboardFilterId] ON [dbo].[DashboardFilterSelectedBooleans] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSBooleanValue_DayOfWeek] ON [dbo].[DashboardFilterSelectedBooleans] ([booleanValue])

GO
