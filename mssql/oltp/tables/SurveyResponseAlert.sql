CREATE TABLE [dbo].[SurveyResponseAlert] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [surveyResponseObjectId] [int] NOT NULL,
   [eventConditionType] [int] NULL,
   [triggerDataFieldObjectId] [int] NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF_SurveyResponseAlert_version] DEFAULT ((0)),
   [alertObjectId] [int] NULL

   ,CONSTRAINT [PK__SurveyResponseAl__6E7723D0] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SurveyResponseAlert_alertObjectId] ON [dbo].[SurveyResponseAlert] ([alertObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyResponseAlert_by_ResponseAndTrigger] ON [dbo].[SurveyResponseAlert] ([surveyResponseObjectId], [triggerDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyResponseAlert_by_SurveyResponse] ON [dbo].[SurveyResponseAlert] ([surveyResponseObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyResponseAlert_by_TriggerField] ON [dbo].[SurveyResponseAlert] ([triggerDataFieldObjectId])

GO
