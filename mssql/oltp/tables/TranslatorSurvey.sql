CREATE TABLE [dbo].[TranslatorSurvey] (
   [userAccountObjectId] [int] NOT NULL,
   [surveyObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_TranslatorSurvey] PRIMARY KEY CLUSTERED ([userAccountObjectId], [surveyObjectId])
)

CREATE NONCLUSTERED INDEX [IX_TranslatorSurvey_surveyObjectId] ON [dbo].[TranslatorSurvey] ([surveyObjectId])

GO
