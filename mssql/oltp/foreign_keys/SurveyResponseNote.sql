ALTER TABLE [dbo].[SurveyResponseNote] WITH CHECK ADD CONSTRAINT [FK__SurveyRes__userA__0836F5D3]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
