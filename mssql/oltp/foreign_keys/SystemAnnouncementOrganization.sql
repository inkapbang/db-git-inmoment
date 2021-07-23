ALTER TABLE [dbo].[SystemAnnouncementOrganization] WITH CHECK ADD CONSTRAINT [FK_SystemAnnouncementOrganization_Org]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
