CREATE TABLE [dbo].[OrganizationLocale] (
   [organizationObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [internalSupport] [int] NULL,
   [externalSupport] [int] NULL

   ,CONSTRAINT [PK_OrganizationLocale] PRIMARY KEY NONCLUSTERED ([organizationObjectId], [localeKey])
)

CREATE CLUSTERED INDEX [IX_OrganizationLocale_by_Organization] ON [dbo].[OrganizationLocale] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_OrganizationLocale_localeKey] ON [dbo].[OrganizationLocale] ([localeKey])
CREATE NONCLUSTERED INDEX [IX_OrganizationLocale_objectId] ON [dbo].[OrganizationLocale] ([objectId])

GO
