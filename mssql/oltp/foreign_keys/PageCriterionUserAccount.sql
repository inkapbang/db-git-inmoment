ALTER TABLE [dbo].[PageCriterionUserAccount] WITH CHECK ADD CONSTRAINT [FK_PageCriterionUserAccount_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionUserAccount] WITH CHECK ADD CONSTRAINT [FK_PageCriterionUserAccount_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
