ALTER TABLE [dbo].[Account] WITH CHECK ADD CONSTRAINT [FK_Account_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
