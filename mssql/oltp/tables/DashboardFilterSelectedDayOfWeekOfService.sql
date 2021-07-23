CREATE TABLE [dbo].[DashboardFilterSelectedDayOfWeekOfService] (
   [dashboardFilterId] [int] NOT NULL,
   [dayOfWeek] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedDayOfWeekOfService] PRIMARY KEY CLUSTERED ([dashboardFilterId], [dayOfWeek])
)

CREATE NONCLUSTERED INDEX [IX_DFSDayOfWeekOfService_DashboardFilterId] ON [dbo].[DashboardFilterSelectedDayOfWeekOfService] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSDayOfWeekOfService_DayOfWeek] ON [dbo].[DashboardFilterSelectedDayOfWeekOfService] ([dayOfWeek])

GO
