CREATE TABLE [dbo].[SsoExternalRoleMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [externalRole] [nvarchar](100) NOT NULL

   ,CONSTRAINT [IX_SsoExternalRoleMapping_UniqueExternalRole] UNIQUE NONCLUSTERED ([organizationObjectId], [externalRole])
   ,CONSTRAINT [PK_SsoExternalRoleMapping] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SsoExternalHierarchyMapping_Organization] ON [dbo].[SsoExternalRoleMapping] ([organizationObjectId])

GO
