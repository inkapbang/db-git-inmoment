ALTER TABLE [dbo].[DataFieldCrmSurveyFieldRule] WITH CHECK ADD CONSTRAINT [FK_DataFieldCrmSurveyFieldRule_crmObjectId]
   FOREIGN KEY([crmObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldCrmSurveyFieldRule] WITH CHECK ADD CONSTRAINT [FK_DataFieldCrmSurveyFieldRule_surveyFieldObjectId]
   FOREIGN KEY([surveyFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
