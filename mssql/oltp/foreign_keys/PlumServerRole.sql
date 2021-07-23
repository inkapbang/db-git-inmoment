ALTER TABLE [dbo].[PlumServerRole] WITH CHECK ADD CONSTRAINT [FK_PlumServerRole_PlumServer]
   FOREIGN KEY([plumServerObjectId]) REFERENCES [dbo].[PlumServer] ([objectId])

GO
