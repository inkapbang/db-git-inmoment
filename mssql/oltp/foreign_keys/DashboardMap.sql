ALTER TABLE [dbo].[DashboardMap] WITH CHECK ADD CONSTRAINT [FK_DashboardMap_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[DashboardMap] WITH CHECK ADD CONSTRAINT [FK_DashboardMap_Label_LocalizedString]
   FOREIGN KEY([labelId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
