CREATE TABLE [dbo].[OrganizationEmailTemplateSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [enabled] [tinyint] NOT NULL,
   [fromOverride] [tinyint] NOT NULL,
   [overrideAddress] [varchar](100) NULL

   ,CONSTRAINT [PK_OrganizationEmailTemplateSettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationEmailTemplateSettings_organizationObjectId] ON [dbo].[OrganizationEmailTemplateSettings] ([organizationObjectId])

GO
