ALTER TABLE [dbo].[AccessEventLog] WITH CHECK ADD CONSTRAINT [FK_AccessEventLog_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
