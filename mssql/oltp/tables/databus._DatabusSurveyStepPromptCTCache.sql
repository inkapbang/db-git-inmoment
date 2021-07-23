CREATE TABLE [databus].[_DatabusSurveyStepPromptCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [surveyStepObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyStepPromptCTCache_surveyStepObjectId_promptObjectId_sequence] PRIMARY KEY CLUSTERED ([surveyStepObjectId], [promptObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyStepPromptCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyStepPromptCTCache] ([ctVersion], [ctSurrogateKey])

GO
