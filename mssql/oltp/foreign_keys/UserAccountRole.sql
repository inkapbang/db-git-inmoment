ALTER TABLE [dbo].[UserAccountRole] WITH CHECK ADD CONSTRAINT [FK__UserAccou__userA__5ADB0ACE]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
