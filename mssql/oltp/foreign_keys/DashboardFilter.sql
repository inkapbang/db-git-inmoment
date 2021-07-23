ALTER TABLE [dbo].[DashboardFilter] WITH CHECK ADD CONSTRAINT [FK_DashboardFilter_Component]
   FOREIGN KEY([componentId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilter] WITH CHECK ADD CONSTRAINT [FK_DashboardFilter_Dashboard]
   FOREIGN KEY([dashboardId]) REFERENCES [dbo].[Dashboard] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilter] WITH CHECK ADD CONSTRAINT [FK_DashboardFilter_Label]
   FOREIGN KEY([labelId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[DashboardFilter] WITH CHECK ADD CONSTRAINT [FK_DashboardFilter_LocationAttributeGroup]
   FOREIGN KEY([locationAttributeGroupId]) REFERENCES [dbo].[LocationAttributeGroup] ([objectId])

GO
ALTER TABLE [dbo].[DashboardFilter] WITH CHECK ADD CONSTRAINT [FK_DashboardFilter_TagCategory]
   FOREIGN KEY([tagCategoryId]) REFERENCES [dbo].[TagCategory] ([objectId])

GO
