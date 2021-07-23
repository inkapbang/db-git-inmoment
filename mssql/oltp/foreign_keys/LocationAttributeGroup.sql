ALTER TABLE [dbo].[LocationAttributeGroup] WITH CHECK ADD CONSTRAINT [FK_LocationAttributeGroup_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
