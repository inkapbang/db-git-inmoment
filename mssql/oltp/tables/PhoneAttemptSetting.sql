CREATE TABLE [dbo].[PhoneAttemptSetting] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [campaignObjectId] [int] NOT NULL,
   [resultType] [int] NOT NULL,
   [attemptAction] [int] NOT NULL,
   [outsideCallWindowAction] [int] NOT NULL,
   [attemptNumber] [int] NOT NULL,
   [promptObjectId] [int] NULL,
   [nextAttemptMinutes] [int] NOT NULL,
   [defaultSetting] [bit] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK__PhoneAttemptSett__48D62D36] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_Campaign_Type_AttemptNumber] UNIQUE NONCLUSTERED ([campaignObjectId], [resultType], [attemptNumber])
)

CREATE NONCLUSTERED INDEX [IX_PhoneAttemptSetting_by_campaign] ON [dbo].[PhoneAttemptSetting] ([campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_PhoneAttemptSetting_promptObjectId] ON [dbo].[PhoneAttemptSetting] ([promptObjectId])

GO
