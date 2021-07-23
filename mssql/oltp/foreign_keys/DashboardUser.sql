ALTER TABLE [dbo].[DashboardUser] WITH CHECK ADD CONSTRAINT [FK_DashboardUser_Dashboard]
   FOREIGN KEY([dashboardObjectId]) REFERENCES [dbo].[Dashboard] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardUser] WITH CHECK ADD CONSTRAINT [FK_DashboardUser_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[DashboardUser] WITH CHECK ADD CONSTRAINT [FK_DashboardUser_Type]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[DashboardUser] WITH CHECK ADD CONSTRAINT [FK_DashboardUser_OrganizationalUnit]
   FOREIGN KEY([organizationalUnitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardUser] WITH CHECK ADD CONSTRAINT [FK_DashboardUser_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])
   ON DELETE CASCADE

GO
