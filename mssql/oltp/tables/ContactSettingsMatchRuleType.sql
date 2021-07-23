CREATE TABLE [dbo].[ContactSettingsMatchRuleType] (
   [contactSettingsMatchRuleObjectId] [int] NOT NULL,
   [matchRuleType] [int] NOT NULL

   ,CONSTRAINT [PK_ContactSettingsMatchRuleType] PRIMARY KEY CLUSTERED ([contactSettingsMatchRuleObjectId], [matchRuleType])
)


GO
