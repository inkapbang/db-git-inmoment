CREATE TABLE [dbo].[AttemptSetting] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [campaignObjectId] [int] NOT NULL,
   [resultType] [int] NULL,
   [attemptAction] [int] NULL,
   [outsideCallWindowAction] [int] NULL,
   [attemptNumber] [int] NULL,
   [promptObjectId] [int] NULL,
   [nextAttemptMinutes] [int] NOT NULL,
   [defaultSetting] [bit] NOT NULL,
   [version] [int] NOT NULL,
   [attemptType] [int] NULL

   ,CONSTRAINT [PK_AttemptSetting] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AttemptSetting_campaignObjectId] ON [dbo].[AttemptSetting] ([campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_AttemptSetting_promptObjectId] ON [dbo].[AttemptSetting] ([promptObjectId])

GO
