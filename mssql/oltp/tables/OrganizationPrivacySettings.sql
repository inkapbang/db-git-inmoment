CREATE TABLE [dbo].[OrganizationPrivacySettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [gdprEnabled] [bit] NOT NULL,
   [disableEmailShare] [bit] NULL

   ,CONSTRAINT [PK_OrganizationPrivacySettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationPrivacySettings_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationPrivacySettings_organizationObjectId] ON [dbo].[OrganizationPrivacySettings] ([organizationObjectId])

GO
