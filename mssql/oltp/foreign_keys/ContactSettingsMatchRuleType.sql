ALTER TABLE [dbo].[ContactSettingsMatchRuleType] WITH CHECK ADD CONSTRAINT [FK_ContactSettingsMatchRuleType_contactSettingsMatchRuleObjectId]
   FOREIGN KEY([contactSettingsMatchRuleObjectId]) REFERENCES [dbo].[ContactSettingsMatchRule] ([objectId])

GO
