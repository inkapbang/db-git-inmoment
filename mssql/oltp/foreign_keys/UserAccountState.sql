ALTER TABLE [dbo].[UserAccountState] WITH CHECK ADD CONSTRAINT [FK_UserAccountState_Dashboard]
   FOREIGN KEY([dashboardObjectId]) REFERENCES [dbo].[Dashboard] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[UserAccountState] WITH CHECK ADD CONSTRAINT [FK_UserAccountState_UserAccount]
   FOREIGN KEY([userObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])
   ON DELETE CASCADE

GO
