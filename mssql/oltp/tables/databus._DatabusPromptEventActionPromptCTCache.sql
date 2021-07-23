CREATE TABLE [databus].[_DatabusPromptEventActionPromptCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventActionObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventActionPromptCTCache_promptEventActionObjectId_promptObjectId_sequence] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [promptObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventActionPromptCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventActionPromptCTCache] ([ctVersion], [ctSurrogateKey])

GO
