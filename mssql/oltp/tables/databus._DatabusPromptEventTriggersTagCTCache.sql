CREATE TABLE [databus].[_DatabusPromptEventTriggersTagCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersTagCTCache_promptEventTriggerObjectId_tagObjectId] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [tagObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersTagCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersTagCTCache] ([ctVersion], [ctSurrogateKey])

GO
