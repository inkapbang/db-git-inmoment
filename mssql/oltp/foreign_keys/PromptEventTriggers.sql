ALTER TABLE [dbo].[PromptEventTriggers] WITH CHECK ADD CONSTRAINT [FK_PromptEventTriggers_PromptEventTriggerParseRuleOptions]
   FOREIGN KEY([parseRuleOptionsObjectId]) REFERENCES [dbo].[PromptEventTriggerParseRuleOptions] ([objectId])
   ON UPDATE CASCADE
   ON DELETE SET NULL

GO
