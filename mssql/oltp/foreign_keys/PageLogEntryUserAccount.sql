ALTER TABLE [dbo].[PageLogEntryUserAccount] WITH CHECK ADD CONSTRAINT [FK_PageLogEntryUserAccount_PageLogEntry]
   FOREIGN KEY([pageLogEntryObjectId]) REFERENCES [dbo].[PageLogEntry] ([objectId])

GO
ALTER TABLE [dbo].[PageLogEntryUserAccount] WITH CHECK ADD CONSTRAINT [FK_PageLogEntryUserAccount_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
