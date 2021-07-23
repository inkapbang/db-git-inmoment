ALTER TABLE [dbo].[BlacklistedIdentifier] WITH CHECK ADD CONSTRAINT [FK_BlacklistedIdentifier_BaseAccessPolicy]
   FOREIGN KEY([baseAccessPolicyObjectId]) REFERENCES [dbo].[BaseAccessPolicy] ([objectId])

GO
