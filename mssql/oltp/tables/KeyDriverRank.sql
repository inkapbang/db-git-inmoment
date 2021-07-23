CREATE TABLE [dbo].[KeyDriverRank] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [score] [float] NULL,
   [previousScore] [float] NULL,
   [currentPeerRank] [int] NOT NULL,
   [previousPeerRank] [int] NULL,
   [peerCount] [int] NOT NULL,
   [rank] [int] NOT NULL,
   [performanceAttributeObjectId] [int] NOT NULL,
   [keyDriverRankingsObjectId] [int] NOT NULL,
   [strategyRank] [int] NULL,
   [assignmentType] [int] NULL
      CONSTRAINT [DF_KeyDriverRank_AssignmentType] DEFAULT ((0)),
   [assignerAccountId] [int] NULL,
   [engagementDateTime] [datetime] NULL

   ,CONSTRAINT [PK_KeyDriverRank] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_KeyDriverRank_AssignerUserAccount] ON [dbo].[KeyDriverRank] ([assignerAccountId])
CREATE NONCLUSTERED INDEX [IX_KeyDriverRank_KeyDriverRankings] ON [dbo].[KeyDriverRank] ([keyDriverRankingsObjectId], [rank]) INCLUDE ([performanceAttributeObjectId])
CREATE NONCLUSTERED INDEX [IX_KeyDriverRank_PerformanceAttribute] ON [dbo].[KeyDriverRank] ([performanceAttributeObjectId])

GO
