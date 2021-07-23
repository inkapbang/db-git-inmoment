CREATE TABLE [dbo].[DashboardOptions] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [dashboardObjectId] [int] NOT NULL,
   [search] [bit] NULL,
   [filter] [bit] NULL,
   [date] [bit] NULL,
   [actions] [bit] NULL,
   [title] [bit] NULL,
   [componentDate] [bit] NULL,
   [published] [bit] NULL,
   [hierarchy] [bit] NULL,
   [componentHierarchy] [bit] NULL,
   [componentFilter] [bit] NULL

   ,CONSTRAINT [PK_DashboardOptions] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardOptions_dashboardObjectId] ON [dbo].[DashboardOptions] ([dashboardObjectId])

GO
