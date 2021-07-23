CREATE TABLE [databus].[_DatabusPromptEventTriggersSocialPostTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersSocialPostTypeCTCache_promptEventTriggerObjectId_enumValue] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [enumValue])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersSocialPostTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersSocialPostTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
