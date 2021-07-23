ALTER TABLE [dbo].[DashboardDefinition] WITH CHECK ADD CONSTRAINT [FK_DashboardDefinition_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
