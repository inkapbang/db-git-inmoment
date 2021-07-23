ALTER TABLE [dbo].[UserAccountLocation] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocation_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[UserAccountLocation] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocation_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
