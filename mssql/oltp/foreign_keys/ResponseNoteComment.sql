ALTER TABLE [dbo].[ResponseNoteComment] WITH CHECK ADD CONSTRAINT [FK_SurveyResponseNoteComment_Locale]
   FOREIGN KEY([localeKey]) REFERENCES [dbo].[Locale] ([localeKey])
   ON DELETE CASCADE

GO
