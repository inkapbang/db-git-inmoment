CREATE TABLE [dbo].[OrganizationDomainSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [customFromEmailAddress] [bit] NOT NULL
      CONSTRAINT [DF_OrganizationDomainSettings_defaultCustomEmailDomain] DEFAULT ((0))

   ,CONSTRAINT [PK_OrganizationDomainSettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationDomainSettings_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)


GO
