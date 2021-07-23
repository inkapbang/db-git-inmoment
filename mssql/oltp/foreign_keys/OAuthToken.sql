ALTER TABLE [dbo].[OAuthToken] WITH CHECK ADD CONSTRAINT [FK_OAuthToken_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
ALTER TABLE [dbo].[OAuthToken] WITH CHECK ADD CONSTRAINT [FK_OAuthToken_WebServiceClientVersion]
   FOREIGN KEY([webServiceClientVersionObjectId]) REFERENCES [dbo].[WebServiceClientVersion] ([objectId])

GO
