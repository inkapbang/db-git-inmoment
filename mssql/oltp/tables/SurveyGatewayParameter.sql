CREATE TABLE [dbo].[SurveyGatewayParameter] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [sequence] [int] NULL,
   [alias] [varchar](25) NOT NULL,
   [surveyGatewayObjectId] [int] NULL,
   [promptObjectId] [int] NOT NULL,
   [sourceType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [defaultValue] [varchar](2000) NULL,
   [required] [bit] NULL

   ,CONSTRAINT [PK_SurveyGatewayParameter] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_GatewayParameter_By_Gateway] ON [dbo].[SurveyGatewayParameter] ([surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGatewayParameter_promptObjectId] ON [dbo].[SurveyGatewayParameter] ([promptObjectId])

GO
