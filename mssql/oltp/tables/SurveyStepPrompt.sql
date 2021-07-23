CREATE TABLE [dbo].[SurveyStepPrompt] (
   [surveyStepObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NULL
      CONSTRAINT [DF__SurveySte__versi__40F05042] DEFAULT (0)

   ,CONSTRAINT [PK_SurveyStepPrompt] PRIMARY KEY CLUSTERED ([surveyStepObjectId], [promptObjectId], [sequence])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_SurveyStepPrompt_Prompt_Step_sequence] ON [dbo].[SurveyStepPrompt] ([promptObjectId], [surveyStepObjectId], [sequence]) INCLUDE ([version])

GO
