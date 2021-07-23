CREATE TABLE [databus].[_DatabusPromptEventTriggerLocationAttributeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerLocationAttributeCTCache_promptEventObjectId_attributeObjectId] PRIMARY KEY CLUSTERED ([promptEventObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerLocationAttributeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerLocationAttributeCTCache] ([ctVersion], [ctSurrogateKey])

GO
