ALTER TABLE [dbo].[OrganizationEmailTemplateSettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationEmailTemplateSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
