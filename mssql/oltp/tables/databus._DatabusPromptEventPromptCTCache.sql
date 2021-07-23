CREATE TABLE [databus].[_DatabusPromptEventPromptCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventPromptCTCache_promptEventObjectId_promptObjectId_sequence] PRIMARY KEY CLUSTERED ([promptEventObjectId], [promptObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventPromptCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventPromptCTCache] ([ctVersion], [ctSurrogateKey])

GO
