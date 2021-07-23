ALTER TABLE [dbo].[SsoExternalRoleMapping] WITH CHECK ADD CONSTRAINT [FK_SsoExternalRoleMapping_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
