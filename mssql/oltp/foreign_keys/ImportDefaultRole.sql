ALTER TABLE [dbo].[ImportDefaultRole] WITH CHECK ADD CONSTRAINT [FK_ImportDefaultRole_ImportDefault]
   FOREIGN KEY([importDefaultObjectId]) REFERENCES [dbo].[ImportDefault] ([objectId])

GO
