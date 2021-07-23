CREATE TABLE [dbo].[DashboardComponentUnit] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [dashboardComponentObjectId] [int] NOT NULL,
   [unitId] [int] NOT NULL,
   [parentId] [int] NULL

   ,CONSTRAINT [PK_DashboardComponentUnit] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardComponentUnit_dashboardObjectId] ON [dbo].[DashboardComponentUnit] ([dashboardComponentObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponentUnit_organizationalUnitObjectId] ON [dbo].[DashboardComponentUnit] ([parentId])
CREATE NONCLUSTERED INDEX [IX_DashboardComponentUnit_userAccountObjectId] ON [dbo].[DashboardComponentUnit] ([unitId])

GO
