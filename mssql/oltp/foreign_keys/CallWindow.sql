ALTER TABLE [dbo].[CallWindow] WITH CHECK ADD CONSTRAINT [FK_CallWindow_CallWindowGroup]
   FOREIGN KEY([callWindowGroupObjectId]) REFERENCES [dbo].[CallWindowGroup] ([objectId])
   ON DELETE CASCADE

GO
