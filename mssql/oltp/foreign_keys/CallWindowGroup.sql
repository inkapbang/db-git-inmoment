ALTER TABLE [dbo].[CallWindowGroup] WITH CHECK ADD CONSTRAINT [FK_CallWindowGroup_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
