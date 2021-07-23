CREATE TABLE [databus].[_DatabusPromptEventTriggersOptionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventTriggerObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersOptionCTCache_promptEventTriggerObjectId_dataFieldOptionObjectId] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersOptionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersOptionCTCache] ([ctVersion], [ctSurrogateKey])

GO
