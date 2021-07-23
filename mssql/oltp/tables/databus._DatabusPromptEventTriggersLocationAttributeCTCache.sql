CREATE TABLE [databus].[_DatabusPromptEventTriggersLocationAttributeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersLocationAttributeCTCache_promptEventTriggerObjectId_attributeObjectId] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersLocationAttributeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersLocationAttributeCTCache] ([ctVersion], [ctSurrogateKey])

GO
