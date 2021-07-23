ALTER TABLE [dbo].[Hierarchy] WITH CHECK ADD CONSTRAINT [FK_Hierarchy_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
