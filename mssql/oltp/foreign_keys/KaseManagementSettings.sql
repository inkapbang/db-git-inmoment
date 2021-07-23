ALTER TABLE [dbo].[KaseManagementSettings] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettings_followUpSurveyGatewayObjectId]
   FOREIGN KEY([followUpSurveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
ALTER TABLE [dbo].[KaseManagementSettings] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettings_kaseCloseCustomSurveyGatewayObjectId]
   FOREIGN KEY([kaseCloseCustomSurveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
ALTER TABLE [dbo].[KaseManagementSettings] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettings_organizationObjectId]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[KaseManagementSettings] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettings_preventedResolutionMultipleChoiceFieldObjectId]
   FOREIGN KEY([preventedResolutionMultipleChoiceFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[KaseManagementSettings] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettings_rootCauseMultipleChoiceFieldObjectId]
   FOREIGN KEY([rootCauseMultipleChoiceFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
