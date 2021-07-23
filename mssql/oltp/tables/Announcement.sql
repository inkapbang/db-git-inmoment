CREATE TABLE [dbo].[Announcement] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [creationDate] [datetime] NOT NULL,
   [name] [varchar](100) NULL,
   [content] [varchar](max) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [nameObjectId] [int] NOT NULL,
   [contentObjectId] [int] NOT NULL,
   [appAvailability] [tinyint] NULL
       DEFAULT ((1))

   ,CONSTRAINT [PK_Announcement] PRIMARY KEY NONCLUSTERED ([objectId])
   ,CONSTRAINT [UK_Announcement_content] UNIQUE NONCLUSTERED ([contentObjectId])
   ,CONSTRAINT [UK_Announcement_name] UNIQUE NONCLUSTERED ([nameObjectId])
)

CREATE NONCLUSTERED INDEX [IX_Announcement_by_Org_Date] ON [dbo].[Announcement] ([organizationObjectId], [creationDate])

GO
