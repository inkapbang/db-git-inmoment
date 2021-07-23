ALTER TABLE [dbo].[SurveyGatewayParameter] WITH CHECK ADD CONSTRAINT [FK_SurveyGatewayParameter_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGatewayParameter] WITH CHECK ADD CONSTRAINT [FK_SurveyGatewayParameter_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
