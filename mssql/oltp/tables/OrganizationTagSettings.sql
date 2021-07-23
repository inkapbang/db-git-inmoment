CREATE TABLE [dbo].[OrganizationTagSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [adHocTagsInActiveListening] [bit] NOT NULL

   ,CONSTRAINT [PK_OrganizationTagSettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationTagSettings_organizationObjectId] ON [dbo].[OrganizationTagSettings] ([organizationObjectId])

GO
