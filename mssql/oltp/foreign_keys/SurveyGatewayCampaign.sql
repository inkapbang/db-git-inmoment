ALTER TABLE [dbo].[SurveyGatewayCampaign] WITH CHECK ADD CONSTRAINT [FK_SurveyGatewayCampaign_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGatewayCampaign] WITH CHECK ADD CONSTRAINT [FK_SurveyGatewayCampaign_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
