CREATE TABLE [dbo].[DashboardFilterSelectedEnum] (
   [dashboardFilterId] [int] NOT NULL,
   [enumVal] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedEnum] PRIMARY KEY CLUSTERED ([dashboardFilterId], [enumVal])
)

CREATE NONCLUSTERED INDEX [IX_DFSEnum_DashboardFilterId] ON [dbo].[DashboardFilterSelectedEnum] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSEnum_EnumVal] ON [dbo].[DashboardFilterSelectedEnum] ([enumVal])

GO
