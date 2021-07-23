ALTER TABLE [dbo].[PageLogEntryCustomizableColumns] WITH CHECK ADD CONSTRAINT [FK_PageLogEntryCustomizableColumns_PageLogEntry]
   FOREIGN KEY([pageLogEntryObjectId]) REFERENCES [dbo].[PageLogEntry] ([objectId])
   ON DELETE CASCADE

GO
