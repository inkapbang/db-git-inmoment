ALTER TABLE [dbo].[PageLogEntryOrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_PageLogEntryOrganizationalUnit_PageLogEntry]
   FOREIGN KEY([pageLogEntryObjectId]) REFERENCES [dbo].[PageLogEntry] ([objectId])

GO
