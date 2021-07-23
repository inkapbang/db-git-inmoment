CREATE TABLE [dbo].[PageSchedule] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [pageObjectId] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [periodObjectId] [int] NOT NULL,
   [enabled] [bit] NOT NULL,
   [activeFrom] [datetime] NULL,
   [activeTo] [datetime] NULL,
   [runForType] [int] NOT NULL,
   [formatTypeName] [varchar](50) NOT NULL,
   [version] [int] NOT NULL,
   [delayDays] [int] NULL,
   [titleObjectId] [int] NOT NULL,
   [instructionsObjectId] [int] NOT NULL,
   [sendToLocationUsers] [bit] NULL,
   [overrideTime] [datetime] NULL,
   [deliveryOption] [int] NOT NULL
       DEFAULT ((0)),
   [ftpProfileObjectId] [int] NULL,
   [ftpPath] [varchar](250) NULL,
   [deliveryTitleObjectId] [int] NOT NULL,
   [overrideHour] [int] NULL,
   [sendEmailNotification] [bit] NOT NULL,
   [deliverEmpty] [bit] NOT NULL,
   [overrideDataSourceType] [smallint] NULL

   ,CONSTRAINT [PK_PageSchedule] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_PageSchedule_Instructions] UNIQUE NONCLUSTERED ([instructionsObjectId])
   ,CONSTRAINT [UK_PageSchedule_Title] UNIQUE NONCLUSTERED ([titleObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageSchedule_by_Page] ON [dbo].[PageSchedule] ([pageObjectId], [periodObjectId]) INCLUDE ([activeFrom], [activeTo], [deliveryOption], [ftpProfileObjectId])
CREATE NONCLUSTERED INDEX [IX_PageSchedule_deliveryTitleObjectId] ON [dbo].[PageSchedule] ([deliveryTitleObjectId])
CREATE NONCLUSTERED INDEX [IX_PageSchedule_ftpProfileObjectId] ON [dbo].[PageSchedule] ([ftpProfileObjectId])
CREATE NONCLUSTERED INDEX [IX_PageSchedule_periodObjectId] ON [dbo].[PageSchedule] ([periodObjectId])

GO
