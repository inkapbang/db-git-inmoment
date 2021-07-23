CREATE TABLE [databus].[_DatabusPromptGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptGroupPromptObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptGroupCTCache_promptGroupPromptObjectId_promptObjectId_sequence] PRIMARY KEY CLUSTERED ([promptGroupPromptObjectId], [promptObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO
