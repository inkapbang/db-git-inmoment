CREATE TABLE [dbo].[DashboardFilterSelectedDataFieldOptions] (
   [dashboardFilterId] [int] NOT NULL,
   [dataFieldOptionId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedDataFieldOptions] PRIMARY KEY CLUSTERED ([dashboardFilterId], [dataFieldOptionId])
)

CREATE NONCLUSTERED INDEX [IX_DFSDataFieldOptions_DashboardFilterId] ON [dbo].[DashboardFilterSelectedDataFieldOptions] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSDataFieldOptions_DataFieldOptionId] ON [dbo].[DashboardFilterSelectedDataFieldOptions] ([dataFieldOptionId])

GO
