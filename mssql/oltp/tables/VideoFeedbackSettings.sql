CREATE TABLE [dbo].[VideoFeedbackSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [videoFeedbackEnabled] [bit] NULL,
   [apiKey] [nvarchar](200) NULL,
   [apiSecret] [nvarchar](200) NULL,
   [monthlyVideoResponseQuota] [int] NULL
       DEFAULT ((0)),
   [apiAccessKey] [nvarchar](200) NULL

   ,CONSTRAINT [PK_VideoFeedbackSettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_VideoFeedbackSettings_Organization] ON [dbo].[VideoFeedbackSettings] ([organizationObjectId])

GO
