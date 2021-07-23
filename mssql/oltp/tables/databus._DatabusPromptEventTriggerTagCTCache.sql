CREATE TABLE [databus].[_DatabusPromptEventTriggerTagCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerTagCTCache_promptEventObjectId_tagObjectId] PRIMARY KEY CLUSTERED ([promptEventObjectId], [tagObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerTagCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerTagCTCache] ([ctVersion], [ctSurrogateKey])

GO
