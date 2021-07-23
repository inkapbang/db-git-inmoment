CREATE TABLE [dbo].[ScorecardScore] (
   [pageObjectId] [int] NOT NULL,
   [scoreFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [showScoreComponents] [bit] NOT NULL
       DEFAULT (0),
   [showTrend] [tinyint] NOT NULL

   ,CONSTRAINT [PK_ScorecardScore] PRIMARY KEY CLUSTERED ([pageObjectId], [scoreFieldObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_ScorecardScore_scoreFieldObjectId] ON [dbo].[ScorecardScore] ([scoreFieldObjectId])

GO
