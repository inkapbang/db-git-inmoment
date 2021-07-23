CREATE TABLE [dbo].[SystemAnnouncement] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [downtimeStartDateTime] [datetime] NOT NULL,
   [downtimeStartDate] [datetime] NOT NULL,
   [downtimeStartTime] [datetime] NOT NULL,
   [downtimeEndDateTime] [datetime] NOT NULL,
   [downtimeDuration] [int] NOT NULL,
   [downtimePeriod] [int] NOT NULL,
   [displayDismissableMinutes] [int] NOT NULL,
   [displayNonDismissableMinutes] [int] NOT NULL,
   [displayMessage] [int] NOT NULL,
   [dismissableStartDateTime] [datetime] NOT NULL,
   [nonDismissableStartDateTime] [datetime] NOT NULL,
   [description] [varchar](500) NOT NULL,
   [customTitleObjectId] [int] NULL,
   [customMessageObjectId] [int] NULL,
   [announcementType] [int] NOT NULL
      CONSTRAINT [DF_SystemAnnouncement_announcementType] DEFAULT ((0))

   ,CONSTRAINT [PK_SystemAnnouncement] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SystemAnnouncement_customMessageObjectId] ON [dbo].[SystemAnnouncement] ([customMessageObjectId])
CREATE NONCLUSTERED INDEX [IX_SystemAnnouncement_customTitleObjectId] ON [dbo].[SystemAnnouncement] ([customTitleObjectId])

GO
