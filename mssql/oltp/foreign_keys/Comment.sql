ALTER TABLE [dbo].[Comment] WITH CHECK ADD CONSTRAINT [FK_Comment_UserAccount]
   FOREIGN KEY([audioTranscriptionUserObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
