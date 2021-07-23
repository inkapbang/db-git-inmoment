CREATE TABLE [dbo].[SystemAnnouncementOrganization] (
   [systemAnnouncementObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__SystemAn__26423B320E2CFC83] PRIMARY KEY CLUSTERED ([systemAnnouncementObjectId], [organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_SystemAnnouncementOrganization_Org] ON [dbo].[SystemAnnouncementOrganization] ([organizationObjectId])

GO
