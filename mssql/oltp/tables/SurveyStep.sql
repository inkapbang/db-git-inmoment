CREATE TABLE [dbo].[SurveyStep] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [surveyObjectId] [int] NULL,
   [sequence] [int] NULL,
   [completionPoint] [bit] NOT NULL
       DEFAULT (0),
   [version] [int] NOT NULL
       DEFAULT (0),
   [name] [varchar](50) NULL,
   [pageTitle] [varchar](1000) NULL,
   [sidebarObjectId] [int] NULL,
   [stepType] [int] NULL,
   [surveyGatewayObjectId] [int] NULL,
   [cssIdentifier] [varchar](500) NULL,
   [displayNextButton] [bit] NULL
      CONSTRAINT [DF_SurveyStep_displayNextButton] DEFAULT ((1)),
   [displayPreviousButton] [bit] NULL
      CONSTRAINT [DF_SurveyStep_displayPreviousButton] DEFAULT ((1)),
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [PK_SurveyStep] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SurveyStep_by_SidebarObjectId] ON [dbo].[SurveyStep] ([sidebarObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyStep_by_Survey] ON [dbo].[SurveyStep] ([surveyObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyStep_surveyGatewayObjectId] ON [dbo].[SurveyStep] ([surveyGatewayObjectId]) INCLUDE ([objectId])

GO
