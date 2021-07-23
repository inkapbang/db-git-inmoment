CREATE TABLE [databus].[_DatabusPromptEventTriggerTagCategoryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerTagCategoryCTCache_promptEventObjectId_tagCategoryObjectId] PRIMARY KEY CLUSTERED ([promptEventObjectId], [tagCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerTagCategoryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerTagCategoryCTCache] ([ctVersion], [ctSurrogateKey])

GO
