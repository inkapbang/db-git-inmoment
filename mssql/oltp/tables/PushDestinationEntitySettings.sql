CREATE TABLE [dbo].[PushDestinationEntitySettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [pushDestinationObjectId] [int] NOT NULL,
   [enabled] [bit] NOT NULL,
   [entityType] [int] NOT NULL,
   [apiVersion] [int] NOT NULL,
   [batchSize] [int] NOT NULL,
   [pushIntervalMinutes] [int] NOT NULL
      CONSTRAINT [DF_PushDestinationEntitySettings_pushIntervalMinutes] DEFAULT ((60)),
   [url] [nvarchar](max) NULL,
   [notificationIntervalCount] [int] NULL,
   [notificationTimeUnit] [tinyint] NULL,
   [embedContact] [bit] NULL

   ,CONSTRAINT [PK_PushDestinationEntitySettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PushDestinationEntitySettings_PushDestination] ON [dbo].[PushDestinationEntitySettings] ([pushDestinationObjectId])

GO
