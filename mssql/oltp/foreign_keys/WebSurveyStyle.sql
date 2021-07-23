ALTER TABLE [dbo].[WebSurveyStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyStyle_Image_backArrow]
   FOREIGN KEY([backArrowObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyStyle_Image_banner]
   FOREIGN KEY([bannerObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyStyle_Image_nextArrow]
   FOREIGN KEY([nextArrowObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyStyle_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[WebSurveyStyle] WITH CHECK ADD CONSTRAINT [FK_WebSurveyStyle_Image_sidebarImage]
   FOREIGN KEY([sidebarImageObjectId]) REFERENCES [dbo].[Image] ([objectId])

GO
