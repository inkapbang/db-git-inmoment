ALTER TABLE [dbo].[PolicyRespondentIdentifier] WITH CHECK ADD CONSTRAINT [FK_PolicyRespondentIdentifier_BaseAccessPolicy]
   FOREIGN KEY([policyObjectId]) REFERENCES [dbo].[BaseAccessPolicy] ([objectId])

GO
