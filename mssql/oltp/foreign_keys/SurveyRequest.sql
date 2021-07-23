ALTER TABLE [dbo].[SurveyRequest] WITH CHECK ADD CONSTRAINT [FK_SurveyRequest_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[SurveyRequest] WITH CHECK ADD CONSTRAINT [FK_SurveyRequest_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[SurveyRequest] WITH CHECK ADD CONSTRAINT [FK_SurveyRequest_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
