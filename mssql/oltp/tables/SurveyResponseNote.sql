CREATE TABLE [dbo].[SurveyResponseNote] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [datestamp] [datetime] NOT NULL,
   [surveyResponseObjectId] [int] NULL,
   [userAccountObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [comments] [varchar](5000) NULL,
   [stateType] [int] NOT NULL,
   [sequence] [int] NULL,
   [currentNote] [bit] NULL,
   [commentsObjectId] [int] NULL,
   [datestampUTC] [datetime] NULL

   ,CONSTRAINT [PK_SurveyResponseNote] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SurveyResponseNote_SurveyResponse_dateStamp_UserAccount_stateType] ON [dbo].[SurveyResponseNote] ([surveyResponseObjectId], [datestamp] DESC, [userAccountObjectId], [stateType])
CREATE NONCLUSTERED INDEX [IX_SurveyResponseNote_SurveyResponse_stateType_dateStamp] ON [dbo].[SurveyResponseNote] ([surveyResponseObjectId], [stateType], [datestamp])
CREATE NONCLUSTERED INDEX [IX_SurveyResponseNote_userAccountObjectId] ON [dbo].[SurveyResponseNote] ([userAccountObjectId])

GO
