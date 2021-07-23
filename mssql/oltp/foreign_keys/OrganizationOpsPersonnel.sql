ALTER TABLE [dbo].[OrganizationOpsPersonnel] WITH CHECK ADD CONSTRAINT [FK_OrganizationOpsPersonnel_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationOpsPersonnel] WITH CHECK ADD CONSTRAINT [FK_OrganizationOpsPersonnel_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
