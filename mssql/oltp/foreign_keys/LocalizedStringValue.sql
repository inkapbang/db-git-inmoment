ALTER TABLE [dbo].[LocalizedStringValue] WITH CHECK ADD CONSTRAINT [FK_LocalizedStringValue_Locale]
   FOREIGN KEY([localeKey]) REFERENCES [dbo].[Locale] ([localeKey])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[LocalizedStringValue] WITH CHECK ADD CONSTRAINT [FK_LocalizedStringValue_LocalizedString]
   FOREIGN KEY([localizedStringObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])
   ON DELETE CASCADE

GO
