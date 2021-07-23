CREATE TABLE [databus].[_DatabusPromptEventTriggersExclusionReasonCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersExclusionReasonCTCache_promptEventTriggerObjectId_enumValue] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [enumValue])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersExclusionReasonCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersExclusionReasonCTCache] ([ctVersion], [ctSurrogateKey])

GO
