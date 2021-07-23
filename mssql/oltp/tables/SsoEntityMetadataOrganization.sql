CREATE TABLE [dbo].[SsoEntityMetadataOrganization] (
   [ssoEntityMetadataObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_SsoEntityMetadataOrganization] PRIMARY KEY CLUSTERED ([ssoEntityMetadataObjectId], [organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_SsoEntityMetadataOrganization_Organization] ON [dbo].[SsoEntityMetadataOrganization] ([organizationObjectId])

GO
