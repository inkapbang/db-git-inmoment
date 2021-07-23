ALTER TABLE [dbo].[SurveyStep] WITH CHECK ADD CONSTRAINT [FK_SurveyStep_Image_sidebar]
   FOREIGN KEY([sidebarObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[SurveyStep] WITH CHECK ADD CONSTRAINT [FK_SurveyStep_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
ALTER TABLE [dbo].[SurveyStep] WITH CHECK ADD CONSTRAINT [FK_SurveyStep_Survey]
   FOREIGN KEY([surveyObjectId]) REFERENCES [dbo].[Survey] ([objectId])

GO
