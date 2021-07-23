CREATE TABLE [dbo].[SurveyRequestParam] (
   [SurveyRequestObjectId] [int] NOT NULL,
   [param_name] [varchar](255) NOT NULL,
   [param_value] [varchar](255) NOT NULL,
   [param_value2] [nvarchar](255) NULL

   ,CONSTRAINT [PK_SurveyRequestParam] PRIMARY KEY CLUSTERED ([SurveyRequestObjectId], [param_name])
)

CREATE NONCLUSTERED INDEX [IX_SurveyRequestParam_by_SurveyRequest] ON [dbo].[SurveyRequestParam] ([SurveyRequestObjectId])

GO
