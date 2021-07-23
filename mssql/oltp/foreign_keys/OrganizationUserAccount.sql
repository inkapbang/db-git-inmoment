ALTER TABLE [dbo].[OrganizationUserAccount] WITH CHECK ADD CONSTRAINT [FK_OrganizationUserAccount_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationUserAccount] WITH CHECK ADD CONSTRAINT [FK_OrganizationUserAccount_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
