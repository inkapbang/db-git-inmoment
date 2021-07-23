ALTER TABLE [dbo].[UserAccountLocationCategory] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocationCategory_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[UserAccountLocationCategory] WITH CHECK ADD CONSTRAINT [FK_UserAccountLocationCategory_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
