CREATE TABLE [dbo].[DashboardUser] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [dashboardObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NULL,
   [organizationalUnitObjectId] [int] NULL,
   [permission] [int] NULL,
   [dateAdded] [datetime] NULL,
   [locationCategoryTypeObjectId] [int] NULL,
   [hierarchyObjectId] [int] NULL

   ,CONSTRAINT [PK_DashboardUser] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardUser_dashboardObjectId] ON [dbo].[DashboardUser] ([dashboardObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardUser_dashboardObjectId2] ON [dbo].[DashboardUser] ([dashboardObjectId]) INCLUDE ([objectId], [version], [userAccountObjectId], [organizationalUnitObjectId], [permission], [dateAdded], [locationCategoryTypeObjectId], [hierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardUser_Hierarchy] ON [dbo].[DashboardUser] ([hierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardUser_organizationalUnitObjectId] ON [dbo].[DashboardUser] ([organizationalUnitObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardUser_Type] ON [dbo].[DashboardUser] ([locationCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_DashboardUser_userAccountObjectId] ON [dbo].[DashboardUser] ([userAccountObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UX_DashboardUser_db_user_ou_lct_h] ON [dbo].[DashboardUser] ([dashboardObjectId], [userAccountObjectId], [organizationalUnitObjectId], [locationCategoryTypeObjectId], [hierarchyObjectId])

GO
