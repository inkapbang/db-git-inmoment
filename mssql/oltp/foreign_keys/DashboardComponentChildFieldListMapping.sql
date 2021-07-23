ALTER TABLE [dbo].[DashboardComponentChildFieldListMapping] WITH CHECK ADD CONSTRAINT [FK_ComponentChildFieldListFieldMapping_List]
   FOREIGN KEY([childFieldListObjectId]) REFERENCES [dbo].[ChildFieldList] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardComponentChildFieldListMapping] WITH CHECK ADD CONSTRAINT [FK_ComponentChildFieldListFieldMapping_Component]
   FOREIGN KEY([dashboardComponentObjectId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardComponentChildFieldListMapping] WITH CHECK ADD CONSTRAINT [FK_ComponentChildFieldListFieldMapping_Field]
   FOREIGN KEY([parentFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])
   ON DELETE CASCADE

GO
