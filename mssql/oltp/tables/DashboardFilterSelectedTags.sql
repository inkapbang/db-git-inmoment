CREATE TABLE [dbo].[DashboardFilterSelectedTags] (
   [dashboardFilterId] [int] NOT NULL,
   [tagId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedTags] PRIMARY KEY CLUSTERED ([dashboardFilterId], [tagId])
)

CREATE NONCLUSTERED INDEX [IX_DFSTags_DashboardFilterId] ON [dbo].[DashboardFilterSelectedTags] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSTags_LocationAttributeId] ON [dbo].[DashboardFilterSelectedTags] ([tagId])

GO
