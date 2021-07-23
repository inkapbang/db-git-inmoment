ALTER TABLE [dbo].[SsoExternalRoleMappingRole] WITH CHECK ADD CONSTRAINT [FK_SsoExternalRoleMappingRole_SsoExternalRoleMapping]
   FOREIGN KEY([externalRoleMappingObjectId]) REFERENCES [dbo].[SsoExternalRoleMapping] ([objectId])

GO
