CREATE TABLE [dbo].[_KeyDriverRank] (
   [objectId] [int] NOT NULL,
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
   [assignmentType] [int] NULL,
   [assignerAccountId] [int] NULL,
   [engagementDateTime] [datetime] NULL

   ,CONSTRAINT [PK_KeyDriverRank3] PRIMARY KEY CLUSTERED ([objectId])
)


GO
