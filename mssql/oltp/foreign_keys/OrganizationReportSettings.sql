ALTER TABLE [dbo].[OrganizationReportSettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationReportSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
