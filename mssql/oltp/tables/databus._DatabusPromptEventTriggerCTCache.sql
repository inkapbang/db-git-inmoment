CREATE TABLE [databus].[_DatabusPromptEventTriggerCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerCTCache_promptEventObjectId_dataFieldOptionObjectId] PRIMARY KEY CLUSTERED ([promptEventObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerCTCache] ([ctVersion], [ctSurrogateKey])

GO
