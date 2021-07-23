ALTER TABLE [dbo].[TranslatorSurvey] WITH CHECK ADD CONSTRAINT [FK__Translato__surve__3C2B9B25]
   FOREIGN KEY([surveyObjectId]) REFERENCES [dbo].[Survey] ([objectId])

GO
ALTER TABLE [dbo].[TranslatorSurvey] WITH CHECK ADD CONSTRAINT [FK__Translato__userA__3B3776EC]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
