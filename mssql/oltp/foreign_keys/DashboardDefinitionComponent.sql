ALTER TABLE [dbo].[DashboardDefinitionComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardDefinitionComponent_DashboardDefintion]
   FOREIGN KEY([dashboardDefinitionId]) REFERENCES [dbo].[DashboardDefinition] ([objectId])

GO
ALTER TABLE [dbo].[DashboardDefinitionComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardDefinitionComponent_LocalizedString_title]
   FOREIGN KEY([titleObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
