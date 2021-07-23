CREATE TABLE [dbo].[_arbysFocusAreaAnalysis_20180528] (
   [table] [varchar](17) NOT NULL,
   [objectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [peerCount] [int] NOT NULL,
   [generationDate] [datetime] NOT NULL,
   [startDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [unitObjectId] [int] NOT NULL,
   [surveyResponseObjectId] [int] NULL,
   [table2] [varchar](13) NOT NULL,
   [KeyDriverRankObjectId] [int] NOT NULL,
   [KeyDriverRankVersion] [int] NOT NULL,
   [score] [float] NULL,
   [previousScore] [float] NULL,
   [currentPeerRank] [int] NOT NULL,
   [previousPeerRank] [int] NULL,
   [KeyDriverRankPeerCount] [int] NOT NULL,
   [rank] [int] NOT NULL,
   [performanceAttributeObjectId] [int] NOT NULL,
   [keyDriverRankingsObjectId] [int] NOT NULL,
   [strategyRank] [int] NULL,
   [assignmentType] [int] NULL,
   [assignerAccountId] [int] NULL,
   [engagementDateTime] [datetime] NULL,
   [name] [nvarchar](100) NULL
)


GO
