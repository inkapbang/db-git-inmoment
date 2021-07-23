ALTER TABLE [dbo].[TagGlobalMapping] WITH CHECK ADD CONSTRAINT [FK_TagGlobalMapping_globalTag]
   FOREIGN KEY([globalTagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
ALTER TABLE [dbo].[TagGlobalMapping] WITH CHECK ADD CONSTRAINT [FK_TagGlobalMapping_orgTag]
   FOREIGN KEY([orgTagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
