CREATE TABLE [dbo].[SystemAnnouncementUserAccount] (
   [userAccountObjectId] [int] NOT NULL,
   [systemAnnouncementObjectId] [int] NOT NULL,
   [dismissed] [bit] NOT NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF_SystemAnnouncementUserAccount_version] DEFAULT ((0))

   ,CONSTRAINT [PK_SystemAnnouncementUserAccount] PRIMARY KEY CLUSTERED ([userAccountObjectId], [systemAnnouncementObjectId])
)

CREATE NONCLUSTERED INDEX [IX_SystemAnnouncementUserAccount_SystemAnnouncement] ON [dbo].[SystemAnnouncementUserAccount] ([systemAnnouncementObjectId])

GO
