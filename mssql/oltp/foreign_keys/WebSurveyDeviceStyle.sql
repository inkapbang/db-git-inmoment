ALTER TABLE [dbo].[WebSurveyDeviceStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyStyleDevice_WebSurveyStyle]
   FOREIGN KEY([objectId]) REFERENCES [dbo].[WebSurveyStyle] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyDeviceStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyDeviceStyle_WebSurveyStyle_Parent]
   FOREIGN KEY([parentWebSurveyStyleObjectId]) REFERENCES [dbo].[WebSurveyStyle] ([objectId])

GO
