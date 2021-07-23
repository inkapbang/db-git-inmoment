ALTER TABLE [dbo].[PushDestination] WITH CHECK ADD CONSTRAINT [FK_PushDestination_FtpProfile]
   FOREIGN KEY([ftpProfileObjectId]) REFERENCES [dbo].[FtpProfile] ([objectId])

GO
ALTER TABLE [dbo].[PushDestination] WITH CHECK ADD CONSTRAINT [FK_PushDestination_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
