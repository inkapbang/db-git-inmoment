CREATE TABLE [dbo].[OrganizationSessionReplaySettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [organizationObjectId] [int] NOT NULL,
   [sessionReplayType] [int] NULL,
   [recordingHistoryPeriod] [int] NULL,
   [lastModifiedTime] [datetime] NOT NULL
       DEFAULT (getdate())

   ,CONSTRAINT [PK_OrganizationSessionReplaySettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UC_OrganizationSessionReplaySettings] UNIQUE NONCLUSTERED ([organizationObjectId])
)


GO
