CREATE TABLE [dbo].[OrganizationOrganizationMetadata] (
   [organizationObjectId] [int] NOT NULL,
   [metadataObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__Organiza__26F9F74530159E2E] PRIMARY KEY CLUSTERED ([organizationObjectId], [metadataObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationOrganizationMetadata_RK_OrganizationOrganizationMetadata_OrganizationMetadata] ON [dbo].[OrganizationOrganizationMetadata] ([metadataObjectId])

GO
