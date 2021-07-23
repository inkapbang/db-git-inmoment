ALTER TABLE [dbo].[HierarchyTransform] WITH CHECK ADD CONSTRAINT [FK_HierarchyTransform_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
