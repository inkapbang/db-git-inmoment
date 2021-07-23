CREATE TABLE [databus].[_DatabusContactSettingsMatchRuleTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [contactSettingsMatchRuleObjectId] [int] NOT NULL,
   [matchRuleType] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusContactSettingsMatchRuleTypeCTCache_contactSettingsMatchRuleObjectId_matchRuleType] PRIMARY KEY CLUSTERED ([contactSettingsMatchRuleObjectId], [matchRuleType])
)

CREATE NONCLUSTERED INDEX [IX__DatabusContactSettingsMatchRuleTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusContactSettingsMatchRuleTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
