CREATE TABLE [databus].[_DatabusPromptEventTriggersLocationCategoryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersLocationCategoryCTCache_promptEventTriggerObjectId_locationCategoryObjectId] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [locationCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersLocationCategoryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersLocationCategoryCTCache] ([ctVersion], [ctSurrogateKey])

GO
