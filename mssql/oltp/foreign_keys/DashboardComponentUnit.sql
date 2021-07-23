ALTER TABLE [dbo].[DashboardComponentUnit] WITH CHECK ADD CONSTRAINT [FK_DashboardComponentUnit_DashboardComponent]
   FOREIGN KEY([dashboardComponentObjectId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardComponentUnit] WITH CHECK ADD CONSTRAINT [FK_DashboardComponentUnit_OrganizationalUnit_Parent]
   FOREIGN KEY([parentId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponentUnit] WITH CHECK ADD CONSTRAINT [FK_DashboardComponentUnit_OrganizationalUnit]
   FOREIGN KEY([unitId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])
   ON DELETE CASCADE

GO
