ALTER TABLE [dbo].[PasswordHistory] WITH CHECK ADD CONSTRAINT [FK_PasswordHistory_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
