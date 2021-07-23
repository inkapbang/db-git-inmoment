CREATE TABLE [dbo].[BaseAccessPolicy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [entityType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [policyType] [int] NOT NULL,
   [timeFrameType] [int] NULL,
   [limit] [int] NOT NULL,
   [limitByType] [int] NULL,
   [offerObjectId] [int] NULL,
   [promptObjectId] [int] NULL,
   [campaignObjectId] [int] NULL,
   [identityType] [int] NULL,
   [periodObjectId] [int] NULL,
   [sequence] [int] NULL,
   [includeIpInFingerprint] [bit] NULL,
   [rangeMinutes] [int] NULL,
   [probabilityBase] [int] NULL,
   [throttle] [int] NULL,
   [exclusionRangeMinutes] [int] NULL,
   [exclusionTimeFrame] [int] NULL,
   [exclusionPeriodObjectId] [int] NULL,
   [blacklistIdentifierType] [int] NULL

   ,CONSTRAINT [PK_BaseAccessPolicy] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_BaseAccessPolicy_campaignId_offerId_promptId] ON [dbo].[BaseAccessPolicy] ([campaignObjectId], [offerObjectId], [promptObjectId])
CREATE NONCLUSTERED INDEX [IX_BaseAccessPolicy_exclusionPeriodObjectId] ON [dbo].[BaseAccessPolicy] ([exclusionPeriodObjectId])
CREATE NONCLUSTERED INDEX [IX_BaseAccessPolicy_offerObjectId] ON [dbo].[BaseAccessPolicy] ([offerObjectId])
CREATE NONCLUSTERED INDEX [IX_BaseAccessPolicy_periodObjectId] ON [dbo].[BaseAccessPolicy] ([periodObjectId])
CREATE NONCLUSTERED INDEX [IX_BaseAccessPolicy_promptObjectId] ON [dbo].[BaseAccessPolicy] ([promptObjectId])

GO
