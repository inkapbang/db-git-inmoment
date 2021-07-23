CREATE TABLE [dbo].[_KeyDriverRankings] (
   [objectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [peerCount] [int] NOT NULL,
   [generationDate] [datetime] NOT NULL,
   [startDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [unitObjectId] [int] NOT NULL,
   [surveyResponseObjectId] [bigint] NULL

   ,CONSTRAINT [PK_KeyDriverRankings3] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UQ_KeyDriverRankings3] UNIQUE NONCLUSTERED ([unitObjectId], [upliftModelObjectId], [startDate], [endDate], [surveyResponseObjectId])
)


GO
