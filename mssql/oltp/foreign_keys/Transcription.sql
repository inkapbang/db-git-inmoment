ALTER TABLE [dbo].[Transcription] WITH CHECK ADD CONSTRAINT [FK_Transcription_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
