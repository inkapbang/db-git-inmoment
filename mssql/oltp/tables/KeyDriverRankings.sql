CREATE TABLE [dbo].[KeyDriverRankings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [peerCount] [int] NOT NULL,
   [generationDate] [datetime] NOT NULL,
   [startDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [unitObjectId] [int] NOT NULL,
   [surveyResponseObjectId] [bigint] NULL

   ,CONSTRAINT [PK_KeyDriverRankings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UQ_KeyDriverRankings] UNIQUE NONCLUSTERED ([unitObjectId], [upliftModelObjectId], [startDate], [endDate], [surveyResponseObjectId])
)

CREATE NONCLUSTERED INDEX [IX_KeyDriverRankings_upliftModelObjectId] ON [dbo].[KeyDriverRankings] ([upliftModelObjectId])
CREATE NONCLUSTERED INDEX [IX_surveyResponseObjectId] ON [dbo].[KeyDriverRankings] ([surveyResponseObjectId])

GO
