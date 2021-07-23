ALTER TABLE [dbo].[ContestRulesIncentive] WITH CHECK ADD CONSTRAINT [FK_ContestRulesIncentive_Config]
   FOREIGN KEY([contestRulesConfigObjectId]) REFERENCES [dbo].[ContestRulesConfig] ([objectId])

GO
