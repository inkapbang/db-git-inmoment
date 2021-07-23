CREATE TABLE [dbo].[AnalysisTransaction] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [secondsOfSpeech] [float] NOT NULL
      CONSTRAINT [DF_AnalysisTransaction_secondsOfSpeech] DEFAULT ((0)),
   [completionDateTime] [datetime] NOT NULL
      CONSTRAINT [DF_AnalysisTransaction_completionDateTime] DEFAULT (getdate()),
   [version] [int] NOT NULL
      CONSTRAINT [DF_AnalysisTransaction_version] DEFAULT ((1))

   ,CONSTRAINT [PK_AnalysisTransaction] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AnalysisTransaction_Organization] ON [dbo].[AnalysisTransaction] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_AnalysisTransaction_UserAccount] ON [dbo].[AnalysisTransaction] ([userAccountObjectId])

GO
