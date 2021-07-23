ALTER TABLE [dbo].[CommentAccess] WITH CHECK ADD CONSTRAINT [FK_CommentAccess_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
