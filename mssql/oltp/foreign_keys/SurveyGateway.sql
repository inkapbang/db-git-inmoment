ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_PhoneNumber_AudioOption]
   FOREIGN KEY([audioOptionObjectId]) REFERENCES [dbo].[AudioOption] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_SurveyGateway_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_SurveyGateway_ContestRulesConfig]
   FOREIGN KEY([contestRulesConfigObjectId]) REFERENCES [dbo].[ContestRulesConfig] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK__SurveyGat__defau__0095D40B]
   FOREIGN KEY([defaultOfferCodeObjectId]) REFERENCES [dbo].[OfferCode] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_SurveyGateway_DisabledLocationSurvey]
   FOREIGN KEY([disabledLocationSurveyObjectId]) REFERENCES [dbo].[Survey] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_SurveyGateway_dnisNamedPoolObjectId]
   FOREIGN KEY([dnisNamedPoolObjectId]) REFERENCES [dbo].[DnisNamedPool] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_PhoneNumber_Prompt2]
   FOREIGN KEY([failurePromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK__SurveyGat__organ__28A3C565]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_SurveyGateway_WebSurveyStyle]
   FOREIGN KEY([webSurveyStyleObjectId]) REFERENCES [dbo].[WebSurveyStyle] ([objectId])

GO
ALTER TABLE [dbo].[SurveyGateway] WITH CHECK ADD CONSTRAINT [FK_SurveyGateway_WebSurveyTheme]
   FOREIGN KEY([webSurveyThemeObjectId]) REFERENCES [dbo].[WebSurveyTheme] ([objectId])

GO
