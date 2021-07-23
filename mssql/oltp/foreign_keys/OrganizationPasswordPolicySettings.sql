ALTER TABLE [dbo].[OrganizationPasswordPolicySettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationPasswordPolicySettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
