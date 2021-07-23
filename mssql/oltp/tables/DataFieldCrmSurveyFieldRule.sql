CREATE TABLE [dbo].[DataFieldCrmSurveyFieldRule] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [crmObjectId] [int] NOT NULL,
   [surveyFieldObjectId] [int] NOT NULL,
   [crmSubField] [int] NULL,
   [sequence] [int] NULL,
   [version] [int] NULL

   ,CONSTRAINT [PK_DataFieldCrmSurveyFieldRule] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldCrmSurveyFieldRule_crmObjectId] ON [dbo].[DataFieldCrmSurveyFieldRule] ([crmObjectId])
CREATE NONCLUSTERED INDEX [IX_DataFieldCrmSurveyFieldRule_surveyFieldObjectId] ON [dbo].[DataFieldCrmSurveyFieldRule] ([surveyFieldObjectId])

GO
