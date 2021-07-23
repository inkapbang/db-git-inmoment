ALTER TABLE [dbo].[TermAnnotation] WITH CHECK ADD CONSTRAINT [FK_TermAnnotation_Term]
   FOREIGN KEY([termId]) REFERENCES [dbo].[Term] ([objectId])

GO
