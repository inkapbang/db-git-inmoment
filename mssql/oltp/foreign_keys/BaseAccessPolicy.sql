ALTER TABLE [dbo].[BaseAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_BaseAccessPolicy_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[BaseAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_BaseAccessPolicy_exclusionPeriod]
   FOREIGN KEY([exclusionPeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[BaseAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_BaseAccessPolicy_Offer]
   FOREIGN KEY([offerObjectId]) REFERENCES [dbo].[Offer] ([objectId])

GO
ALTER TABLE [dbo].[BaseAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_BaseAccessPolicy_Period]
   FOREIGN KEY([periodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[BaseAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_BaseAccessPolicy_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
