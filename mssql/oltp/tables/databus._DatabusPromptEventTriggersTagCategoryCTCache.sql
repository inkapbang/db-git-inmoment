CREATE TABLE [databus].[_DatabusPromptEventTriggersTagCategoryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersTagCategoryCTCache_promptEventTriggerObjectId_tagCategoryObjectId] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [tagCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersTagCategoryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersTagCategoryCTCache] ([ctVersion], [ctSurrogateKey])

GO
