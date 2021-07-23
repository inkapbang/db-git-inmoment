ALTER TABLE [dbo].[OrganizationLocale] WITH CHECK ADD CONSTRAINT [FK_OrganizationLocale_Locale]
   FOREIGN KEY([localeKey]) REFERENCES [dbo].[Locale] ([localeKey])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[OrganizationLocale] WITH CHECK ADD CONSTRAINT [FK_OrganizationLocale_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
