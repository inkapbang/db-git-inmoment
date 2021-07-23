ALTER TABLE [dbo].[KeyEntryOrganization] WITH CHECK ADD CONSTRAINT [FK_KeyEntryOrganization_KeyEntry]
   FOREIGN KEY([keyEntryObjectId]) REFERENCES [dbo].[KeyEntry] ([objectId])

GO
ALTER TABLE [dbo].[KeyEntryOrganization] WITH CHECK ADD CONSTRAINT [FK_KeyEntryOrganization_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
