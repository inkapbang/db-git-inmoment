CREATE TABLE [dbo].[OrganizationNotificationSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [notificationOptOut] [bit] NOT NULL,
   [defaultOptOut] [bit] NOT NULL
      CONSTRAINT [DF_OrganizationNotificationSettings_defaultOptOut] DEFAULT ((0))

   ,CONSTRAINT [PK_OrganizationNotificationSettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationNotificationSettings_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationNotificationSettings_organizationObjectId] ON [dbo].[OrganizationNotificationSettings] ([organizationObjectId])

GO
