ALTER TABLE [dbo].[SurveyGatewayVanityUrl] WITH CHECK ADD CONSTRAINT [FK_SurveyGatewayVanityUrl_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])
   ON DELETE CASCADE

GO
