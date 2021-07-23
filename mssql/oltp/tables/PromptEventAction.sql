CREATE TABLE [dbo].[PromptEventAction] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [actionType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [promptEventObjectId] [int] NULL,
   [alertObjectId] [int] NULL,
   [assignResponseLocationCategoryTypeObjectId] [int] NULL,
   [assignResponseType] [int] NULL,
   [audioOptionObjectId] [int] NULL,
   [dataFieldObjectId] [int] NULL,
   [dataFieldOptionObjectId] [int] NULL,
   [exclusionReason] [int] NULL,
   [executedOnSamePageBehavior] [int] NULL,
   [messageIsHtml] [bit] NULL,
   [messageObjectId] [int] NULL,
   [promptExecutionType] [int] NULL,
   [promptLimit] [int] NULL,
   [responseNoteObjectId] [int] NULL,
   [responseState] [int] NULL,
   [script] [nvarchar](max) NULL,
   [sendToLocations] [bit] NULL,
   [smsMessageObjectId] [int] NULL,
   [subjectObjectId] [int] NULL,
   [surveyGatewayObjectId] [int] NULL,
   [surveyObjectId] [int] NULL,
   [surveyRequestTimezone] [varchar](50) NULL,
   [valueToSet] [nvarchar](500) NULL,
   [webSurveyStyleObjectId] [int] NULL,
   [webSurveyThemeObjectId] [int] NULL,
   [campaignObjectId] [int] NULL,
   [instantEmailSendBehavior] [int] NULL,
   [isFilterByRolesEnabled] [tinyint] NULL

   ,CONSTRAINT [PK_PromptEventAction] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventAction_alertObjectId] ON [dbo].[PromptEventAction] ([alertObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_by_PromptEvent] ON [dbo].[PromptEventAction] ([promptEventObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_campaignObjectId] ON [dbo].[PromptEventAction] ([campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_DataField] ON [dbo].[PromptEventAction] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_DataFieldOption] ON [dbo].[PromptEventAction] ([dataFieldOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_locationCategoryTypeObjectId] ON [dbo].[PromptEventAction] ([assignResponseLocationCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_messageObjectId] ON [dbo].[PromptEventAction] ([messageObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_smsMessageObjectId] ON [dbo].[PromptEventAction] ([smsMessageObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_subjectObjectId] ON [dbo].[PromptEventAction] ([subjectObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_surveyGatewayObjectId] ON [dbo].[PromptEventAction] ([surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventAction_surveyObjectId] ON [dbo].[PromptEventAction] ([surveyObjectId])

GO
