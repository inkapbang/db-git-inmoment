CREATE TABLE [databus].[_DatabusPromptEventTriggerParseRuleOptionsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerParseRuleOptionsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerParseRuleOptionsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerParseRuleOptionsCTCache] ([ctVersion], [ctSurrogateKey])

GO
