ALTER TABLE [dbo].[PlumServerStatus] WITH CHECK ADD CONSTRAINT [FK_PlumServerStatus_PlumServer]
   FOREIGN KEY([plumServerObjectId]) REFERENCES [dbo].[PlumServer] ([objectId])

GO
