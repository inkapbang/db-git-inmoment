CREATE TABLE [dbo].[surveyresponsescore] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [surveyResponseObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [points] [float] NOT NULL,
   [pointsPossible] [float] NOT NULL,
   [score] [float] NOT NULL,
   [count] [int] NOT NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF__SurveyRes__versi__7524215B] DEFAULT ((0)),
   [totalWeight] [float] NOT NULL

   ,CONSTRAINT [PK_SurveyresponseScore3] PRIMARY KEY CLUSTERED ([objectId], [surveyResponseObjectId])
)

CREATE NONCLUSTERED INDEX [IX_SurveyResponseScore_by_field3] ON [dbo].[surveyresponsescore] ([dataFieldObjectId]) INCLUDE ([surveyResponseObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyResponseScore_by_SurveyResponse_DataField3] ON [dbo].[surveyresponsescore] ([surveyResponseObjectId], [dataFieldObjectId])

GO
