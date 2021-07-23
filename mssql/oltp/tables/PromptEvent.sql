CREATE TABLE [dbo].[PromptEvent] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [description] [varchar](2000) NULL,
   [promptObjectId] [int] NULL,
   [sequence] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [conditionType] [int] NULL,
   [conditionDataFieldObjectId] [int] NULL,
   [conditionOperatorType] [int] NULL,
   [conditionValue] [varchar](100) NULL,
   [actionMarkAsAlert] [bit] NULL,
   [actionAudioOptionObjectId] [int] NULL,
   [actionResponseNote] [varchar](max) NULL,
   [actionSurveyObjectId] [int] NULL,
   [actionStopEvents] [bit] NULL,
   [actionPromptLimit] [int] NULL,
   [actionDateOfServiceType] [int] NULL,
   [actionSendAlertToLocations] [bit] NULL,
   [actionAlertMessage] [varchar](512) NULL,
   [actionFieldToSetObjectId] [int] NULL,
   [actionOptionToSetObjectId] [int] NULL,
   [actionValueToSet] [varchar](100) NULL,
   [actionAssignmentType] [int] NULL,
   [actionAssignmentLocationCategoryTypeObjectId] [int] NULL,
   [actionResponseStateType] [int] NULL,
   [actionScript] [varchar](max) NULL,
   [actionPromptExecutionType] [int] NULL,
   [actionFieldToAnalyzeObjectId] [int] NULL,
   [actionAnalyzerObjectId] [int] NULL,
   [actionSurveyResponseExclusionReason] [int] NULL,
   [actionClearPrompts] [bit] NULL,
   [actionAlertMessageObjectId] [int] NULL,
   [actionAlertObjectId] [int] NULL,
   [actionRequeue] [bit] NULL,
   [actionAlertSubjectObjectId] [int] NULL,
   [actionRequeueSurveyGatewayObjectId] [int] NULL,
   [actionResponseNoteObjectId] [int] NULL,
   [actionWebSurveyStyleObjectId] [int] NULL,
   [actionSmsMessageObjectId] [int] NULL,
   [surveyInit] [bit] NOT NULL
       DEFAULT ((0)),
   [actionSurveyRequestTimezone] [varchar](50) NULL,
   [skipConfidenceCheck] [bit] NULL,
   [actionAlertMessageHtml] [bit] NULL,
   [conditionTypeParseRule] [int] NULL,
   [conditionParseRuleOptionsObjectId] [int] NULL,
   [actionWebSurveyThemeObjectId] [int] NULL,
   [actionExecutedOnSamePageBehavior] [int] NULL,
   [triggerRules] [varchar](max) NULL

   ,CONSTRAINT [PK_PromptEvent] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEvent_by_Prompt] ON [dbo].[PromptEvent] ([promptObjectId])
CREATE NONCLUSTERED INDEX [PromptEvent_PromptObjectid] ON [dbo].[PromptEvent] ([promptObjectId])

GO
