ALTER TABLE [dbo].[ContestRulesConfig] WITH CHECK ADD CONSTRAINT [FK_ContestRulesConfig_Org]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
