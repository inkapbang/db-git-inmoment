ALTER TABLE [dbo].[ResponseTag] WITH CHECK ADD CONSTRAINT [FK_ResponseTag_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[ResponseTag] WITH CHECK ADD CONSTRAINT [FK_ResponseTag_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
ALTER TABLE [dbo].[ResponseTag] WITH CHECK ADD CONSTRAINT [FK_ResponseTag_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
