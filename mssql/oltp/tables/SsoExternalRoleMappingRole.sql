CREATE TABLE [dbo].[SsoExternalRoleMappingRole] (
   [externalRoleMappingObjectId] [int] NOT NULL,
   [role] [int] NOT NULL

   ,CONSTRAINT [PK_SsoExternalRoleMappingRole] PRIMARY KEY CLUSTERED ([externalRoleMappingObjectId], [role])
)


GO
