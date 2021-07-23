ALTER TABLE [dbo].[UserAccount] WITH CHECK ADD CONSTRAINT [FK_UserAccount_Locale]
   FOREIGN KEY([localeKey]) REFERENCES [dbo].[Locale] ([localeKey])

GO
