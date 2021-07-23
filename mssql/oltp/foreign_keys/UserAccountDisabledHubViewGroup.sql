ALTER TABLE [dbo].[UserAccountDisabledHubViewGroup] WITH CHECK ADD CONSTRAINT [FK_UserAccountDisabledHubViewGroup_userAccountObjectId]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
