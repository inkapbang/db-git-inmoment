CREATE TABLE [dbo].[PageCriterionSurvey] (
   [pageCriterionObjectId] [int] NOT NULL,
   [surveyObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionSurvey] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [surveyObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionSurvey_surveyObjectId] ON [dbo].[PageCriterionSurvey] ([surveyObjectId])

GO
