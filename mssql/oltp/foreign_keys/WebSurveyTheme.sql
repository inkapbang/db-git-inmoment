ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_Image_backArrow]
   FOREIGN KEY([backArrowObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_Image_backgroundImage]
   FOREIGN KEY([backgroundImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_Image_faviconImage]
   FOREIGN KEY([faviconImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_Image_nextArrow]
   FOREIGN KEY([nextArrowObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_Image_organizationImage]
   FOREIGN KEY([organizationImageObjectid]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyTheme] WITH CHECK ADD CONSTRAINT [FK_WebSurveyTheme_ThemeSettings]
   FOREIGN KEY([themeSettingsObjectId]) REFERENCES [dbo].[ThemeSettings] ([objectId])

GO
