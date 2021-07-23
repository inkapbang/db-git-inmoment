ALTER TABLE [dbo].[OrganizationAccountManagers] WITH CHECK ADD CONSTRAINT [FK_Organization_UserAccount]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
