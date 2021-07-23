CREATE TABLE [databus].[_DatabusPromptEventTriggerLocationCategoryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerLocationCategoryCTCache_promptEventObjectId_locationCategoryObjectId] PRIMARY KEY CLUSTERED ([promptEventObjectId], [locationCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerLocationCategoryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerLocationCategoryCTCache] ([ctVersion], [ctSurrogateKey])

GO
